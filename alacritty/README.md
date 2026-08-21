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

```bash
mkdir -p /mnt/c/Users/hoshi/AppData/Roaming/alacritty
cp alacritty/windows/alacritty.toml \
   /mnt/c/Users/hoshi/AppData/Roaming/alacritty/alacritty.toml
```

Windows ユーザー名や WSL ディストリ名 (`NixOS`) が違う環境では、
スタブ内の UNC パスを合わせて書き換えること。

## 前提

- フォント: UDEV Gothic 35NFLG（Windows 側にインストール済みであること）
- 配色: Rosé Pine (main) — nvim の colorscheme に合わせている
- 起動シェル: `wsl.exe -d NixOS --cd ~`
