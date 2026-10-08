---
title: Architecture Guide
---

# 架构指南

本项目遵循严格的 **Clean Architecture** 原则，并使用 **Riverpod 3**（基于代码生成）适配 Flutter。核心目标是关注点分离和可测试性。

> **怎么读这篇**：必须/禁止类的规则以 `docs/CODING_STANDARDS.md` 为准，本文只讲分层与接线；示例按**规范写法**给出，**与源码不一致时以源码为准**。

---

## 1. 依赖规则

本架构中最重要的规则：**源代码依赖只能指向内部。**

```mermaid
graph TD
    Presentation[Presentation Layer (Flutter)] --> Domain[Domain Layer (Pure Dart)]
    Data[Data Layer (Impl)] --> Domain
    DI[providers/ (Riverpod DI)] -.创建.-> Data
```

- **Domain 层**：对 Flutter、Data 和 Presentation 一无所知。
- **Data 层**：了解 Domain。实现 Domain 中定义的接口。
- **Presentation 层**：只了解 Domain。**不 import data**，数据靠 `ref.read(xxxUseCaseProvider)` 拿（provider 定义在 `providers/`）。
- **箭头只指向 Domain**。Presentation 与 data 之间没有 import 关系，全靠 DI 在运行时接线。

---

## 2. 分层详解

### 🟡 Domain 层（核心）
**路径：** `lib/features/[feature]/domain/`

这是您功能的核心，包含业务逻辑。
- **依赖**：仅限纯 Dart。（例外：`fpdart`、`equatable`）。
- **实体**：继承 `Equatable` 的简单数据类。
- **仓库（接口）**：数据操作可能性的抽象定义。
- **用例**：封装单个业务操作（例如 `LoginUseCase`、`SendMessageUseCase`）。
  `core/usecases/usecase.dart` 的 `UseCase` 基类**无人使用**，新用例不要实现它（`call()` 只是普通方法名，不是接口实现）。

**用例示例**（`lib/features/tasks/domain/usecases/add_task_use_case.dart`）：
```dart
class AddTaskUseCase {
  final TaskRepository _repository; // 依赖接口，不是实现

  AddTaskUseCase(this._repository);

  Future<Either<Failure, TaskEntity>> call(TaskEntity task) {
    // 业务规则（"标题不能为空"）属于 domain，不属于 UI
    if (task.title.trim().isEmpty) {
      return Future.value(
        const Left(InputFailure(message: 'Task title cannot be empty')),
      );
    }
    return _repository.addTask(task);
  }
}
```

> ⚠️ **入口方法名不统一**：多数用例用 `call()`（tasks / notifications / posts / survey），
> 但 auth 的 4 个用例用 `execute()`（`LoginUseCase.execute({email, password})` 等）。
> 两种都能跑，`grep` 目标 feature 现有写法跟着用即可——不要顺手"统一"。

### 🔵 Data 层（基础设施）
**路径：** `lib/features/[feature]/data/`

处理数据的获取和存储。
- **依赖**：Domain 层、外部包（Dio、shared_preferences 等）。
- **模型**：实体的扩展，包含 `fromJson`/`toJson` 方法。
- **数据源**：底层数据访问（API 调用、数据库查询）。
- **仓库（实现）**：实现 Domain 接口。将异常映射为失败。

**仓库实现示例：**
```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  // Error handling happens here!
  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _remoteDataSource.login(email: email, password: password);
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
```

> ⚠️ **业务数据源目前全是模拟**：`features/*/data/datasources/` 都是延时后返回假数据，真实 API
> 调用被注释掉，`core/network/api_client.dart` 尚未被任何业务使用。分层结构是真的，数据是假的——
> 照抄示例时别以为 `AuthRemoteDataSource` 已经连上了服务器。

### 🟢 Presentation 层（UI）
**路径：** `lib/features/[feature]/presentation/`

显示数据并处理用户事件。
- **依赖**：Domain 层、Flutter、Riverpod。
- **Provider**：管理 UI 状态（加载中、成功、错误）。
- **页面**：监视 Provider 的简单 Widget。
- **组件**：可复用的组件。

