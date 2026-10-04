/// 路由路径常量。唯一 Source of Truth。
///
/// 此前路径常量散落在 `AppConstants`（与 Hive box 名、SharedPreferences key、
/// 动画时长混在一起），新增页面时容易重复或写歪。新路由一律加在这里。
abstract final class AppRoutes {
  /// 初始路由。根据认证状态重定向到 [home] 或 [login]。
  static const String initial = '/';

  static const String home = '/home';
  static const String chat = '/chat';
  static const String survey = '/survey';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String languageSettings = '/settings/language';
  static const String localizationDemo = '/demo/localization';
  static const String localizationAssetsDemo = '/demo/localization/assets';
  static const String tasks = '/tasks';
  static const String notifications = '/notifications';
  static const String posts = '/posts';
  static const String postDetail = '/posts/detail';

  // Examples hub & integration pattern demo routes
  static const String examplesHub = '/examples';
  static const String advancedFeatures = '/examples/advanced';
  static const String localizationDemoScreen = '/examples/localization';
  static const String languageSelectorDemo = '/examples/localization/selector';
  static const String biometricDemo = '/examples/biometric';
  static const String webSocketDemo = '/examples/websocket';
  static const String webhookDemo = '/examples/webhook';
  static const String graphqlDemo = '/examples/graphql';
  static const String grpcDemo = '/examples/grpc';
  static const String backgroundTasksDemo = '/examples/background-tasks';
  static const String fileTransferDemo = '/examples/file-transfer';
}
