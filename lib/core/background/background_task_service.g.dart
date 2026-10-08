// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_task_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backgroundTaskService)
final backgroundTaskServiceProvider = BackgroundTaskServiceProvider._();

final class BackgroundTaskServiceProvider
    extends
        $FunctionalProvider<
          BackgroundTaskService,
          BackgroundTaskService,
          BackgroundTaskService
        >
    with $Provider<BackgroundTaskService> {
  BackgroundTaskServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundTaskServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundTaskServiceHash();

  @$internal
  @override
  $ProviderElement<BackgroundTaskService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackgroundTaskService create(Ref ref) {
    return backgroundTaskService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackgroundTaskService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackgroundTaskService>(value),
    );
  }
}

String _$backgroundTaskServiceHash() =>
    r'1da4ca76beb663b2d912509a56936e23a1e94df5';
