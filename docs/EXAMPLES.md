# 代码示例

> **⚠️ 状态警告（先读）**：本文档的示例早于当前代码，**部分片段引用了不存在的 API**——例如 `context.tr('a.b')`、`authNotifierProvider`、`signIn(...)`、`NoParams`、`context.pushNamed('/details', params: ...)`，以及 `core/utils/extensions/*`（该目录目前是空占位）。
> 复制本文任何片段前，请先对照源码；**权威示例是 `lib/features/*` 与 `test/` 中的现有代码**，仓库约定见根目录 `AGENTS.md`。
> 另外示例中的 `print(...)` 在本仓库被 `avoid_print` 禁止，请改用 `core/logging` 的 `Logger`。

本文档提供实用的代码示例，展示如何使用 Flutter Riverpod Clean Architecture 模板的核心功能。

## 使用扩展方法

> **注意**：以下扩展方法位于 `core/utils/extensions/`，当前为占位文件，待后续实现。

### DateTime 扩展方法

```dart
import 'package:init/core/utils/extensions/datetime_extensions.dart';

void exampleDateTimeExtensions() {
  final now = DateTime.now();
  
  // Format the date
  print(now.formatAs('MMMM d, yyyy')); // June 15, 2025
  
  // Get relative time
  print(now.subtract(Duration(minutes: 5)).timeAgo); // 5 minutes ago
  
  // Add time
  final tomorrow = now.addDays(1);
  
  // Check if date is today/tomorrow/yesterday
  print(now.isToday); // true
  print(tomorrow.isTomorrow); // true
  
  // Start/end of period
  final startOfMonth = now.startOfMonth;
  final endOfDay = now.endOfDay;
  
  // Custom week
  final weekStart = now.startOfWeek(firstDayOfWeek: DateTime.monday);
}
```

### BuildContext 扩展方法

```dart
import 'package:init/core/utils/extensions/build_context_extensions.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Screen properties
    final width = context.screenWidth;
    final height = context.screenHeight;
    final isTablet = context.isTablet;
    final isDarkMode = context.isDarkMode;
    
    // Theme shortcuts
    final primaryColor = context.colorScheme.primary;
    final bodyTextStyle = context.textTheme.bodyMedium;
    
    // Localization（formatDate 的 pattern 是命名参数；这些扩展真实存在）
    final welcomeMessage = AppLocalizations.of(context).welcome_message;
    final formattedDate = context.formatDate(DateTime.now());
    final formattedCurrency = context.formatCurrency(19.99);

    // Navigation（go_router 提供的扩展；命名路由用 pathParameters，
    // 且目标路由必须已在 app_router.dart 中注册，否则进 404）
    context.go(AppRoutes.home);
    context.pushNamed('home');

    // UI helpers（不存在 context.showSnackBar，请用 ScaffoldMessenger）
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Operation successful')),
    );
    
    return Container();
  }
}
```

## 功能实现

### 认证功能

#### 领域层（实体）

```dart
// lib/features/auth/domain/entities/user_entity.dart
class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? profilePicture;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });
}
```

#### 领域层（仓储）

```dart
// lib/features/auth/domain/repositories/auth_repository.dart
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
}
```

#### 领域层（用例）

```dart
// lib/features/auth/domain/usecases/login_use_case.dart
// 本仓库用例是普通类 + execute(...)（不是 call()/Params 风格，也没有 NoParams）
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> execute({
    required String email,
    required String password,
  }) {
    if (email.isEmpty || password.isEmpty) {
      return Future.value(
        const Left(InputFailure(message: 'Email and password cannot be empty')),
      );
    }
    return _repository.login(email: email, password: password);
  }
}
```

#### 数据层（模型）

```dart
// lib/features/auth/data/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profilePicture;
  final String? phone;
  
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
    this.phone,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      phone: json['phone'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
      'phone': phone,
    };
  }
  
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      profilePicture: profilePicture,
      phone: phone,
    );
  }
}
```

#### 数据层（数据源）

> **现状**：feature 的数据源当前是**模拟实现**（延时后返回假数据，真实 API 调用被注释；`ApiClient` 尚未被业务使用）。

```dart
// lib/features/auth/data/datasources/auth_remote_data_source.dart
abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<UserModel> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // 数据源内抛 AppException，仓库层负责转 Failure
    final hasNetwork = await AppUtils.hasNetworkConnection();
    if (!hasNetwork) {
      throw NetworkException();
    }

    // 真实实现应调用：await _apiClient.post('/auth/login', data: {...});
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(id: 'user-123', name: 'John Doe', email: email);
  }
}
```

#### 数据层（仓储实现）

```dart
// lib/features/auth/data/repositories/auth_repository_impl.dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorageService;

  AuthRepositoryImpl(this._remoteDataSource, this._secureStorageService);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on Exception {
      return const Left(ServerFailure());
    }
  }
    }
  }
  
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _secureStorageService.delete(key: AppConstants.tokenKey);
      return const Right(null);
    } on Exception {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final model = await _remoteDataSource.getCurrentUser();
      return Right(model.toEntity());
    } on Exception {
      return const Left(ServerFailure());
    }
  }
}
```

#### 表现层（Provider）

```dart
// lib/features/auth/providers/auth_providers.dart
// 注意：authRepositoryProvider 实际定义在 auth_repository_impl.dart 底部
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});
```

#### 表现层（Notifier - Riverpod 3 模式）

```dart
// lib/features/auth/presentation/providers/auth_provider.dart
// provider 名为 authProvider（类式 @riverpod 生成时 XNotifier → xProvider，同一命名规则）
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final useCase = ref.read(loginUseCaseProvider);
    final result = await useCase.execute(email: email, password: password);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        errorMessage: failure.message,
      ),
      (user) => state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
        errorMessage: null,
      ),
    );
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final useCase = ref.read(logoutUseCaseProvider);
    final result = await useCase.execute(); // 用例方法统一叫 execute，不存在 NoParams

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (_) => state = const AuthState(),
    );
  }
}
```

#### 表现层（状态）

```dart
// lib/features/auth/presentation/providers/auth_state.dart
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final UserEntity? user;
  final String? errorMessage;
  
  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });
  
  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    UserEntity? user,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
```

#### 表现层（页面）

```dart
// lib/features/auth/presentation/screens/login_screen.dart
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // 真实签名：login({required String email, required String password})
      ref.read(authProvider.notifier).login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider); // 不是 authNotifierProvider
    final l10n = AppLocalizations.of(context); // 没有 context.tr()

    return Scaffold(
      appBar: AppBar(title: Text(l10n.login)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: l10n.email),
                validator: (value) {
                  final v = value ?? '';
                  if (v.isEmpty) {
                    // 现有 ARB 没有 email_required；需先在 zh/en 两个 ARB 中新增该 key
                    return l10n.email_required;
                  }
                  if (!v.contains('@')) {
                    return l10n.email_invalid; // 同上，需先新增 key
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: l10n.password),
                obscureText: true,
                validator: (value) {
                  final v = value ?? '';
                  if (v.isEmpty) {
                    return l10n.password_required; // 同上，需先新增 key
                  }
                  if (v.length < 6) {
                    return l10n.password_too_short; // 同上，需先新增 key
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (authState.isLoading)
                const CircularProgressIndicator()
              else ...[
                if (authState.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      authState.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed: _handleLogin,
                  child: Text(l10n.login),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
```

更多代码示例请参见项目中的 `lib/examples` 目录。
