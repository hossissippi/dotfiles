# ローマ字 → かな漢字だけを引く migemo 辞書。
#
# 素の migemo-dict は SKK 辞書から生成されているため、英単語をキーにした
# 逆引きエントリが 26241 件（全 163282 行中）混ざっている:
#   function -> ファンクション / 機能 / 関数
#   b        -> 硼素 / Boron
# migemo 本来の機能ではあるが、コード検索では "function" が「関数」を含む
# コメント行まで拾ってしまうため、キーが ASCII で始まる行を落とす。
#
# キーは ASCII か日本語のどちらかしかないので、先頭 1 バイトで判別できる。
# LC_ALL=C で [!-~] を見れば PCRE 無しで済む（PCRE 版と一致することを確認済み）。
{ pkgs }:
pkgs.runCommand "migemo-dict-ja" { } ''
  dst=$out/share/migemo/utf-8
  mkdir -p $dst
  cp ${pkgs.cmigemo}/share/migemo/utf-8/*.dat $dst/
  LC_ALL=C grep -v '^[!-~]' \
    ${pkgs.cmigemo}/share/migemo/utf-8/migemo-dict > $dst/migemo-dict

  # 想定外の取りこぼしを検出する。ローマ字 → 漢字が引けなくなったら失敗させる。
  ${pkgs.cmigemo}/bin/cmigemo -q -d $dst/migemo-dict -w kaisha | grep -q '会社' \
    || { echo "filtered dict lost kana lookup"; exit 1; }
  if ${pkgs.cmigemo}/bin/cmigemo -q -d $dst/migemo-dict -w function | grep -q '関数'; then
    echo "filtered dict still has english lookup"; exit 1
  fi
''
