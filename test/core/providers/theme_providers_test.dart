import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/core/providers/storage_providers.dart';
import 'package:init/core/providers/theme_providers.dart';
import 'package:init/core/theme/app_theme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> containerWith(Map<String, Object> stored) async {
    SharedPreferences.setMockInitialValues(stored);
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);

    // provider 默认 autoDispose，手动保活以便断言状态
    container.listen<AppThemeColor>(themeColorProvider, (_, _) {});
    container.listen<ThemeMode>(themeModeProvider, (_, _) {});

    return container;
  }

  group('主题 provider', () {
    test('无存储值时使用默认配色与跟随系统', () async {
      final container = await containerWith({});

      expect(container.read(themeColorProvider), AppThemeColor.blue);
      expect(container.read(themeModeProvider), ThemeMode.system);
    });

    test('设置后更新状态并写入本地存储', () async {
      final container = await containerWith({});

      await container
          .read(themeColorProvider.notifier)
          .set(AppThemeColor.green);
      await container.read(themeModeProvider.notifier).set(ThemeMode.dark);

      expect(container.read(themeColorProvider), AppThemeColor.green);
      expect(container.read(themeModeProvider), ThemeMode.dark);
      final prefs = container.read(sharedPreferencesProvider);
      expect(prefs.getString('selected_theme_color'), 'green');
      expect(prefs.getString('selected_theme_mode'), 'dark');
    });

    test('存储值非法时回落到默认值', () async {
      final container = await containerWith({
        'selected_theme_color': 'rainbow',
        'selected_theme_mode': '42',
      });

      expect(container.read(themeColorProvider), AppThemeColor.blue);
      expect(container.read(themeModeProvider), ThemeMode.system);
    });

    test('appThemes 随配色变化重新生成', () async {
      final container = await containerWith({});
      final blue = container.read(appThemesProvider);

      await container.read(themeColorProvider.notifier).set(AppThemeColor.red);
      final red = container.read(appThemesProvider);

      expect(
        red.light.colorScheme.primary,
        isNot(blue.light.colorScheme.primary),
      );
      expect(
        blue.light.colorScheme.surface,
        isNot(blue.dark.colorScheme.surface),
      );
    });
  });

  group('AppTheme', () {
    test('组件级定制在 flex 基座之上保留', () {
      final themes = AppTheme.build(AppThemeColor.blue);

      expect(themes.light.appBarTheme.centerTitle, isTrue);
      expect(themes.dark.appBarTheme.centerTitle, isTrue);
      expect(themes.light.cardTheme.elevation, 2);
      expect(themes.dark.dividerTheme.thickness, 1);
    });

    test('fromStorage 解析合法值并回落默认值', () {
      expect(AppThemeColor.fromStorage('red'), AppThemeColor.red);
      expect(AppThemeColor.fromStorage('BLUE'), AppThemeColor.blue);
      expect(AppThemeColor.fromStorage(null), AppThemeColor.blue);
    });
  });
}
