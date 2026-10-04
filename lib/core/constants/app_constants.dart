class AppConstants {
  // API 常量
  static const String apiBaseUrl = 'https://api.yourdomain.com';

  // 存储常量
  static const String tokenKey = 'authToken';
  static const String userDataKey = 'userData';
  static const String refreshTokenKey = 'refreshToken';

  // 应用常量
  static const String appName = 'Flutter Riverpod Clean Architecture';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.wode.init';
  static const String iOSAppId = '123456789';
  static const String appcastUrl = 'https://your-appcast-url.com/appcast.xml';

  // 超时时长
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // 路由常量见 core/router/app_routes.dart（唯一 Source of Truth）

  // Hive box names
  static const String settingsBox = 'settings';
  static const String cacheBox = 'cache';
  static const String offlineSyncBox = 'offlineSync';

  // Local storage keys
  static const String tasksStorageKey = 'tasks_data';
  static const String notificationsStorageKey = 'notifications_data';
  static const String postsCacheKey = 'posts_cache_data';

  // Animation durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  // Accessibility
  static const Duration accessibilityTooltipDuration = Duration(seconds: 5);
  static const double accessibilityTouchTargetMinSize = 48.0;
}
