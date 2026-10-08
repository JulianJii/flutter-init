import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/notification_local_data_source.dart';
import '../data/repositories/notification_repository_impl.dart';
import '../domain/repositories/notification_repository.dart';
import '../domain/usecases/clear_notifications_use_case.dart';
import '../domain/usecases/get_notifications_use_case.dart';
import '../domain/usecases/mark_notification_read_use_case.dart';
import '../domain/usecases/upsert_notification_use_case.dart';

part 'notification_feature_providers.g.dart';

/// 数据层依赖注入提供者
/// 这些提供者负责创建和管理数据层实例

// --- Repository ---
@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl(
    ref.watch(notificationLocalDataSourceProvider),
  );
}

// --- Use Cases ---
@Riverpod(keepAlive: true)
GetNotificationsUseCase getNotificationsUseCase(Ref ref) {
  return GetNotificationsUseCase(ref.watch(notificationRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpsertNotificationUseCase upsertNotificationUseCase(Ref ref) {
  return UpsertNotificationUseCase(ref.watch(notificationRepositoryProvider));
}

@Riverpod(keepAlive: true)
MarkNotificationReadUseCase markNotificationReadUseCase(Ref ref) {
  return MarkNotificationReadUseCase(
    ref.watch(notificationRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase(Ref ref) {
  return MarkAllNotificationsReadUseCase(
    ref.watch(notificationRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
ClearNotificationsUseCase clearNotificationsUseCase(Ref ref) {
  return ClearNotificationsUseCase(ref.watch(notificationRepositoryProvider));
}
