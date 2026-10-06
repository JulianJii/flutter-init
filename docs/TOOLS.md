---
title: Utility Tools & Scripts
---

# 实用工具与脚本

仓库根目录提供一组 `.sh`（macOS/Linux）与 `.ps1`（Windows）脚本，两者**参数与行为一致**。执行策略受限时用 `powershell -ExecutionPolicy Bypass -File <脚本>`。

> 注意：脚本是各自独立的实现（不是 Dart CLI 的包装），**都不会自动跑 build_runner**，需要时自行执行：
> `dart run build_runner build --delete-conflicting-outputs`

## 应用重命名

通过单个命令跨平台重新命名你的应用：

```bash
./rename_app.sh --app-name "Your App Name" --package-name com.yourcompany.appname
```

Windows（PowerShell）等价写法：

```powershell
powershell -ExecutionPolicy Bypass -File .\rename_app.ps1 --app-name "Your App Name" --package-name com.yourcompany.appname
```

参数：

| 参数 | 必填 | 说明 |
|---|---|---|
| `--app-name "<名称>"` | 是 | 各平台显示名称 |
| `--package-name <com.company.app>` | 否 | 省略时沿用 Android 当前包名，且**不改** `pubspec.yaml` 的 name 与源码 import |

执行前有交互确认。脚本会更新各平台的显示名称、包/束标识符与构建配置；**不会**重排文件结构，也不会改写源码中的 `package:` 导入。

## 图标生成

1. 将 1024×1024 图标放到 `assets/icon/app_icon.png`。
2. 运行：

```bash
./generate_icons.sh        # Windows: .\generate_icons.ps1
```

脚本先按 `flutter_launcher_icons.yaml` 检查源图是否存在，再执行 `dart run flutter_launcher_icons`。当前配置覆盖 **Android / iOS / Web / Windows / macOS**（未配置 Linux）。

## 语言生成

```bash
./generate_language.sh list            # 列出当前 ARB 语言
./generate_language.sh add fr          # 以英文模板复制出 intl_fr.arb 并改写 @@locale
./generate_language.sh generate        # 等价于 flutter gen-l10n
./generate_language.sh check           # 用 grep 比对各 ARB 的 key 是否与基准一致
./generate_language.sh help
```

说明：

- 子命令仅 `generate | list | add <code> | check | help`（没有 `--add/--sync/--gen` 这类参数）。
- `add` 的复制源是 `intl_en.arb`，而 `l10n.yaml` 的模板是 `intl_zh.arb`——新增语言后请对照两者检查 key。
- 新增语言后还需**手动**在 `lib/core/localization/localization_service.dart` 的 `localeDisplayName()` 补该语言分支（目前只支持 zh/en）；`supportedLocales` 由 gen-l10n 自动生成。
- key 一致性由 `test/l10n/arb_consistency_test.dart` 守护（需从仓库根运行 `flutter test`）。

## Feature 生成

```bash
./generate_feature.sh --name user_profile            # 完整四层骨架
./generate_feature.sh --name user_profile --no-ui    # 不含 presentation
./generate_feature.sh --name user_profile --no-repo  # 不含 domain/data
```

真实产出（full 模式）：`lib/features/<name>/` 下的
`domain/{entities,repositories,usecases}`、`data/{datasources,models,repositories}`、`presentation/{controllers,screens,widgets}`。

**脚本不会生成**：`providers/`（DI）、`presentation/providers/`（UI 状态）、任何测试文件；也不会自动运行 build_runner（仅打印提醒）。生成后请按项目约定手动补齐 DI 与测试。

## 测试运行器

`test_generator` 是**测试运行器**（不生成测试文件）：

```bash
./test_generator.sh                      # 跑全量测试
./test_generator.sh --target test/features/auth   # 只跑指定路径
./test_generator.sh --no-coverage        # 跳过覆盖率
./test_generator.sh --no-report          # 不生成 HTML 覆盖率报告
```

Windows 等价：`powershell -ExecutionPolicy Bypass -File .\test_generator.ps1 --target test/features/auth`。

有 `coverage/lcov.info` 时会生成 `coverage/html` 报告。

## 文档站点

```bash
cd docs && ./build_docs.sh
```

脚本安装 Python 依赖（`markdown`、`pyyaml`、`beautifulsoup4`、`lxml`）并执行 `build_site.py`，把 `docs/*.md` 套用 `_layouts/default.html` 转成 HTML，输出到 `docs/_site`。

## 高级用法示例

### 创建新 Feature 和测试

```bash
# 1. 生成骨架
./generate_feature.sh --name user_profile

# 2. 手动补 providers/ 与 presentation/providers/，并编写测试
# 3. 用运行器执行
./test_generator.sh --target test/features/user_profile
```

### 为生产环境重命名应用

```bash
./rename_app.sh --app-name "My Awesome App" --package-name com.mycompany.awesomeapp
```
