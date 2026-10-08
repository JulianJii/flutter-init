// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advanced_image.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 图像处理器 Provider

@ProviderFor(imageProcessor)
final imageProcessorProvider = ImageProcessorProvider._();

/// 图像处理器 Provider

final class ImageProcessorProvider
    extends $FunctionalProvider<ImageProcessor, ImageProcessor, ImageProcessor>
    with $Provider<ImageProcessor> {
  /// 图像处理器 Provider
  ImageProcessorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageProcessorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageProcessorHash();

  @$internal
  @override
  $ProviderElement<ImageProcessor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ImageProcessor create(Ref ref) {
    return imageProcessor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageProcessor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageProcessor>(value),
    );
  }
}

String _$imageProcessorHash() => r'62685983a250287e670d1e74fe996e0bbf89ad02';

/// 高级图像配置 Provider

@ProviderFor(advancedImageConfig)
final advancedImageConfigProvider = AdvancedImageConfigProvider._();

/// 高级图像配置 Provider

final class AdvancedImageConfigProvider
    extends
        $FunctionalProvider<
          AdvancedImageConfig,
          AdvancedImageConfig,
          AdvancedImageConfig
        >
    with $Provider<AdvancedImageConfig> {
  /// 高级图像配置 Provider
  AdvancedImageConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'advancedImageConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$advancedImageConfigHash();

  @$internal
  @override
  $ProviderElement<AdvancedImageConfig> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdvancedImageConfig create(Ref ref) {
    return advancedImageConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdvancedImageConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdvancedImageConfig>(value),
    );
  }
}

String _$advancedImageConfigHash() =>
    r'0f477583ca464d8e5210e38b3e0a2d1257da0b80';

/// 已解码图像的内存缓存

@ProviderFor(imageMemoryCache)
final imageMemoryCacheProvider = ImageMemoryCacheProvider._();

/// 已解码图像的内存缓存

final class ImageMemoryCacheProvider
    extends
        $FunctionalProvider<
          CacheManager<ui.Image>,
          CacheManager<ui.Image>,
          CacheManager<ui.Image>
        >
    with $Provider<CacheManager<ui.Image>> {
  /// 已解码图像的内存缓存
  ImageMemoryCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageMemoryCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageMemoryCacheHash();

  @$internal
  @override
  $ProviderElement<CacheManager<ui.Image>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CacheManager<ui.Image> create(Ref ref) {
    return imageMemoryCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheManager<ui.Image> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheManager<ui.Image>>(value),
    );
  }
}

String _$imageMemoryCacheHash() => r'b6da1df8ca375304d2e55b19c9d142614fc97091';

/// 图像缓存键 Provider

@ProviderFor(imageKey)
final imageKeyProvider = ImageKeyFamily._();

/// 图像缓存键 Provider

final class ImageKeyProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// 图像缓存键 Provider
  ImageKeyProvider._({
    required ImageKeyFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'imageKeyProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$imageKeyHash();

  @override
  String toString() {
    return r'imageKeyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    final argument = this.argument as String;
    return imageKey(ref, argument);
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
    return other is ImageKeyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$imageKeyHash() => r'41c264b9e9651dbbe4ad0f47c0e60e339bae9f5d';

/// 图像缓存键 Provider

final class ImageKeyFamily extends $Family
    with $FunctionalFamilyOverride<String, String> {
  ImageKeyFamily._()
    : super(
        retry: null,
        name: r'imageKeyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 图像缓存键 Provider

  ImageKeyProvider call(String imageUrl) =>
      ImageKeyProvider._(argument: imageUrl, from: this);

  @override
  String toString() => r'imageKeyProvider';
}
