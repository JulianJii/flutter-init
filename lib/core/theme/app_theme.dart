import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';

/// 可选配色方案：seed 色交给 flex_color_scheme 派生完整色板。
enum AppThemeColor {
  blue(Colors.blue),
  purple(Colors.purple),
  green(Colors.green),
  red(Colors.red);

  const AppThemeColor(this.seedColor);

  /// 生成色板的种子色
  final Color seedColor;

  /// 默认配色
  static const AppThemeColor defaultColor = AppThemeColor.blue;

  /// 解析持久化字符串；为空或非法值回落到 [defaultColor]
  static AppThemeColor fromStorage(String? raw) => values.firstWhere(
    (AppThemeColor color) => color.name == raw,
    orElse: () => defaultColor,
  );
}

/// 应用主题：色板由 flex_color_scheme 生成，组件级定制统一叠在其上。
abstract final class AppTheme {
  /// 按配色生成浅色与深色主题
  static ({ThemeData light, ThemeData dark}) build(AppThemeColor color) {
    return (
      light: _withOverrides(
        FlexThemeData.light(
          colors: FlexSchemeColor.from(
            primary: color.seedColor,
            brightness: Brightness.light,
          ),
        ),
        Brightness.light,
      ),
      dark: _withOverrides(
        FlexThemeData.dark(
          colors: FlexSchemeColor.from(
            primary: color.seedColor,
            brightness: Brightness.dark,
          ),
        ),
        Brightness.dark,
      ),
    );
  }

  /// 组件级外观定制：AppBar / 按钮 / 输入框 / 卡片 / SnackBar / 分割线
  static ThemeData _withOverrides(ThemeData base, Brightness brightness) {
    final bool isLight = brightness == Brightness.light;

    return base.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isLight ? Colors.black : Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dividerTheme: const DividerThemeData(thickness: 1),
    );
  }
}
