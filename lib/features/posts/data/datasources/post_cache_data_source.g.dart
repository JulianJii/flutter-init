// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_cache_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(postCacheDataSource)
final postCacheDataSourceProvider = PostCacheDataSourceProvider._();

final class PostCacheDataSourceProvider
    extends
        $FunctionalProvider<
          PostCacheDataSource,
          PostCacheDataSource,
          PostCacheDataSource
        >
    with $Provider<PostCacheDataSource> {
  PostCacheDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postCacheDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postCacheDataSourceHash();

  @$internal
  @override
  $ProviderElement<PostCacheDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PostCacheDataSource create(Ref ref) {
    return postCacheDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostCacheDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostCacheDataSource>(value),
    );
  }
}

String _$postCacheDataSourceHash() =>
    r'928596c5aa6f93677a208e12465d75f3d0ffd7c2';
