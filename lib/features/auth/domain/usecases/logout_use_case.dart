import 'package:fpdart/fpdart.dart';
import 'package:flutter_init/core/error/failures.dart';
import 'package:flutter_init/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, void>> execute() {
    return _repository.logout();
  }
}
