import 'dart:async';
import '../datasources/chat_remote_data_source.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  ChatRepositoryImpl(this._remoteDataSource);

  @override
  Stream<MessageEntity> getMessages() {
    // 获取消息前确保已连接
    _remoteDataSource.connect();
    return _remoteDataSource.messages; // MessageModel 继承自 MessageEntity
  }

  @override
  Future<void> sendMessage(String text) async {
    await _remoteDataSource.sendMessage(text);
  }

  @override
  void dispose() {
    _remoteDataSource.disconnect();
  }
}
