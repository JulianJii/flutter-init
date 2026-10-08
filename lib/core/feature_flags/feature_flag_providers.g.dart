// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 功能开关服务的 Provider

@ProviderFor(featureFlagService)
final featureFlagServiceProvider = FeatureFlagServiceProvider._();

/// 功能开关服务的 Provider

final class FeatureFlagServiceProvider
    extends
        $FunctionalProvider<
          FeatureFlagService,
          FeatureFlagService,
          FeatureFlagService
        >
    with $Provider<FeatureFlagService> {
  /// 功能开关服务的 Provider
  FeatureFlagServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featureFlagServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featureFlagServiceHash();

  @$internal
  @override
  $ProviderElement<FeatureFlagService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FeatureFlagService create(Ref ref) {
    return featureFlagService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeatureFlagService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeatureFlagService>(value),
    );
  }
}

String _$featureFlagServiceHash() =>
    r'2810781091ec8e3a13d7548389af01ed4e009011';

/// 功能开关的 provider（按 key 参数化）

@ProviderFor(featureFlag)
final featureFlagProvider = FeatureFlagFamily._();

/// 功能开关的 provider（按 key 参数化）

final class FeatureFlagProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// 功能开关的 provider（按 key 参数化）
  FeatureFlagProvider._({
    required FeatureFlagFamily super.from,
    required (String, {bool defaultValue}) super.argument,
  }) : super(
         retry: null,
         name: r'featureFlagProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$featureFlagHash();

  @override
  String toString() {
    return r'featureFlagProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as (String, {bool defaultValue});
    return featureFlag(ref, argument.$1, defaultValue: argument.defaultValue);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FeatureFlagProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$featureFlagHash() => r'72a0811548261afaf02e10ff1e91cfe8a4a8ecba';

/// 功能开关的 provider（按 key 参数化）

final class FeatureFlagFamily extends $Family
    with $FunctionalFamilyOverride<bool, (String, {bool defaultValue})> {
  FeatureFlagFamily._()
    : super(
        retry: null,
        name: r'featureFlagProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 功能开关的 provider（按 key 参数化）

  FeatureFlagProvider call(String flagKey, {bool defaultValue = false}) =>
      FeatureFlagProvider._(
        argument: (flagKey, defaultValue: defaultValue),
        from: this,
      );

  @override
  String toString() => r'featureFlagProvider';
}

/// 字符串配置值的 provider

@ProviderFor(stringConfig)
final stringConfigProvider = StringConfigFamily._();

/// 字符串配置值的 provider

final class StringConfigProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// 字符串配置值的 provider
  StringConfigProvider._({
    required StringConfigFamily super.from,
    required (String, {String defaultValue}) super.argument,
  }) : super(
         retry: null,
         name: r'stringConfigProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stringConfigHash();

  @override
  String toString() {
    return r'stringConfigProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    final argument = this.argument as (String, {String defaultValue});
    return stringConfig(ref, argument.$1, defaultValue: argument.defaultValue);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StringConfigProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stringConfigHash() => r'9f59c478f53470b9d21cf2a73cad2d7322a93d73';

/// 字符串配置值的 provider

final class StringConfigFamily extends $Family
    with $FunctionalFamilyOverride<String, (String, {String defaultValue})> {
  StringConfigFamily._()
    : super(
        retry: null,
        name: r'stringConfigProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 字符串配置值的 provider

  StringConfigProvider call(String key, {required String defaultValue}) =>
      StringConfigProvider._(
        argument: (key, defaultValue: defaultValue),
        from: this,
      );

  @override
  String toString() => r'stringConfigProvider';
}

/// 整数配置值的 provider

@ProviderFor(intConfig)
final intConfigProvider = IntConfigFamily._();

/// 整数配置值的 provider

final class IntConfigProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// 整数配置值的 provider
  IntConfigProvider._({
    required IntConfigFamily super.from,
    required (String, {int defaultValue}) super.argument,
  }) : super(
         retry: null,
         name: r'intConfigProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$intConfigHash();

  @override
  String toString() {
    return r'intConfigProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    final argument = this.argument as (String, {int defaultValue});
    return intConfig(ref, argument.$1, defaultValue: argument.defaultValue);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IntConfigProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$intConfigHash() => r'55205a03fab991439480cc5e905074695fffee97';

/// 整数配置值的 provider

final class IntConfigFamily extends $Family
    with $FunctionalFamilyOverride<int, (String, {int defaultValue})> {
  IntConfigFamily._()
    : super(
        retry: null,
        name: r'intConfigProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 整数配置值的 provider

  IntConfigProvider call(String key, {required int defaultValue}) =>
      IntConfigProvider._(
        argument: (key, defaultValue: defaultValue),
        from: this,
      );

  @override
  String toString() => r'intConfigProvider';
}

/// 浮点配置值的 provider

@ProviderFor(doubleConfig)
final doubleConfigProvider = DoubleConfigFamily._();

/// 浮点配置值的 provider

final class DoubleConfigProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  /// 浮点配置值的 provider
  DoubleConfigProvider._({
    required DoubleConfigFamily super.from,
    required (String, {double defaultValue}) super.argument,
  }) : super(
         retry: null,
         name: r'doubleConfigProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$doubleConfigHash();

  @override
  String toString() {
    return r'doubleConfigProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    final argument = this.argument as (String, {double defaultValue});
    return doubleConfig(ref, argument.$1, defaultValue: argument.defaultValue);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DoubleConfigProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$doubleConfigHash() => r'ccd3208c5700d6ff72cdb26f2b970a4c3f230c4f';

/// 浮点配置值的 provider

final class DoubleConfigFamily extends $Family
    with $FunctionalFamilyOverride<double, (String, {double defaultValue})> {
  DoubleConfigFamily._()
    : super(
        retry: null,
        name: r'doubleConfigProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 浮点配置值的 provider

  DoubleConfigProvider call(String key, {required double defaultValue}) =>
      DoubleConfigProvider._(
        argument: (key, defaultValue: defaultValue),
        from: this,
      );

  @override
  String toString() => r'doubleConfigProvider';
}

/// 颜色配置值的 provider

@ProviderFor(colorConfig)
final colorConfigProvider = ColorConfigFamily._();

/// 颜色配置值的 provider

final class ColorConfigProvider extends $FunctionalProvider<Color, Color, Color>
    with $Provider<Color> {
  /// 颜色配置值的 provider
  ColorConfigProvider._({
    required ColorConfigFamily super.from,
    required (String, {Color defaultValue}) super.argument,
  }) : super(
         retry: null,
         name: r'colorConfigProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$colorConfigHash();

  @override
  String toString() {
    return r'colorConfigProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<Color> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Color create(Ref ref) {
    final argument = this.argument as (String, {Color defaultValue});
    return colorConfig(ref, argument.$1, defaultValue: argument.defaultValue);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Color value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Color>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ColorConfigProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$colorConfigHash() => r'1aa3f43b4b3110974d2abfbb702703c3659bc6ef';

/// 颜色配置值的 provider

final class ColorConfigFamily extends $Family
    with $FunctionalFamilyOverride<Color, (String, {Color defaultValue})> {
  ColorConfigFamily._()
    : super(
        retry: null,
        name: r'colorConfigProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 颜色配置值的 provider

  ColorConfigProvider call(String key, {required Color defaultValue}) =>
      ColorConfigProvider._(
        argument: (key, defaultValue: defaultValue),
        from: this,
      );

  @override
  String toString() => r'colorConfigProvider';
}
