# Flutter App Renamer (Windows / PowerShell)
# 与 rename_app.sh 行为一致：重命名应用并在各平台更新包名。
# 用法（PowerShell 7 / Windows PowerShell）：
#   powershell -ExecutionPolicy Bypass -File .\rename_app.ps1 --app-name "My App" --package-name com.example.myapp

# 不声明 param()，否则 PowerShell 会把 --app-name 之类当作参数名并报错；
# 因此统一手工解析 $args，保持与 .sh 相同的命令行约定。

$ErrorActionPreference = 'Stop'

# 就地正则替换（.NET 正则，替换串按字面插入，避免 $ 被当作分组引用）
function Edit-TextFile {
    param([string]$Path, [string]$Pattern, [string]$Replacement)
    if (-not (Test-Path -LiteralPath $Path)) { return }
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    $content = [System.IO.File]::ReadAllText($Path)
    $evaluator = [System.Text.RegularExpressions.MatchEvaluator] { param($m) $Replacement }
    $result = [regex]::Replace($content, $Pattern, $evaluator)
    [System.IO.File]::WriteAllText($Path, $result, $utf8)
}

# 更新 Info.plist 中某个 key 对应的 <string> 值；key 不存在时按需追加
function Set-PlistValue {
    param([string]$Path, [string]$Key, [string]$Value, [switch]$InsertWhenMissing)
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    $content = [System.IO.File]::ReadAllText($Path)
    $pattern = '(?s)<key>' + [regex]::Escape($Key) + '</key>\s*<string>.*?</string>'
    $block = '<key>' + $Key + '</key>' + "`n`t<string>" + $Value + '</string>'
    if ($content -match $pattern) {
        $evaluator = [System.Text.RegularExpressions.MatchEvaluator] { param($m) $block }
        $content = [regex]::Replace($content, $pattern, $evaluator)
    } elseif ($InsertWhenMissing -and $content -match '(?s)<key>CFBundleDisplayName</key>\s*<string>.*?</string>') {
        $evaluator = [System.Text.RegularExpressions.MatchEvaluator] { param($m) $m.Groups[0].Value + "`n`t" + $block }
        $content = [regex]::Replace($content, '(?s)(<key>CFBundleDisplayName</key>\s*<string>.*?</string>)', $evaluator)
    } else {
        return
    }
    [System.IO.File]::WriteAllText($Path, $content, $utf8)
}

function Show-Usage {
    Write-Host "Usage: rename_app.ps1 [options]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host '  --app-name "New App Name"            Set the new app display name (required)'
    Write-Host "  --package-name com.example.newapp     Set the new package name (required)"
    Write-Host "  --help                                Show this help message"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host '  .\rename_app.ps1 --app-name "My Amazing App" --package-name com.mycompany.amazingapp'
    Write-Host ""
    exit 1
}

# ---- 解析参数 ----
$newAppName = $null
$newPackageName = $null
for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        '--app-name' { $newAppName = $args[++$i] }
        '--package-name' { $newPackageName = $args[++$i] }
        '--help' { Show-Usage }
        default {
            Write-Host "Error: Unknown option: $($args[$i])" -ForegroundColor Red
            Show-Usage
        }
    }
}

# ---- 校验参数 ----
if (-not $newAppName -or -not $newPackageName) {
    Write-Host 'Error: Both --app-name and --package-name are required' -ForegroundColor Red
    Show-Usage
}
if ($newPackageName -cnotmatch '^[a-z][a-z0-9_]*(\.[a-z0-9_]+)+[0-9a-z_]$') {
    Write-Host 'Error: Package name must be in valid format (e.g., com.example.app)' -ForegroundColor Red
    exit 1
}

# ---- 定位项目根目录并校验 ----
Set-Location (Split-Path -Parent $MyInvocation.MyCommand.Path)
$root = Get-Location
$pubspecPath = Join-Path $root 'pubspec.yaml'
if (-not (Test-Path $pubspecPath)) {
    Write-Host 'Error: pubspec.yaml not found. Please run this script from the root of your Flutter project.' -ForegroundColor Red
    exit 1
}

# 显示名 -> 合法 Dart 包名（小写，空格/连字符 -> 下划线）
# 注：.sh 里该值在最后一步才计算，却在 Windows/Linux 步骤提前引用（恒为空）。
# 此处提前算出，避免 .sh 中的这个 bug。
$pubspecAppName = ($newAppName.ToLowerInvariant() -replace '[\s-]+', '_')

$pubspecContent = [System.IO.File]::ReadAllText($pubspecPath)
$nameMatch = [regex]::Match($pubspecContent, '(?m)^name:\s*([^\s#]+)')
if (-not $nameMatch.Success) {
    Write-Host 'Error: Could not determine current package name from pubspec.yaml' -ForegroundColor Red
    exit 1
}
$currentAppName = $nameMatch.Groups[1].Value

