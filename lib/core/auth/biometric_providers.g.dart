// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 生物识别认证服务的 provider

@ProviderFor(biometricService)
final biometricServiceProvider = BiometricServiceProvider._();

/// 生物识别认证服务的 provider

final class BiometricServiceProvider
    extends
        $FunctionalProvider<
          BiometricService,
          BiometricService,
          BiometricService
        >
    with $Provider<BiometricService> {
  /// 生物识别认证服务的 provider
  BiometricServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricServiceHash();

  @$internal
  @override
  $ProviderElement<BiometricService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BiometricService create(Ref ref) {
    return biometricService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiometricService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiometricService>(value),
    );
  }
}

String _$biometricServiceHash() => r'90bbbc3bad12cc747e03f2dab0c83b66f7b7f5a4';

/// 检查生物识别认证是否可用的 provider

@ProviderFor(biometricsAvailable)
final biometricsAvailableProvider = BiometricsAvailableProvider._();

/// 检查生物识别认证是否可用的 provider

final class BiometricsAvailableProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// 检查生物识别认证是否可用的 provider
  BiometricsAvailableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricsAvailableProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricsAvailableHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return biometricsAvailable(ref);
  }
}

String _$biometricsAvailableHash() =>
    r'25c41e684f364d5cd6a2233ae059efd587f7d3e7';

/// 获取可用生物识别类型的 provider

@ProviderFor(availableBiometrics)
final availableBiometricsProvider = AvailableBiometricsProvider._();

/// 获取可用生物识别类型的 provider

final class AvailableBiometricsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BiometricType>>,
          List<BiometricType>,
          FutureOr<List<BiometricType>>
        >
    with
        $FutureModifier<List<BiometricType>>,
        $FutureProvider<List<BiometricType>> {
  /// 获取可用生物识别类型的 provider
  AvailableBiometricsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableBiometricsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableBiometricsHash();

  @$internal
  @override
  $FutureProviderElement<List<BiometricType>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BiometricType>> create(Ref ref) {
    return availableBiometrics(ref);
  }
}

String _$availableBiometricsHash() =>
    r'e43fb1433c13a0035b3eb0a4200797af37b5d215';

/// 用于管理认证状态的控制器

@ProviderFor(BiometricAuthController)
final biometricAuthControllerProvider = BiometricAuthControllerProvider._();

/// 用于管理认证状态的控制器
final class BiometricAuthControllerProvider
    extends $NotifierProvider<BiometricAuthController, BiometricAuthState> {
  /// 用于管理认证状态的控制器
  BiometricAuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricAuthControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricAuthControllerHash();

  @$internal
  @override
  BiometricAuthController create() => BiometricAuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiometricAuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiometricAuthState>(value),
    );
  }
}

String _$biometricAuthControllerHash() =>
    r'c70d9b5b868ec2b236bc29675b611ef12b267402';

/// 用于管理认证状态的控制器

abstract class _$BiometricAuthController extends $Notifier<BiometricAuthState> {
  BiometricAuthState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BiometricAuthState, BiometricAuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BiometricAuthState, BiometricAuthState>,
              BiometricAuthState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
