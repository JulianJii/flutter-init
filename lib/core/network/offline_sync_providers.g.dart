// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_sync_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 连通性服务的 Provider

@ProviderFor(connectivity)
final connectivityProvider = ConnectivityProvider._();

/// 连通性服务的 Provider

final class ConnectivityProvider
    extends $FunctionalProvider<Connectivity, Connectivity, Connectivity>
    with $Provider<Connectivity> {
  /// 连通性服务的 Provider
  ConnectivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityHash();

  @$internal
  @override
  $ProviderElement<Connectivity> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Connectivity create(Ref ref) {
    return connectivity(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Connectivity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Connectivity>(value),
    );
  }
}

String _$connectivityHash() => r'15246627d0ae599bcd01382c80d3d25b9e9b4e18';

/// 冲突解决策略的 Provider

@ProviderFor(conflictResolutionStrategy)
final conflictResolutionStrategyProvider =
    ConflictResolutionStrategyProvider._();

/// 冲突解决策略的 Provider

final class ConflictResolutionStrategyProvider
    extends
        $FunctionalProvider<
          ConflictResolutionStrategy,
          ConflictResolutionStrategy,
          ConflictResolutionStrategy
        >
    with $Provider<ConflictResolutionStrategy> {
  /// 冲突解决策略的 Provider
  ConflictResolutionStrategyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'conflictResolutionStrategyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$conflictResolutionStrategyHash();

  @$internal
  @override
  $ProviderElement<ConflictResolutionStrategy> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConflictResolutionStrategy create(Ref ref) {
    return conflictResolutionStrategy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConflictResolutionStrategy value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConflictResolutionStrategy>(value),
    );
  }
}

String _$conflictResolutionStrategyHash() =>
    r'066041a655a5b5a3f60a33f4e8d2b67492ad764e';

/// 离线同步服务的 Provider

@ProviderFor(offlineSyncService)
final offlineSyncServiceProvider = OfflineSyncServiceProvider._();

/// 离线同步服务的 Provider

final class OfflineSyncServiceProvider
    extends
        $FunctionalProvider<
          OfflineSyncService,
          OfflineSyncService,
          OfflineSyncService
        >
    with $Provider<OfflineSyncService> {
  /// 离线同步服务的 Provider
  OfflineSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineSyncServiceHash();

  @$internal
  @override
  $ProviderElement<OfflineSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OfflineSyncService create(Ref ref) {
    return offlineSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OfflineSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OfflineSyncService>(value),
    );
  }
}

String _$offlineSyncServiceHash() =>
    r'54d187ecf87cf7e68b80aae0717262aa3aaf3e66';

/// 待处理更改的 Provider

@ProviderFor(pendingChanges)
final pendingChangesProvider = PendingChangesProvider._();

/// 待处理更改的 Provider

final class PendingChangesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OfflineChange>>,
          List<OfflineChange>,
          Stream<List<OfflineChange>>
        >
    with
        $FutureModifier<List<OfflineChange>>,
        $StreamProvider<List<OfflineChange>> {
  /// 待处理更改的 Provider
  PendingChangesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingChangesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingChangesHash();

  @$internal
  @override
  $StreamProviderElement<List<OfflineChange>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<OfflineChange>> create(Ref ref) {
    return pendingChanges(ref);
  }
}

String _$pendingChangesHash() => r'f8ab5764dc0f7c9e1cb0a64b3e78d05e84a49fa4';

/// 在线状态的 Provider

@ProviderFor(isOnline)
final isOnlineProvider = IsOnlineProvider._();

/// 在线状态的 Provider

final class IsOnlineProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// 在线状态的 Provider
  IsOnlineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isOnlineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isOnlineHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isOnline(ref);
  }
}

String _$isOnlineHash() => r'ab55301f415c979191e163c964036e5632b67249';