Write-Host "Current app name identifier: $currentAppName" -ForegroundColor Yellow
Write-Host "New app display name: $newAppName" -ForegroundColor Yellow
Write-Host "New package name: $newPackageName" -ForegroundColor Yellow

$answer = Read-Host "`nDo you want to proceed with renaming? This operation cannot be easily undone. (y/N)"
if ($answer -cnotmatch '^[Yy]') {
    Write-Host 'Operation canceled.' -ForegroundColor Yellow
    exit 0
}

Write-Host 'Starting renaming process...' -ForegroundColor Cyan

# ---- 1. Android ----
Write-Host '[1/8] Updating Android files' -ForegroundColor Cyan
if (Test-Path 'android') {
    $stringsXml = 'android/app/src/main/res/values/strings.xml'
    if (-not (Test-Path $stringsXml)) {
        New-Item -ItemType Directory -Force -Path (Split-Path $stringsXml) | Out-Null
        $lines = @(
            '<?xml version="1.0" encoding="utf-8"?>',
            '<resources>',
            '    <string name="app_name">' + $newAppName + '</string>',
            '</resources>'
        )
        [System.IO.File]::WriteAllText($stringsXml, ($lines -join "`n") + "`n", (New-Object System.Text.UTF8Encoding($false)))
    } else {
        Edit-TextFile $stringsXml '<string name="app_name">.*</string>' ('<string name="app_name">' + $newAppName + '</string>')
    }

    if (Test-Path 'android/app/build.gradle') {
        Edit-TextFile 'android/app/build.gradle' 'applicationId ".*"' ('applicationId "' + $newPackageName + '"')
    } elseif (Test-Path 'android/app/build.gradle.kts') {
        Edit-TextFile 'android/app/build.gradle.kts' 'applicationId = ".*"' ('applicationId = "' + $newPackageName + '"')
        Edit-TextFile 'android/app/build.gradle.kts' 'namespace = ".*"' ('namespace = "' + $newPackageName + '"')
    }

    $manifest = 'android/app/src/main/AndroidManifest.xml'
    $oldPackageName = $null
    if (Test-Path $manifest) {
        $manifestContent = [System.IO.File]::ReadAllText($manifest)
        $packageMatch = [regex]::Match($manifestContent, 'package="([^"]+)"')
        if ($packageMatch.Success) {
            $oldPackageName = $packageMatch.Groups[1].Value
            Edit-TextFile $manifest ('package="' + $oldPackageName + '"') ('package="' + $newPackageName + '"')
        }
    }

    # 移动 Android 包目录并更新 Kotlin 里的 package 声明
    if ($oldPackageName) {
        $oldPath = $oldPackageName.Replace('.', '/')
        $newPath = $newPackageName.Replace('.', '/')
        $oldDir = 'android/app/src/main/kotlin/' + $oldPath
        $newDir = 'android/app/src/main/kotlin/' + $newPath
        if (Test-Path -LiteralPath $oldDir) {
            New-Item -ItemType Directory -Force -Path $newDir | Out-Null
            Get-ChildItem -LiteralPath $oldDir | Move-Item -Destination $newDir -Force
            Get-ChildItem -LiteralPath $newDir -Recurse -Filter *.kt -File | ForEach-Object {
                Edit-TextFile $_.FullName ('package ' + $oldPackageName) ('package ' + $newPackageName)
            }
            Remove-Item -LiteralPath $oldDir -Recurse -Force
        }
    }
}

# ---- 2. iOS ----
Write-Host '[2/8] Updating iOS files' -ForegroundColor Cyan
$iosPlist = 'ios/Runner/Info.plist'
if (Test-Path $iosPlist) {
    Set-PlistValue $iosPlist 'CFBundleName' $newAppName -InsertWhenMissing
    Set-PlistValue $iosPlist 'CFBundleDisplayName' $newAppName
    Set-PlistValue $iosPlist 'CFBundleIdentifier' $newPackageName
}
if (Test-Path 'ios/Runner.xcodeproj/project.pbxproj') {
    Edit-TextFile 'ios/Runner.xcodeproj/project.pbxproj' 'PRODUCT_BUNDLE_IDENTIFIER = .*;' ('PRODUCT_BUNDLE_IDENTIFIER = ' + $newPackageName + ';')
}

# ---- 3. macOS ----
Write-Host '[3/8] Updating macOS files' -ForegroundColor Cyan
$macPlist = 'macos/Runner/Info.plist'
if (Test-Path $macPlist) {
    Set-PlistValue $macPlist 'CFBundleName' $newAppName
    Set-PlistValue $macPlist 'CFBundleDisplayName' $newAppName
    Set-PlistValue $macPlist 'CFBundleIdentifier' $newPackageName
}
if (Test-Path 'macos/Runner.xcodeproj/project.pbxproj') {
    Edit-TextFile 'macos/Runner.xcodeproj/project.pbxproj' 'PRODUCT_BUNDLE_IDENTIFIER = .*;' ('PRODUCT_BUNDLE_IDENTIFIER = ' + $newPackageName + ';')
}

