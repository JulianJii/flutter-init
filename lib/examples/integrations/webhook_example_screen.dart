import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/integrations/local_webhook_receiver.dart';
import '../../core/network/integrations/webhook_sender.dart';

/// 演示出站 webhook 模式：使用 HMAC-SHA256 对负载进行签名、发送，
/// 并（在非 Web 平台上）在本地接收和验证，以便你可以同时看到握手的两端。
///
/// 将 `core/network/integrations/webhook_sender.dart` 和
/// `webhook_signature.dart` 复制到真实的功能模块中（例如"当订单发货时通知我们的后端"），
/// 并将 `send()` 指向你自己的端点。
class WebhookExampleScreen extends ConsumerStatefulWidget {
  const WebhookExampleScreen({super.key});

  @override
  ConsumerState<WebhookExampleScreen> createState() =>
      _WebhookExampleScreenState();
}

class _WebhookExampleScreenState extends ConsumerState<WebhookExampleScreen> {
  final _secretController = TextEditingController(text: 'demo-shared-secret');
  final _payloadController = TextEditingController(
    text: '{\n  "event": "order.shipped",\n  "orderId": "1234"\n}',
  );
  final _urlController = TextEditingController();

  LocalWebhookReceiver? _receiver;
  Uri? _receiverUrl;
  final _received = <ReceivedWebhook>[];

  String? _lastResultMessage;
  bool _lastResultWasError = false;
  bool _sending = false;

  @override
  void dispose() {
    _secretController.dispose();
    _payloadController.dispose();
    _urlController.dispose();
    _receiver?.stop();
    super.dispose();
  }

  Future<void> _toggleReceiver() async {
    if (_receiver != null) {
      await _receiver!.stop();
      setState(() {
        _receiver = null;
        _receiverUrl = null;
      });
      return;
    }

    final receiver = LocalWebhookReceiver();
    try {
      final url = await receiver.start(secret: _secretController.text);
      receiver.events.listen((event) {
        setState(() => _received.insert(0, event));
      });
      setState(() {
        _receiver = receiver;
        _receiverUrl = url;
        _urlController.text = '$url';
      });
    } on UnsupportedError catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? '不支持')));
    }
  }

  Future<void> _send() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() {
        _lastResultWasError = true;
        _lastResultMessage = '请先填写要发送到的 URL。';
      });
      return;
    }

    Map<String, dynamic> payload;
    try {
      payload = jsonDecode(_payloadController.text) as Map<String, dynamic>;
    } catch (_) {
      setState(() {
        _lastResultWasError = true;
        _lastResultMessage = '载荷必须是合法的 JSON。';
      });
      return;
    }

    setState(() => _sending = true);
    final result = await ref
        .read(webhookSenderProvider)
        .send(url: url, payload: payload, secret: _secretController.text);
    if (!mounted) return;
    setState(() {
      _sending = false;
      result.match(
        (failure) {
          _lastResultWasError = true;
          _lastResultMessage = failure.message;
        },
        (delivery) {
          _lastResultWasError = false;
          _lastResultMessage =
              '已投递（${delivery.statusCode}）。签名：'
              '${delivery.signature}';
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Webhook 示例')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('1. 本地接收端（仅供开发）', style: _sectionStyle(context)),
          const SizedBox(height: 4),
          Text(
            kIsWeb
                ? 'Web 平台不可用 —— 需要 dart:io 的 HttpServer。'
                      '请在桌面端或移动端运行此示例。'
                : '启动一个回环 HTTP 服务来接收并校验 webhook，'
                      '仅用于本地测试。',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _receiverUrl == null
                              ? '未运行'
                              : '正在监听 $_receiverUrl',
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: kIsWeb ? null : _toggleReceiver,
                        child: Text(_receiver == null ? '启动' : '停止'),
                      ),
                    ],
                  ),
                  if (_received.isNotEmpty) ...[
                    const Divider(),
                    ..._received.take(5).map(_buildReceivedTile),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('2. 发送一个带签名的 webhook', style: _sectionStyle(context)),
          const SizedBox(height: 12),
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(
              labelText: '目标 URL',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _secretController,
            decoration: const InputDecoration(
              labelText: '共享密钥',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _payloadController,
            maxLines: 5,
            style: const TextStyle(fontFamily: 'monospace'),
            decoration: const InputDecoration(
              labelText: 'JSON 载荷',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _sending ? null : _send,
            icon: _sending
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send),
            label: const Text('发送 webhook'),
          ),
          if (_lastResultMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              _lastResultMessage!,
              style: TextStyle(
                color: _lastResultWasError ? Colors.red : Colors.green,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReceivedTile(ReceivedWebhook event) {
    final verified = event.signatureVerified;
    return ListTile(
      dense: true,
      leading: Icon(
        verified == null
            ? Icons.remove_circle_outline
            : (verified ? Icons.verified : Icons.error_outline),
        color: verified == null
            ? Colors.grey
            : (verified ? Colors.green : Colors.red),
      ),
      title: Text('${event.method} ${event.receivedAt.toIso8601String()}'),
      subtitle: Text(event.body, maxLines: 2, overflow: TextOverflow.ellipsis),
    );
  }

  TextStyle? _sectionStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium;
}