**Notifier 示例：**
```dart
part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() => const AuthState();

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true);
    
    // Use Case injected via Riverpod
    final loginUseCase = ref.read(loginUseCaseProvider);
    final result = await loginUseCase.execute(email: email, password: password);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, errorMessage: failure.message),
      (user) => state = state.copyWith(isLoading: false, isAuthenticated: true, user: user),
    );
  }
}
```

### 🟣 DI 层（粘合剂）
**路径：** `lib/features/[feature]/providers/`

使用 Riverpod 连接各层。实际仓库中 provider **就近声明、位置不统一**：
- DataSource provider 放在 `data/datasources/*.dart` 文件底部（如 `taskLocalDataSourceProvider`、`authRemoteDataSourceProvider`）。
- Repository / UseCase provider 放在 `features/[feature]/providers/`（例外：`authRepositoryProvider`、`secureStorageServiceProvider` 在 `data/repositories/auth_repository_impl.dart` 底部）。
- **新建前先全局搜索是否已有同名 provider。**

```dart
// connect domain interface to data implementation
@riverpod
AuthRepository authRepository(Ref ref) =>
    AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
```

---

## 3. 核心概念与模式

### 函数式错误处理（`fpdart`）
我们不在 Domain 层抛出异常，而是返回 `Either<Failure, Success>`。

- **用户**："我要登录。"
- **用例**：返回 `Either<Failure, User>`。
- **UI**：
  ```dart
  result.fold(
    (failure) => showError(failure),
    (user) => navigateToHome(user),
  );
  ```

### 框架无关性
为保持 Domain/Data 的可测试性，分层的**真实**边界是：

- **Domain 层**：禁止任何 `flutter` 导入（含 `flutter_riverpod`）。可依赖 `fpdart`、`equatable`、`intl`。
- **Data 层**：禁止 `package:flutter/material.dart` / `package:material_ui/material_ui.dart`；
  但**允许** `riverpod_annotation`——因为 data 层文件底部会就近声明自己的 provider
  （`task_local_data_source.dart:43`、`auth_repository_impl.dart` 底部），这是 DI，不是 UI 依赖。
- **日志**：使用 `core/logging/` 的 `Logger`（实例来自 `loggerProvider` / `taggedLoggerProvider`，
  或用 `LoggerMixin`），而非 `print` / `debugPrint`。注意 API 是短名：`logger.e(...)`、`logger.d(...)`、
  `logger.i(...)`、`logger.w(...)`、`logger.v(...)`、`logger.c(...)`、`logger.p(...)`，**没有** `Logger.error(...)`。
- **Context**：永远不要将 `BuildContext` 传递给用例或仓库。

### Provider 组织方式
我们将数据 DI 与 UI 状态分离：
- **`features/[feature]/providers/[feature]_providers.dart`**：提供仓库、用例、数据源（`@riverpod` 注解）。
- **`features/[feature]/presentation/providers/[feature]_provider.dart`**：提供 UI 状态的 `NotifierProvider`（`@riverpod` 类式 Notifier）。

---

## 4. 测试策略

### 单元测试（Domain/Data）
隔离测试逻辑。使用 `mocktail` 模拟依赖。
```dart
test('should return User when login is successful', () async {
  // Arrange
  when(() => mockRepo.login(email: any(named: 'email'), password: any(named: 'password')))
    .thenAnswer((_) async => Right(tUser));
  
  // Act
  final result = await useCase.execute(email: 'test@test.com', password: 'pass');
  
  // Assert
  expect(result, Right(tUser));
});
```

### Golden 测试（Presentation）
逐像素验证 UI 渲染。本仓库使用 `zoloto`（不是 alchemist / golden_toolkit）：
```dart
void main() {
  testGoldenWidgets('LoginScreen golden test', (tester) async {
    await expectMatchTestEnvironments(
      'login_screen',
      tester: tester,
      widget: const ProviderScope(child: LoginScreen()),
    );
  });
}
```
全局外壳与 1.5% 容差配置在 `test/flutter_test_config.dart`；图片输出到同目录 `goldens/*.png`；刷新：`flutter test --update-goldens`。
