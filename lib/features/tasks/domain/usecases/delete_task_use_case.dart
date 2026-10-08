import 'package:fpdart/fpdart.dart';
import 'package:init/core/error/failures.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  Future<Either<Failure, void>> call(String id) {
    return _repository.deleteTask(id);
  }
}
