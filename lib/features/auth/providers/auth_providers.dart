import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/usecases/login_use_case.dart';
import '../domain/usecases/logout_use_case.dart';
import '../domain/usecases/register_use_case.dart';
import '../domain/usecases/update_profile_use_case.dart';

part 'auth_providers.g.dart';

/// 数据层依赖注入 providers
/// 这些 providers 负责创建和管理数据层实例

// 注意：authRepositoryProvider 定义在 auth_repository_impl.dart 中

// --- 用例 ---
@Riverpod(keepAlive: true)
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
LogoutUseCase logoutUseCase(Ref ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
RegisterUseCase registerUseCase(Ref ref) {
  return RegisterUseCase(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
UpdateProfileUseCase updateProfileUseCase(Ref ref) {
  return UpdateProfileUseCase(ref.watch(authRepositoryProvider));
}
