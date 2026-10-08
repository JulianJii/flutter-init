import 'package:fpdart/fpdart.dart';
import 'package:init/core/error/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository _repository;

  GetTasksUseCase(this._repository);

  Future<Either<Failure, List<TaskEntity>>> call() {
    return _repository.getTasks();
  }
}
