// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logger_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 全局日志记录器实例的 Provider
/// （函数名不叫 `logger`，避免与 `LoggerMixin.logger` 等同名成员冲突）

@ProviderFor(appLogger)
final loggerProvider = AppLoggerProvider._();

/// 全局日志记录器实例的 Provider
/// （函数名不叫 `logger`，避免与 `LoggerMixin.logger` 等同名成员冲突）

final class AppLoggerProvider
    extends $FunctionalProvider<Logger, Logger, Logger>
    with $Provider<Logger> {
  /// 全局日志记录器实例的 Provider
  /// （函数名不叫 `logger`，避免与 `LoggerMixin.logger` 等同名成员冲突）
  AppLoggerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loggerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLoggerHash();

  @$internal
  @override
  $ProviderElement<Logger> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Logger create(Ref ref) {
    return appLogger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Logger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Logger>(value),
    );
  }
}

String _$appLoggerHash() => r'2a0e029f5eea3bcd512972c38890ca816021e953';

/// 带特定标签的日志记录器 Provider

@ProviderFor(appTaggedLogger)
final taggedLoggerProvider = AppTaggedLoggerFamily._();

/// 带特定标签的日志记录器 Provider

final class AppTaggedLoggerProvider
    extends $FunctionalProvider<Logger, Logger, Logger>
    with $Provider<Logger> {
  /// 带特定标签的日志记录器 Provider
  AppTaggedLoggerProvider._({
    required AppTaggedLoggerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'taggedLoggerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$appTaggedLoggerHash();

  @override
  String toString() {
    return r'taggedLoggerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Logger> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Logger create(Ref ref) {
    final argument = this.argument as String;
    return appTaggedLogger(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Logger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Logger>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppTaggedLoggerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$appTaggedLoggerHash() => r'78784c1fde02d2f91a9642a688ded7f8c0ef1084';

/// 带特定标签的日志记录器 Provider

final class AppTaggedLoggerFamily extends $Family
    with $FunctionalFamilyOverride<Logger, String> {
  AppTaggedLoggerFamily._()
    : super(
        retry: null,
        name: r'taggedLoggerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 带特定标签的日志记录器 Provider

  AppTaggedLoggerProvider call(String tag) =>
      AppTaggedLoggerProvider._(argument: tag, from: this);

  @override
  String toString() => r'taggedLoggerProvider';
}
