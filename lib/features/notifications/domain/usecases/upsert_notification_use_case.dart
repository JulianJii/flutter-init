import 'package:fpdart/fpdart.dart';
import 'package:flutter_init/core/error/failures.dart';
import 'package:flutter_init/features/notifications/domain/entities/notification_item_entity.dart';
import 'package:flutter_init/features/notifications/domain/repositories/notification_repository.dart';

class UpsertNotificationUseCase {
  final NotificationRepository _repository;

  UpsertNotificationUseCase(this._repository);

  Future<Either<Failure, void>> call(NotificationItemEntity notification) {
    return _repository.upsertNotification(notification);
  }
}
