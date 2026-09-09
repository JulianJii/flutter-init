# 项目架构

Flutter Riverpod Clean Architecture 模板遵循 Clean Architecture 原则，采用功能优先的组织方式，并设有核心模块用于共享功能。

## 项目结构

```plaintext
lib/
├── main.dart                     # Application entry point
├── core/                         # Core functionality
│   ├── analytics/                # Analytics services (stub implementation)
│   ├── auth/                     # Biometric authentication
│   ├── background/               # Background task service
│   ├── constants/                # Global constants
│   ├── error/                    # Error handling (Failures & Exceptions)
│   ├── feature_flags/            # Feature flags
│   ├── images/                   # Image utilities
│   ├── localization/             # Localization service & providers
│   ├── logging/                  # Structured logging
│   ├── network/                  # Network handling (ApiClient, offline sync)
│   ├── notifications/            # Push notification system
│   ├── providers/                # Core/global providers
│   ├── router/                   # GoRouter configuration
│   ├── storage/                  # Local storage & caching
│   ├── theme/                    # Theming (flex_color_scheme)
│   ├── ui/                       # Shared UI components
│   ├── updates/                  # App update handling
│   └── utils/                    # Utility functions and extensions
├── examples/                     # Example implementations
│   ├── advanced_features_showcase.dart
│   ├── biometrics_demo.dart
│   ├── cache_example.dart
│   ├── examples_hub_screen.dart
│   ├── integrations/             # Integration examples (WebSocket, gRPC, etc.)
│   ├── language_selector.dart
│   ├── localization_assets_demo.dart
│   ├── localization_demo.dart
│   └── theme_showcase.dart
├── features/                     # Feature modules
│   ├── auth/                     # Authentication feature
│   ├── chat/                     # WebSocket chat feature
│   ├── home/                     # Home screen feature
│   ├── notifications/            # Notifications feature
│   ├── posts/                    # Posts feature
│   ├── settings/                 # App settings feature
│   ├── survey/                   # Complex form survey feature
│   ├── tasks/                    # Tasks feature
│   └── ui_showcase/              # UI component showcase
├── gen/                          # Generated code
└── l10n/                         # Localization resources
    └── arb/                      # ARB translation files (zh, en)
```

## Clean Architecture

每个功能遵循 Clean Architecture 模式，包含三个层次：

```plaintext
feature/
├── data/            # Data layer
│   ├── datasources/ # Remote and local data sources
│   ├── models/      # Data models
│   └── repositories/ # Repository implementations
├── domain/          # Domain layer
│   ├── entities/    # Business objects
│   ├── repositories/ # Repository interfaces
│   └── usecases/    # Business logic
└── presentation/    # Presentation layer
    ├── providers/   # State management
    ├── screens/     # UI screens
    └── widgets/     # UI components
```

## 核心模块

核心模块提供可在各功能间共享的功能：

- **Analytics**：具有隐私控制的全面事件跟踪
- **Authentication**：具有会话管理的安全生物认证
- **Feature Flags**：支持 A/B 测试的运行时功能开关
- **Images**：具有处理、缓存、SVG 支持的高级图像处理
- **Localization**：具有上下文扩展的多语言支持
- **Logging**：具有级别、标签和性能跟踪的结构化日志
- **Notifications**：具有深度链接的完整推送通知系统
- **Error Handling**：用于一致错误处理的自定义 Failure 类层次结构
- **Network**：具有自动错误处理的类型安全 API 客户端
- **Storage**：具有加密支持的敏感数据安全存储
- **Router**：具有 locale 感知导航的 Go Router 集成
- **Constants**：用于一致配置的全局常量
- **Providers**：用于全局状态管理的核心 Provider
- **UI Components**：遵循应用设计系统的可复用 Widget

## 工具扩展

项目包含各种扩展方法以简化常见任务（位于 `core/utils/extensions/`）：

- **BuildContext 扩展**：轻松访问主题、本地化、导航
- **DateTime 扩展**：格式化、比较、操作
- **String 扩展**：验证、格式化、转换
- **Widget 扩展**：内边距、外边距、手势辅助
- **Iterable 扩展**：集合操作工具

> **注意**：当前扩展文件为占位文件，待后续实现。

## 依赖注入

Riverpod 用于依赖注入和状态管理：

```dart
// Define a repository provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiClient = ref.watch(dioProvider);
  final localStorage = ref.watch(sharedPreferencesProvider);
  return UserRepositoryImpl(apiClient, localStorage);
});

// Define a Notifier provider (Riverpod 3 pattern)
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthNotifier(userRepository);
});

// Consume in UI
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    if (authState.isLoading) return LoadingView();
    if (authState.isAuthenticated) return AuthenticatedView(user: authState.user);
    return LoginView();
  }
}
```

如需更详细的架构说明，请参阅[架构指南](https://jessejii.github.io/flutter_init/architecture.html)。
