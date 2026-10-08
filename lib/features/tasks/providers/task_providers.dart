import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/task_local_data_source.dart';
import '../data/repositories/task_repository_impl.dart';
import '../domain/repositories/task_repository.dart';
import '../domain/usecases/add_task_use_case.dart';
import '../domain/usecases/delete_task_use_case.dart';
import '../domain/usecases/get_tasks_use_case.dart';
import '../domain/usecases/toggle_task_use_case.dart';
import '../domain/usecases/update_task_use_case.dart';

part 'task_providers.g.dart';

/// 数据层依赖注入提供者
/// 这些提供者负责创建和管理数据层实例

// --- Repository ---
@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(ref.watch(taskLocalDataSourceProvider));
}

// --- Use Cases ---
@Riverpod(keepAlive: true)
GetTasksUseCase getTasksUseCase(Ref ref) {
  return GetTasksUseCase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
AddTaskUseCase addTaskUseCase(Ref ref) {
  return AddTaskUseCase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdateTaskUseCase updateTaskUseCase(Ref ref) {
  return UpdateTaskUseCase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
DeleteTaskUseCase deleteTaskUseCase(Ref ref) {
  return DeleteTaskUseCase(ref.watch(taskRepositoryProvider));
}

@Riverpod(keepAlive: true)
ToggleTaskUseCase toggleTaskUseCase(Ref ref) {
  return ToggleTaskUseCase(ref.watch(taskRepositoryProvider));
}
