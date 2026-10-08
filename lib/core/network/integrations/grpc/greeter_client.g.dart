// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'greeter_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 每个订阅者一个新客户端，不再被观察时自动断开连接。

@ProviderFor(grpcGreeterClient)
final grpcGreeterClientProvider = GrpcGreeterClientProvider._();

/// 每个订阅者一个新客户端，不再被观察时自动断开连接。

final class GrpcGreeterClientProvider
    extends
        $FunctionalProvider<
          GrpcGreeterClient,
          GrpcGreeterClient,
          GrpcGreeterClient
        >
    with $Provider<GrpcGreeterClient> {
  /// 每个订阅者一个新客户端，不再被观察时自动断开连接。
  GrpcGreeterClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'grpcGreeterClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$grpcGreeterClientHash();

  @$internal
  @override
  $ProviderElement<GrpcGreeterClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GrpcGreeterClient create(Ref ref) {
    return grpcGreeterClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GrpcGreeterClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GrpcGreeterClient>(value),
    );
  }
}

String _$grpcGreeterClientHash() => r'1ba3378ba80bfc8e016d3a510ec007f624418739';
