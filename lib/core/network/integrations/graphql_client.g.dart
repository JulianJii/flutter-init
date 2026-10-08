// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 每个 [endpoint] 一个客户端，这样屏幕可以与多个 GraphQL API 通信
/// 而不会共享 header/拦截器。

@ProviderFor(graphQLClient)
final graphQLClientProvider = GraphQLClientFamily._();

/// 每个 [endpoint] 一个客户端，这样屏幕可以与多个 GraphQL API 通信
/// 而不会共享 header/拦截器。

final class GraphQLClientProvider
    extends $FunctionalProvider<GraphQLClient, GraphQLClient, GraphQLClient>
    with $Provider<GraphQLClient> {
  /// 每个 [endpoint] 一个客户端，这样屏幕可以与多个 GraphQL API 通信
  /// 而不会共享 header/拦截器。
  GraphQLClientProvider._({
    required GraphQLClientFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'graphQLClientProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$graphQLClientHash();

  @override
  String toString() {
    return r'graphQLClientProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GraphQLClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GraphQLClient create(Ref ref) {
    final argument = this.argument as String;
    return graphQLClient(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GraphQLClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GraphQLClient>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GraphQLClientProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$graphQLClientHash() => r'39a99dc1063f65e31028561170b13f4dec8e88cc';

/// 每个 [endpoint] 一个客户端，这样屏幕可以与多个 GraphQL API 通信
/// 而不会共享 header/拦截器。

final class GraphQLClientFamily extends $Family
    with $FunctionalFamilyOverride<GraphQLClient, String> {
  GraphQLClientFamily._()
    : super(
        retry: null,
        name: r'graphQLClientProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 每个 [endpoint] 一个客户端，这样屏幕可以与多个 GraphQL API 通信
  /// 而不会共享 header/拦截器。

  GraphQLClientProvider call(String endpoint) =>
      GraphQLClientProvider._(argument: endpoint, from: this);

  @override
  String toString() => r'graphQLClientProvider';
}
