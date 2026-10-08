// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 更新服务的 Provider

@ProviderFor(updateService)
final updateServiceProvider = UpdateServiceProvider._();

/// 更新服务的 Provider

final class UpdateServiceProvider
    extends $FunctionalProvider<UpdateService, UpdateService, UpdateService>
    with $Provider<UpdateService> {
  /// 更新服务的 Provider
  UpdateServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateServiceHash();

  @$internal
  @override
  $ProviderElement<UpdateService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateService create(Ref ref) {
    return updateService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateService>(value),
    );
  }
}

String _$updateServiceHash() => r'8ffebaef0c8b1c36b6141a6a7b36a328ca3adfdf';

/// 用于检查是否有可用更新的 Provider

@ProviderFor(updateCheck)
final updateCheckProvider = UpdateCheckProvider._();

/// 用于检查是否有可用更新的 Provider

final class UpdateCheckProvider
    extends
        $FunctionalProvider<
          AsyncValue<UpdateCheckResult>,
          UpdateCheckResult,
          FutureOr<UpdateCheckResult>
        >
    with
        $FutureModifier<UpdateCheckResult>,
        $FutureProvider<UpdateCheckResult> {
  /// 用于检查是否有可用更新的 Provider
  UpdateCheckProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateCheckProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateCheckHash();

  @$internal
  @override
  $FutureProviderElement<UpdateCheckResult> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UpdateCheckResult> create(Ref ref) {
    return updateCheck(ref);
  }
}

String _$updateCheckHash() => r'ce6c70ea79bd2f373c65016aa5003003230b912b';

/// 更新信息的 Provider

@ProviderFor(updateInfo)
final updateInfoProvider = UpdateInfoProvider._();

/// 更新信息的 Provider

final class UpdateInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<UpdateInfo?>,
          UpdateInfo?,
          FutureOr<UpdateInfo?>
        >
    with $FutureModifier<UpdateInfo?>, $FutureProvider<UpdateInfo?> {
  /// 更新信息的 Provider
  UpdateInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateInfoHash();

  @$internal
  @override
  $FutureProviderElement<UpdateInfo?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UpdateInfo?> create(Ref ref) {
    return updateInfo(ref);
  }
}

String _$updateInfoHash() => r'e9a5d429cf97e61a12b669094046f372d26e1b45';

/// 更新流程的控制器

@ProviderFor(UpdateController)
final updateControllerProvider = UpdateControllerProvider._();

/// 更新流程的控制器
final class UpdateControllerProvider
    extends $AsyncNotifierProvider<UpdateController, UpdateCheckResult> {
  /// 更新流程的控制器
  UpdateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateControllerHash();

  @$internal
  @override
  UpdateController create() => UpdateController();
}

String _$updateControllerHash() => r'60e4a9be8fb9e195a1831dc670e1e59402f00532';

/// 更新流程的控制器

abstract class _$UpdateController extends $AsyncNotifier<UpdateCheckResult> {
  FutureOr<UpdateCheckResult> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<UpdateCheckResult>, UpdateCheckResult>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UpdateCheckResult>, UpdateCheckResult>,
              AsyncValue<UpdateCheckResult>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
