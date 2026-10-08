import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:init/core/providers/storage_providers.dart';
import 'package:init/gen/l10n/app_localizations.dart';

part 'localization_providers.g.dart';

/// 用于在 SharedPreferences 中存储所选语言代码的键
const _languageCodeKey = 'selected_language_code';

/// 首次启动时使用的语言环境；main.dart 用 persistentLocaleProvider 覆盖它
@Riverpod(keepAlive: true)
Locale defaultLocale(Ref ref) => const Locale('zh');

/// gen-l10n 不生成 isSupported，本地补一个
bool isSupportedLocale(Locale locale) => AppLocalizations.supportedLocales.any(
  (l) => l.languageCode == locale.languageCode,
);

/// 用于持久化和获取用户语言偏好设置的 Provider
@Riverpod(keepAlive: true)
Locale savedLocale(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final savedLanguageCode = prefs.getString(_languageCodeKey);

  if (savedLanguageCode != null &&
      isSupportedLocale(Locale(savedLanguageCode))) {
    return Locale(savedLanguageCode);
  }

  // 默认使用系统语言，若系统语言不受支持则使用中文
  final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
  if (isSupportedLocale(systemLocale)) {
    return systemLocale;
  }

  return const Locale('zh');
}

/// 用于管理带持久化的语言环境状态的 Notifier
@Riverpod(keepAlive: true)
class PersistentLocaleNotifier extends _$PersistentLocaleNotifier {
  static const _languageCodeKey = 'selected_language_code';

  @override
  Locale build() {
    return ref.watch(savedLocaleProvider);
  }

  /// 设置新的语言环境并持久化该选择
  Future<void> setLocale(Locale locale) async {
    if (isSupportedLocale(locale)) {
      final prefs = ref.read(sharedPreferencesProvider);
      await prefs.setString(_languageCodeKey, locale.languageCode);
      state = locale;
    }
  }

  /// 重置为系统语言环境
  Future<void> resetToSystemLocale() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(_languageCodeKey);
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

    if (isSupportedLocale(systemLocale)) {
      state = systemLocale;
    } else {
      state = const Locale('zh');
    }
  }
}
