@echo off
setlocal

rem This script converts markdown files to HTML and generates a complete documentation site

rem Force UTF-8 file I/O, otherwise Python uses the system code page (GBK) and fails on the markdown files
set PYTHONUTF8=1

rem Run from the script's own directory so build_site.py finds _layouts and the markdown files
cd /d "%~dp0"

rem Create output directory if it doesn't exist
if not exist "_site" mkdir "_site"

rem Install required Python packages if not already installed
pip install markdown pyyaml beautifulsoup4 lxml || pip3 install markdown pyyaml beautifulsoup4 lxml

rem Run the improved site generator script
python build_site.py || python3 build_site.py
if errorlevel 1 (
  echo Failed to build documentation site
  exit /b 1
)

echo Documentation site built successfully in docs/_site directory
