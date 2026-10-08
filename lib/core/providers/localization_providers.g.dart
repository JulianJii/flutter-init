// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 首次启动时使用的语言环境；main.dart 用 persistentLocaleProvider 覆盖它

@ProviderFor(defaultLocale)
final defaultLocaleProvider = DefaultLocaleProvider._();

/// 首次启动时使用的语言环境；main.dart 用 persistentLocaleProvider 覆盖它

final class DefaultLocaleProvider
    extends $FunctionalProvider<Locale, Locale, Locale>
    with $Provider<Locale> {
  /// 首次启动时使用的语言环境；main.dart 用 persistentLocaleProvider 覆盖它
  DefaultLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'defaultLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$defaultLocaleHash();

  @$internal
  @override
  $ProviderElement<Locale> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Locale create(Ref ref) {
    return defaultLocale(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$defaultLocaleHash() => r'a4c0485e0aab24b3580eeacde23a8b7ea91b4bfd';

/// 用于持久化和获取用户语言偏好设置的 Provider

@ProviderFor(savedLocale)
final savedLocaleProvider = SavedLocaleProvider._();

/// 用于持久化和获取用户语言偏好设置的 Provider

final class SavedLocaleProvider
    extends $FunctionalProvider<Locale, Locale, Locale>
    with $Provider<Locale> {
  /// 用于持久化和获取用户语言偏好设置的 Provider
  SavedLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedLocaleHash();

  @$internal
  @override
  $ProviderElement<Locale> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Locale create(Ref ref) {
    return savedLocale(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$savedLocaleHash() => r'364450ce2fb9e46a46c3a4ec01139966a443b1b2';

/// 用于管理带持久化的语言环境状态的 Notifier

@ProviderFor(PersistentLocaleNotifier)
final persistentLocaleProvider = PersistentLocaleNotifierProvider._();

/// 用于管理带持久化的语言环境状态的 Notifier
final class PersistentLocaleNotifierProvider
    extends $NotifierProvider<PersistentLocaleNotifier, Locale> {
  /// 用于管理带持久化的语言环境状态的 Notifier
  PersistentLocaleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'persistentLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$persistentLocaleNotifierHash();

  @$internal
  @override
  PersistentLocaleNotifier create() => PersistentLocaleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$persistentLocaleNotifierHash() =>
    r'070ffbddceb5f576c209e12a761d83cd98d34656';

/// 用于管理带持久化的语言环境状态的 Notifier

abstract class _$PersistentLocaleNotifier extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