# ---- 4. Windows ----
Write-Host '[4/8] Updating Windows files' -ForegroundColor Cyan
if (Test-Path 'windows') {
    $cmake = 'windows/CMakeLists.txt'
    if (Test-Path $cmake) {
        Edit-TextFile $cmake 'project\(.*\)' ('project(' + $pubspecAppName + ' LANGUAGES CXX)')
        Edit-TextFile $cmake 'set\(BINARY_NAME ".*"\)' ('set(BINARY_NAME "' + $pubspecAppName + '")')
    }
    $rc = 'windows/runner/Runner.rc'
    if (Test-Path $rc) {
        Edit-TextFile $rc 'VALUE "FileDescription", ".*"' ('VALUE "FileDescription", "' + $newAppName + '"')
        Edit-TextFile $rc 'VALUE "ProductName", ".*"' ('VALUE "ProductName", "' + $newAppName + '"')
    }
}

# ---- 5. Linux ----
Write-Host '[5/8] Updating Linux files' -ForegroundColor Cyan
if (Test-Path 'linux') {
    $linuxCmake = 'linux/CMakeLists.txt'
    if (Test-Path $linuxCmake) {
        Edit-TextFile $linuxCmake 'project\(.*\)' ('project(' + $pubspecAppName + ' LANGUAGES CXX)')
        Edit-TextFile $linuxCmake 'set\(BINARY_NAME ".*"\)' ('set(BINARY_NAME "' + $pubspecAppName + '")')
        Edit-TextFile $linuxCmake 'set\(APPLICATION_ID ".*"\)' ('set(APPLICATION_ID "' + $newPackageName + '")')
    }
    if (Test-Path 'linux/my_application.cc') {
        Edit-TextFile 'linux/my_application.cc' 'g_application_set_application_id \(application, ".*"\);' ('g_application_set_application_id (application, "' + $newPackageName + '");')
    }
}

# ---- 6. Web ----
Write-Host '[6/8] Updating web files' -ForegroundColor Cyan
if (Test-Path 'web') {
    if (Test-Path 'web/index.html') {
        Edit-TextFile 'web/index.html' '<title>.*</title>' ('<title>' + $newAppName + '</title>')
    }
    if (Test-Path 'web/manifest.json') {
        Edit-TextFile 'web/manifest.json' '"name": ".*"' ('"name": "' + $newAppName + '"')
        Edit-TextFile 'web/manifest.json' '"short_name": ".*"' ('"short_name": "' + $newAppName + '"')
    }
}

# ---- 7. pubspec.yaml ----
Write-Host '[7/8] Updating pubspec.yaml' -ForegroundColor Cyan
Edit-TextFile $pubspecPath '(?m)^name:.*' ('name: ' + $pubspecAppName)
Edit-TextFile $pubspecPath '(?m)^description:.*' ('description: "' + $newAppName + ' - A Flutter application."')

# ---- 8. 常量与 import ----
Write-Host '[8/8] Updating app constants and main files' -ForegroundColor Cyan
Get-ChildItem -Path lib -Recurse -Filter *.dart -File | Where-Object {
    $_.Name -match 'constants' -and $_.FullName -match 'app'
} | ForEach-Object {
    $constantsContent = [System.IO.File]::ReadAllText($_.FullName)
    if ($constantsContent -match 'appName') {
        Edit-TextFile $_.FullName "static const String appName = '[^']*'" ("static const String appName = '" + $newAppName + "'")
        Edit-TextFile $_.FullName 'static const String appName = "[^"]*"' ('static const String appName = "' + $newAppName + '"')
    }
}

Get-ChildItem -Path lib -Recurse -Filter *.dart -File | ForEach-Object {
    Edit-TextFile $_.FullName ("import 'package:" + $currentAppName) ("import 'package:" + $pubspecAppName)
}

# ---- 完成 ----
Write-Host ''
Write-Host 'App successfully renamed!' -ForegroundColor Green
Write-Host "   - Display Name: $newAppName" -ForegroundColor Yellow
Write-Host "   - Package/Bundle ID: $newPackageName" -ForegroundColor Yellow
Write-Host "   - Dart Package Name: $pubspecAppName" -ForegroundColor Yellow
Write-Host ''
Write-Host 'Next steps:' -ForegroundColor Cyan
Write-Host '1. Run flutter clean' -ForegroundColor Cyan
Write-Host '2. Run flutter pub get' -ForegroundColor Cyan
Write-Host "3. Re-run flutter build for each platform you're targeting" -ForegroundColor Cyan
Write-Host ''
Write-Host 'Note: You may need to manually update some references if you have complex platform-specific code.' -ForegroundColor Yellow
exit 0
