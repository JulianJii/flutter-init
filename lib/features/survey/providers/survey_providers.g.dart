// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 数据层依赖注入 providers
/// 这些 providers 负责创建和管理数据层实例
// --- 数据源 ---

@ProviderFor(surveyRemoteDataSource)
final surveyRemoteDataSourceProvider = SurveyRemoteDataSourceProvider._();

/// 数据层依赖注入 providers
/// 这些 providers 负责创建和管理数据层实例
// --- 数据源 ---

final class SurveyRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          SurveyRemoteDataSource,
          SurveyRemoteDataSource,
          SurveyRemoteDataSource
        >
    with $Provider<SurveyRemoteDataSource> {
  /// 数据层依赖注入 providers
  /// 这些 providers 负责创建和管理数据层实例
  // --- 数据源 ---
  SurveyRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'surveyRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$surveyRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<SurveyRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SurveyRemoteDataSource create(Ref ref) {
    return surveyRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SurveyRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SurveyRemoteDataSource>(value),
    );
  }
}

String _$surveyRemoteDataSourceHash() =>
    r'4828ba4ad7628d66f5142a27e940bbf70584bc2c';

@ProviderFor(surveyRepository)
final surveyRepositoryProvider = SurveyRepositoryProvider._();

final class SurveyRepositoryProvider
    extends
        $FunctionalProvider<
          SurveyRepository,
          SurveyRepository,
          SurveyRepository
        >
    with $Provider<SurveyRepository> {
  SurveyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'surveyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$surveyRepositoryHash();

  @$internal
  @override
  $ProviderElement<SurveyRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SurveyRepository create(Ref ref) {
    return surveyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SurveyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SurveyRepository>(value),
    );
  }
}

String _$surveyRepositoryHash() => r'ad5435f603dd72bb22fbcd2a7b366f0fa19d2467';

@ProviderFor(submitSurveyUseCase)
final submitSurveyUseCaseProvider = SubmitSurveyUseCaseProvider._();

final class SubmitSurveyUseCaseProvider
    extends
        $FunctionalProvider<
          SubmitSurveyUseCase,
          SubmitSurveyUseCase,
          SubmitSurveyUseCase
        >
    with $Provider<SubmitSurveyUseCase> {
  SubmitSurveyUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'submitSurveyUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$submitSurveyUseCaseHash();

  @$internal
  @override
  $ProviderElement<SubmitSurveyUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubmitSurveyUseCase create(Ref ref) {
    return submitSurveyUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubmitSurveyUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubmitSurveyUseCase>(value),
    );
  }
}

String _$submitSurveyUseCaseHash() =>
    r'78b6fd8c6a3599a16bfca1a00a2194317db36bc0';

@ProviderFor(checkUsernameUseCase)
final checkUsernameUseCaseProvider = CheckUsernameUseCaseProvider._();

final class CheckUsernameUseCaseProvider
    extends
        $FunctionalProvider<
          CheckUsernameUseCase,
          CheckUsernameUseCase,
          CheckUsernameUseCase
        >
    with $Provider<CheckUsernameUseCase> {
  CheckUsernameUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkUsernameUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkUsernameUseCaseHash();

  @$internal
  @override
  $ProviderElement<CheckUsernameUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckUsernameUseCase create(Ref ref) {
    return checkUsernameUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckUsernameUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckUsernameUseCase>(value),
    );
  }
}

String _$checkUsernameUseCaseHash() =>
    r'4d45050dd117a71c48ea440dde24deee5589a9ac';
