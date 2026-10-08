// 网络信息接口
// 提供网络连接信息

import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.g.dart';

/// 网络连接信息的抽象接口
abstract class NetworkInfo {
  /// 检查设备是否已连接到互联网
  Future<bool> get isConnected;
}

/// 使用基本连通性检查实现的 NetworkInfo
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('baidu.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

/// NetworkInfo 的 Riverpod provider
@Riverpod(keepAlive: true)
NetworkInfo networkInfo(Ref ref) => NetworkInfoImpl();
