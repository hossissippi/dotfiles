#!/usr/bin/env bash
# dotfiles の config を Windows 側 (%LOCALAPPDATA%\noctty\config.ghostty) にコピーする。
#
# Noctty は Windows 側のパスしか読まないため、Alacritty のようなスタブや
# Rio のような UNC 参照は使えない。編集したらこれを実行すること。
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"
[[ -f "$src" ]] || { echo "config が見つかりません: $src" >&2; exit 1; }

localappdata_win="$(powershell.exe -NoProfile -Command 'Write-Output $env:LOCALAPPDATA' | tr -d '\r')"
[[ -n "$localappdata_win" ]] || { echo "%LOCALAPPDATA% を取得できませんでした" >&2; exit 1; }

dest_dir="$(wslpath -u "$localappdata_win")/noctty"
mkdir -p "$dest_dir"
cp -v "$src" "$dest_dir/config.ghostty"

echo
echo "コピー先: $dest_dir/config.ghostty"
echo "反映するには Noctty で ctrl+shift+, を押すか、ウィンドウを開き直すこと。"
