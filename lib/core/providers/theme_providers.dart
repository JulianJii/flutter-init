import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:init/core/providers/storage_providers.dart';
import 'package:init/core/theme/app_theme.dart';

part 'theme_providers.g.dart';

/// 本地存储中主题模式的键
const String _themeModeKey = 'selected_theme_mode';

/// 本地存储中配色方案的键
const String _themeColorKey = 'selected_theme_color';

/// 解析持久化字符串；为空或非法值回落到跟随系统
ThemeMode _themeModeFromStorage(String? raw) => ThemeMode.values.firstWhere(
  (ThemeMode mode) => mode.name == raw,
  orElse: () => ThemeMode.system,
);

/// 当前主题模式（默认跟随系统），选择写入本地存储
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return _themeModeFromStorage(prefs.getString(_themeModeKey));
  }

  /// 设置主题模式并持久化
  Future<void> set(ThemeMode mode) async {
    if (state == mode) {
      return;
    }

    await ref
        .read(sharedPreferencesProvider)
        .setString(_themeModeKey, mode.name);
    state = mode;
  }
}

/// 当前配色方案（默认蓝），选择写入本地存储
@riverpod
class ThemeColorNotifier extends _$ThemeColorNotifier {
  @override
  AppThemeColor build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return AppThemeColor.fromStorage(prefs.getString(_themeColorKey));
  }

  /// 设置配色方案并持久化
  Future<void> set(AppThemeColor color) async {
    if (state == color) {
      return;
    }

    await ref
        .read(sharedPreferencesProvider)
        .setString(_themeColorKey, color.name);
    state = color;
  }
}

/// 当前配色对应的浅色/深色主题，仅配色变化时重新生成
@riverpod
({ThemeData light, ThemeData dark}) appThemes(Ref ref) {
  return AppTheme.build(ref.watch(themeColorProvider));
}
