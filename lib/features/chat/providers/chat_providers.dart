import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/chat_remote_data_source.dart';
import '../data/repositories/chat_repository_impl.dart';
import '../domain/repositories/chat_repository.dart';
import '../domain/usecases/observe_messages_use_case.dart';
import '../domain/usecases/send_message_use_case.dart';

part 'chat_providers.g.dart';

/// 数据层依赖注入 providers
/// 这些 providers 负责创建和管理数据层实例

// --- 数据源 ---
@Riverpod(keepAlive: true)
ChatRemoteDataSource chatRemoteDataSource(Ref ref) {
  return ChatRemoteDataSourceImpl();
}

// --- 仓库 ---
@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) {
  return ChatRepositoryImpl(ref.watch(chatRemoteDataSourceProvider));
}

// --- 用例 ---
@Riverpod(keepAlive: true)
ObserveMessagesUseCase observeMessagesUseCase(Ref ref) {
  return ObserveMessagesUseCase(ref.watch(chatRepositoryProvider));
}

@Riverpod(keepAlive: true)
SendMessageUseCase sendMessageUseCase(Ref ref) {
  return SendMessageUseCase(ref.watch(chatRepositoryProvider));
}
