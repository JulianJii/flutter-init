import 'package:fpdart/fpdart.dart';
import 'package:init/core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, UserEntity>> execute({
    required String name,
    required String email,
    required String password,
  }) {
    // 如有需要，可在此处添加验证逻辑
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return Future.value(
        const Left(
          InputFailure(message: 'Name, email, and password cannot be empty'),
        ),
      );
    }

    return _repository.register(name: name, email: email, password: password);
  }
}
