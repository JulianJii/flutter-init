import 'package:fpdart/fpdart.dart';
import 'package:flutter_init/core/error/failures.dart';
import 'package:flutter_init/features/notifications/domain/entities/notification_item_entity.dart';
import 'package:flutter_init/features/notifications/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<Either<Failure, List<NotificationItemEntity>>> call() {
    return _repository.getNotifications();
  }
}
