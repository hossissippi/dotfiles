# Noctty

Windows 側の [Noctty](https://github.com/amanthanvi/noctty)（Ghostty のターミナルコア +
ネイティブ Win32 アプリ層、旧 winghostty）の設定をこのリポジトリで管理する。

## 構成

| ファイル | 役割 |
| --- | --- |
| `config` | 設定の実体。編集はここだけ。 |
| `install.sh` | Windows 側にコピーする。 |

## 運用

Noctty は **Windows 側のパスしか読まない**ので、編集したらコピーする。

```bash
./install.sh    # → %LOCALAPPDATA%\noctty\config.ghostty
```

反映は Noctty 側で `ctrl+shift+,`（`reload_config`）、または開き直す。

読み込まれているかの確認:

```bash
cd "/mnt/c/Program Files/noctty"
./noctty.exe +show-config              # 既定値と違う項目だけが出る
./noctty.exe +show-config --default --docs   # 全 646 項目をドキュメント付きで
```

## GhostInTheWSL との違い（同じ Ghostty コアだが別物）

先に GhostInTheWSL を試して不採用にしている（[[project-ghostinthewsl]] 相当の経緯）。
同じ Ghostty コアのフォークだが、Windows 側の作りが違うため以下が改善している。

| | GhostInTheWSL | Noctty |
| --- | --- | --- |
| アプリ層 | Ghostty の GTK 由来 | **ネイティブ Win32** |
| タブ非表示 | 本家ドキュメントが GTK 専用と明記、効いていなかった | **`window-show-tab-bar = never` が Windows 向けに実装**（`+show-config --default --docs` に "Supported in the Windows-only fork." と明記） |
| テーマ | **同梱されておらず `theme` が使えない**（palette 直書きが必要） | **486 個同梱**。`theme = Rose Pine` がそのまま通る |
| WSL 接続 | vsock で ConPTY を完全バイパス | **側でバンドルした ConPTY**（`C:\Program Files\noctty\OpenConsole.exe`）を使う |
| 設定パス | 公式ドキュメントが `%APPDATA%` と誤記（実際は `%LOCALAPPDATA%`） | `%LOCALAPPDATA%\noctty\config.ghostty`（ドキュメント通り） |

## 注意点

### WSL を既定シェルにするには `command` が要る（罠が2つ）

プロファイルピッカーから WSL を選ぶだけなら不要。起動時から WSL にするには
`command` を明示する必要があるが、公式ドキュメントの `command = wsl.exe` そのままでは
この環境では期待通りに動かない。

**罠1: 既定ディストリが Ubuntu-22.04。**`wsl -l -v` で `*` が付いているのは Ubuntu-22.04 で、
NixOS ではない。単に `wsl.exe` と書くと Ubuntu が起動するので `-d NixOS` が要る。
（`wsl --set-default NixOS` で既定を変える手もあるが、他のツールにも影響するのでやっていない。）

**罠2: 引数付き `command` は `/bin/sh -c` に渡される。**設定のドキュメントに
"If additional arguments are provided, the command will be executed using `/bin/sh -c`"
とあるが、**Windows に /bin/sh は無い**。`direct:` を前置するとシェルを経由せず直接起動する。
`--cd ~` の `~` はシェルではなく wsl.exe 自身が解釈するので、`direct:` でも home に入る。

結果として次の形になる。

```ini
command = direct:wsl.exe -d NixOS --cd ~
```

動作確認:

```bash
wsl.exe -d NixOS --cd ~ -- pwd    # /home/nixos が返れば command 自体は正しい
```

### ConPTY を同梱している理由

Windows 同梱の conhost は **Kitty APC と Sixel DCS のペイロードを削り落とす**。
これが「Windows で画像が出ない」の正体。Noctty は side-by-side ConPTY を同梱して
これを回避しており、インストール先に `OpenConsole.exe` が入っているのはそのため。
フォールバックすると画像表示が壊れるので、警告が出たら無視しないこと。

### `+show-config` に設定キーを引数で渡すと無言で空を返す

`--theme=...` のように設定キーを渡すと出力ゼロ・終了コード 0 になる
（GhostInTheWSL でも同じ挙動だった。Ghostty 由来）。
引数なしか `--default` のみで使うこと。テーマ一覧は `+list-themes` で取れる。

### プロジェクトが若い

2026-04-05 開始、メンテナ 1 人、⭐314。リリース頻度は高い（v1.3.125 が 2026-09-04）が、
本体の安定性はまだ検証途上。Windows 専用で macOS/Linux 対応の予定は無い。
