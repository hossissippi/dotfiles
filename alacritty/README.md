# Alacritty

Windows 側の Alacritty (`C:\Program Files\Alacritty`) の設定をこのリポジトリで管理する。

## 構成

| ファイル | 役割 |
| --- | --- |
| `alacritty.toml` | 設定の実体。編集はここだけ。 |
| `windows/alacritty.toml` | Windows の `%APPDATA%\alacritty\` に置くスタブ。実体を UNC パスで import する。 |

Windows 側には import 1 行のスタブしか置かないため、`alacritty.toml` を編集すると
`live_config_reload` により起動中の Alacritty へ即座に反映される。

## セットアップ（新環境／再設定時）

Windows ユーザー名を直書きしないよう、`%APPDATA%` から解決する。

```bash
APPDATA_WSL=$(wslpath "$(cmd.exe /c 'echo %APPDATA%' 2>/dev/null | tr -d '\r')")
mkdir -p "$APPDATA_WSL/alacritty"
cp alacritty/windows/alacritty.toml "$APPDATA_WSL/alacritty/alacritty.toml"
```

スタブ内の UNC パスは WSL ディストリ名と Linux 側ユーザー名を含むため、
環境が違う場合は書き換えること。正しい値は次で得られる。

```bash
wslpath -w "$(pwd)/alacritty"
# 例: \\wsl.localhost\NixOS\home\nixos\dotfiles\alacritty
```

## 前提

- フォント: UDEV Gothic 35NFLG（Windows 側にインストール済みであること）
- 配色: Rosé Pine (main) — nvim の colorscheme に合わせている
- 起動シェル: `wsl.exe -d NixOS --cd ~`
