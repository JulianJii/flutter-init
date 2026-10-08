// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 每个订阅者一个新 [WebSocketClient]，不再被观察时自动释放。

@ProviderFor(webSocketClient)
final webSocketClientProvider = WebSocketClientProvider._();

/// 每个订阅者一个新 [WebSocketClient]，不再被观察时自动释放。

final class WebSocketClientProvider
    extends
        $FunctionalProvider<WebSocketClient, WebSocketClient, WebSocketClient>
    with $Provider<WebSocketClient> {
  /// 每个订阅者一个新 [WebSocketClient]，不再被观察时自动释放。
  WebSocketClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSocketClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSocketClientHash();

  @$internal
  @override
  $ProviderElement<WebSocketClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebSocketClient create(Ref ref) {
    return webSocketClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocketClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocketClient>(value),
    );
  }
}

String _$webSocketClientHash() => r'560d727d757952faa3b53070691a23311488dfc8';
