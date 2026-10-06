// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 当前主题模式（默认跟随系统），选择写入本地存储

@ProviderFor(ThemeModeNotifier)
final themeModeProvider = ThemeModeNotifierProvider._();

/// 当前主题模式（默认跟随系统），选择写入本地存储
final class ThemeModeNotifierProvider
    extends $NotifierProvider<ThemeModeNotifier, ThemeMode> {
  /// 当前主题模式（默认跟随系统），选择写入本地存储
  ThemeModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeNotifierHash();

  @$internal
  @override
  ThemeModeNotifier create() => ThemeModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeNotifierHash() => r'315fbc1bec7cd920b883e811d13de83cb5386fe1';

/// 当前主题模式（默认跟随系统），选择写入本地存储

abstract class _$ThemeModeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 当前配色方案（默认蓝），选择写入本地存储

@ProviderFor(ThemeColorNotifier)
final themeColorProvider = ThemeColorNotifierProvider._();

/// 当前配色方案（默认蓝），选择写入本地存储
final class ThemeColorNotifierProvider
    extends $NotifierProvider<ThemeColorNotifier, AppThemeColor> {
  /// 当前配色方案（默认蓝），选择写入本地存储
  ThemeColorNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeColorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeColorNotifierHash();

  @$internal
  @override
  ThemeColorNotifier create() => ThemeColorNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppThemeColor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppThemeColor>(value),
    );
  }
}

String _$themeColorNotifierHash() =>
    r'8d1de875835c30d8ab6a44321d9e7cfaf358466d';

/// 当前配色方案（默认蓝），选择写入本地存储

abstract class _$ThemeColorNotifier extends $Notifier<AppThemeColor> {
  AppThemeColor build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppThemeColor, AppThemeColor>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppThemeColor, AppThemeColor>,
              AppThemeColor,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// 当前配色对应的浅色/深色主题，仅配色变化时重新生成

@ProviderFor(appThemes)
final appThemesProvider = AppThemesProvider._();

/// 当前配色对应的浅色/深色主题，仅配色变化时重新生成

final class AppThemesProvider
    extends
        $FunctionalProvider<
          ({ThemeData dark, ThemeData light}),
          ({ThemeData dark, ThemeData light}),
          ({ThemeData dark, ThemeData light})
        >
    with $Provider<({ThemeData dark, ThemeData light})> {
  /// 当前配色对应的浅色/深色主题，仅配色变化时重新生成
  AppThemesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemesHash();

  @$internal
  @override
  $ProviderElement<({ThemeData dark, ThemeData light})> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ({ThemeData dark, ThemeData light}) create(Ref ref) {
    return appThemes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({ThemeData dark, ThemeData light}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({ThemeData dark, ThemeData light})>(
        value,
      ),
    );
  }
}

String _$appThemesHash() => r'1d79bb525dae112b61c762ece7c63cd04c60bd6b';
