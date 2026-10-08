// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SurveyNotifier)
final surveyProvider = SurveyNotifierProvider._();

final class SurveyNotifierProvider
    extends $NotifierProvider<SurveyNotifier, SurveyState> {
  SurveyNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'surveyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$surveyNotifierHash();

  @$internal
  @override
  SurveyNotifier create() => SurveyNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SurveyState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SurveyState>(value),
    );
  }
}

String _$surveyNotifierHash() => r'63f2d70450f21d2e648bdf6218dd70d92ca0b497';

abstract class _$SurveyNotifier extends $Notifier<SurveyState> {
  SurveyState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SurveyState, SurveyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SurveyState, SurveyState>,
              SurveyState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
