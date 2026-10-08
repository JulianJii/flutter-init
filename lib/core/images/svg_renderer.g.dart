// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'svg_renderer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SVG 缓存 Provider

@ProviderFor(svgCache)
final svgCacheProvider = SvgCacheProvider._();

/// SVG 缓存 Provider

final class SvgCacheProvider
    extends
        $FunctionalProvider<
          CacheManager<ui.Image>,
          CacheManager<ui.Image>,
          CacheManager<ui.Image>
        >
    with $Provider<CacheManager<ui.Image>> {
  /// SVG 缓存 Provider
  SvgCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'svgCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$svgCacheHash();

  @$internal
  @override
  $ProviderElement<CacheManager<ui.Image>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CacheManager<ui.Image> create(Ref ref) {
    return svgCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheManager<ui.Image> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheManager<ui.Image>>(value),
    );
  }
}

String _$svgCacheHash() => r'49ddd2205949799d36f69e47cf54c7808d7fd016';

/// SVG 渲染器 Provider

@ProviderFor(svgRenderer)
final svgRendererProvider = SvgRendererProvider._();

/// SVG 渲染器 Provider

final class SvgRendererProvider
    extends $FunctionalProvider<SvgRenderer, SvgRenderer, SvgRenderer>
    with $Provider<SvgRenderer> {
  /// SVG 渲染器 Provider
  SvgRendererProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'svgRendererProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$svgRendererHash();

  @$internal
  @override
  $ProviderElement<SvgRenderer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SvgRenderer create(Ref ref) {
    return svgRenderer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SvgRenderer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SvgRenderer>(value),
    );
  }
}

String _$svgRendererHash() => r'e6727c4c235146674abaf2ad3b7f3352e336f3b3';
