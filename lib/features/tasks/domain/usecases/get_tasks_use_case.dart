import 'package:fpdart/fpdart.dart';
import 'package:flutter_init/core/error/failures.dart';
import 'package:flutter_init/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter_init/features/tasks/domain/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository _repository;

  GetTasksUseCase(this._repository);

  Future<Either<Failure, List<TaskEntity>>> call() {
    return _repository.getTasks();
  }
}
