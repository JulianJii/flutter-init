import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class ObserveMessagesUseCase {
  final ChatRepository _repository;

  ObserveMessagesUseCase(this._repository);

  Stream<MessageEntity> call() {
    return _repository.getMessages();
  }
}
