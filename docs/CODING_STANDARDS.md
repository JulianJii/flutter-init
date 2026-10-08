---
title: 编码规范
---

# 编码规范 & 最佳实践

为保持代码库的高质量，必须严格遵守以下规范。

> 本文与仓库根的 `AGENTS.md`（AI 速查表，**未入库**）内容保持一致；两处不一致时**以源码为准**，并顺手修正两处文档。

---

## 1. 架构规则

### ❌ 禁止在 Domain 层导入 Flutter
Domain 层必须是纯 Dart，`flutter_riverpod` 也不允许（provider 一律声明在 `providers/` 或 `presentation/providers/`）。
- **错误**：`import 'package:flutter/material.dart';`
- **正确**：`import 'package:equatable/equatable.dart';`

### ❌ 禁止在 Data 层导入 UI
禁止 `package:flutter/material.dart` 和 `package:material_ui/material_ui.dart`。
**例外**：`riverpod_annotation` 允许——data 层文件底部会就近声明自己的 provider（属 DI，不是 UI 依赖）。
- **错误**：`debugPrint('error')`
- **正确**：`logger.e('error')`——`Logger` 实例取自 `loggerProvider` / `taggedLoggerProvider`，
  或用 `LoggerMixin`。注意 API 是单字母短名（`v/d/i/w/e/c/p`），**不存在** `Logger.error(...)`。

### ✅ 始终使用 `fpdart` 处理错误
不要在 Use Case 或 Repository 中抛出异常。
- **错误**：`Future<User>`（抛出异常）
- **正确**：`Future<Either<Failure, User>>`

### ✅ 用例入口方法名沿用现状
`auth` 的用例用 `execute(...)`，其余 feature 用 `call(...)`，两种都在跑——**不要统一**。用例也**不实现** `core/usecases/usecase.dart` 的 `UseCase` 基类（该基类无人使用，唯一引用在废弃的 `core/cli/feature_generator.dart`）。

---

## 2. Riverpod 模式

### ✅ 使用 `@riverpod` 代码生成 `Notifier` / `AsyncNotifier`
Provider **一律**用 `@riverpod` 注解 + `part 'xxx.g.dart';`，生成后以 `<name>Provider` 引用（类 `XNotifier` → `xProvider`，函数 `foo` → `fooProvider`）；改动注解后跑 `dart run build_runner build --delete-conflicting-outputs`。
避免对复杂状态使用 `StateProvider` 或 `ChangeNotifier`。
- **原因**：更好的可测试性和生命周期管理。

### ✅ 分离数据层 DI 与 UI 状态
- **数据 Provider**：`@riverpod` 注解。DataSource provider 在 `data/datasources/*.dart` 底部；Repository/UseCase provider 在 `features/[feature]/providers/`（例外：`authRepositoryProvider`、`secureStorageServiceProvider` 都在 `auth_repository_impl.dart` 底部，别重复声明）。
- **UI Provider**：放置在 `features/[feature]/presentation/providers/` 中，为页面定义 `Notifier`。

### ✅ 在 build() 中使用 `ref.watch`，在回调中使用 `ref.read`
- **watch**：用于触发重建的值。
- **read**：用于一次性操作（如按钮点击）。

---

## 3. 代码风格

### ✅ 显式类型
始终显式声明返回值和参数的类型。
```dart
// Bad
var x = 10;
getUser() { ... }

// Good
int x = 10;
Future<User> getUser() { ... }
```

### ✅ 尾逗号
始终使用尾逗号以获得更好的格式化效果。

### ✅ Feature 内部使用相对导入
同一 feature 内的文件使用相对导入。
```dart
import '../domain/entities/user.dart'; // Good
```
跨 feature 边界或 core 时使用 package 导入。
```dart
import 'package:init/core/logging/logger.dart'; // Good
```

---

## 4. 测试

### ✅ Mock 所有外部依赖
测试 Use Case 时使用 `mocktail` mock Repository，测试 Repository 时 mock RemoteDataSource。

### ✅ 用例测试覆盖成功 + 失败
每个新 Use Case 都要覆盖成功与失败两条路径。现状：只有 auth（`login` / `updateProfile`）、tasks、notifications、posts 有用例测试，chat / survey 及其余 auth 用例**缺**。

### ✅ UI 使用 Golden 测试
对复杂页面使用 Golden 测试以防止视觉回归。
