// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_feature_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 数据层依赖注入提供者
/// 这些提供者负责创建和管理数据层实例
// --- Repository ---

@ProviderFor(notificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

/// 数据层依赖注入提供者
/// 这些提供者负责创建和管理数据层实例
// --- Repository ---

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepository,
          NotificationRepository,
          NotificationRepository
        >
    with $Provider<NotificationRepository> {
  /// 数据层依赖注入提供者
  /// 这些提供者负责创建和管理数据层实例
  // --- Repository ---
  NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'8cfa9c7c37f9f3dfa0edfa90da7155a1ea1e9ef0';

@ProviderFor(getNotificationsUseCase)
final getNotificationsUseCaseProvider = GetNotificationsUseCaseProvider._();

final class GetNotificationsUseCaseProvider
    extends
        $FunctionalProvider<
          GetNotificationsUseCase,
          GetNotificationsUseCase,
          GetNotificationsUseCase
        >
    with $Provider<GetNotificationsUseCase> {
  GetNotificationsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getNotificationsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getNotificationsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetNotificationsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetNotificationsUseCase create(Ref ref) {
    return getNotificationsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetNotificationsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetNotificationsUseCase>(value),
    );
  }
}

String _$getNotificationsUseCaseHash() =>
    r'fe5b99496160ef71d03c61c686e9b216ea73ae71';

@ProviderFor(upsertNotificationUseCase)
final upsertNotificationUseCaseProvider = UpsertNotificationUseCaseProvider._();

final class UpsertNotificationUseCaseProvider
    extends
        $FunctionalProvider<
          UpsertNotificationUseCase,
          UpsertNotificationUseCase,
          UpsertNotificationUseCase
        >
    with $Provider<UpsertNotificationUseCase> {
  UpsertNotificationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upsertNotificationUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upsertNotificationUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpsertNotificationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpsertNotificationUseCase create(Ref ref) {
    return upsertNotificationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpsertNotificationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpsertNotificationUseCase>(value),
    );
  }
}

String _$upsertNotificationUseCaseHash() =>
    r'a37a5277cf25dc6b8c025d6bbb78447cd4b2adb4';

@ProviderFor(markNotificationReadUseCase)
final markNotificationReadUseCaseProvider =
    MarkNotificationReadUseCaseProvider._();

final class MarkNotificationReadUseCaseProvider
    extends
        $FunctionalProvider<
          MarkNotificationReadUseCase,
          MarkNotificationReadUseCase,
          MarkNotificationReadUseCase
        >
    with $Provider<MarkNotificationReadUseCase> {
  MarkNotificationReadUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markNotificationReadUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markNotificationReadUseCaseHash();

  @$internal
  @override
  $ProviderElement<MarkNotificationReadUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MarkNotificationReadUseCase create(Ref ref) {
    return markNotificationReadUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarkNotificationReadUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MarkNotificationReadUseCase>(value),
    );
  }
}

String _$markNotificationReadUseCaseHash() =>
    r'e4098f146a31b6dcbc15df5c78e7e959fadd45ab';

@ProviderFor(markAllNotificationsReadUseCase)
final markAllNotificationsReadUseCaseProvider =
    MarkAllNotificationsReadUseCaseProvider._();

final class MarkAllNotificationsReadUseCaseProvider
    extends
        $FunctionalProvider<
          MarkAllNotificationsReadUseCase,
          MarkAllNotificationsReadUseCase,
          MarkAllNotificationsReadUseCase
        >
    with $Provider<MarkAllNotificationsReadUseCase> {
  MarkAllNotificationsReadUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markAllNotificationsReadUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markAllNotificationsReadUseCaseHash();

  @$internal
  @override
  $ProviderElement<MarkAllNotificationsReadUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MarkAllNotificationsReadUseCase create(Ref ref) {
    return markAllNotificationsReadUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarkAllNotificationsReadUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MarkAllNotificationsReadUseCase>(
        value,
      ),
    );
  }
}

String _$markAllNotificationsReadUseCaseHash() =>
    r'82b0110dc836e1d4ae7c10914c006340e5f6b5e7';

@ProviderFor(clearNotificationsUseCase)
final clearNotificationsUseCaseProvider = ClearNotificationsUseCaseProvider._();

final class ClearNotificationsUseCaseProvider
    extends
        $FunctionalProvider<
          ClearNotificationsUseCase,
          ClearNotificationsUseCase,
          ClearNotificationsUseCase
        >
    with $Provider<ClearNotificationsUseCase> {
  ClearNotificationsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clearNotificationsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clearNotificationsUseCaseHash();

  @$internal
  @override
  $ProviderElement<ClearNotificationsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClearNotificationsUseCase create(Ref ref) {
    return clearNotificationsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClearNotificationsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClearNotificationsUseCase>(value),
    );
  }
}

String _$clearNotificationsUseCaseHash() =>
    r'a3afbaf3a4ca71e1437381a219f4f406f79c9632';
