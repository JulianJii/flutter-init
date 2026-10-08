import 'package:fpdart/fpdart.dart';
import 'package:init/core/error/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class ToggleTaskUseCase {
  final TaskRepository _repository;

  ToggleTaskUseCase(this._repository);

  Future<Either<Failure, TaskEntity>> call(String id) {
    return _repository.toggleTaskCompletion(id);
  }
}
