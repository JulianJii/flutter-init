// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostsNotifier)
final postsProvider = PostsNotifierProvider._();

final class PostsNotifierProvider
    extends $NotifierProvider<PostsNotifier, PostsState> {
  PostsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsNotifierHash();

  @$internal
  @override
  PostsNotifier create() => PostsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostsState>(value),
    );
  }
}

String _$postsNotifierHash() => r'347e903c4d8de6f524b97de1d2c662b510aeeebe';

abstract class _$PostsNotifier extends $Notifier<PostsState> {
  PostsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PostsState, PostsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostsState, PostsState>,
              PostsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
