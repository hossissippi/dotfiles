-- ---------------------------------------------------------------------------
-- Migemo: ローマ字入力のまま日本語を検索する（"kaisha" で 会社 がヒット）
--
-- cmigemo にローマ字を渡すと、対応する仮名・漢字を含む正規表現が返る:
--   kaisha -> (ｶｲｼｬ|カイシャ|開写像|介錯|解[釋釈]|會社|膾炙|会社|かいしゃ|kaisha)
-- これを snacks picker の filter.transform で検索パターンと差し替える。
-- transform に渡る filter は picker:find() 内で clone されたものなので、
-- 入力欄の表示はローマ字のまま変わらない。
--
-- 常時有効にはしない。上の例のとおり同じ読みの無関係な語（開写像・膾炙）を
-- すべて拾うし、1〜2 文字だと候補が数百件に膨らむ。picker 内で <A-j> トグルする。
--
-- grep（<Space>f）と lines（<Space>/）で絞り込む主体が違う。grep は rg、
-- lines は自前の finder。どちらも filter.search に変換結果を入れる。詳細は各関数にて。
--
-- 使い方:  require("migemo").grep()  /  require("migemo").lines()
-- ---------------------------------------------------------------------------
local M = {}

-- 内部状態とヘルパーはこのブロックに閉じる
do

  -- 出力形式ごとに cmigemo を常駐させる。辞書ロードに 40ms かかるため、
  -- 使い回さないと 1 打鍵ごとにその分待たされる。常駐後は 1ms 未満。
  --   rg  : 既定の (a|b) 形式。rg にそのまま渡す
  --   vim : \%(a\|b\) 形式。snacks matcher の vim.regex に渡す
  local flavors = {
    rg = { args = {} },
    vim = { args = { "-v", "-n" } },
  }
  for _, f in pairs(flavors) do
    f.job, f.pending, f.partial = nil, {}, ""
    f.cache, f.inflight = {}, {}
  end

  -- 辞書は vim.g.migemo_dict（migemo-dict.nix が作る英単語キー抜きのもの）を優先し、
  -- 無ければ <prefix>/bin/cmigemo から <prefix>/share/migemo/utf-8/migemo-dict を引く
  local function locate()
    local exe = vim.fn.exepath("cmigemo")
    if exe == "" then return nil end
    local dict = vim.g.migemo_dict
    if not dict or not vim.uv.fs_stat(dict) then
      local prefix = vim.fs.dirname(vim.fs.dirname(exe))
      dict = vim.fs.joinpath(prefix, "share", "migemo", "utf-8", "migemo-dict")
    end
    if not vim.uv.fs_stat(dict) then return nil end
    return exe, dict
  end

  local function alive(f)
    return f.job ~= nil and vim.fn.jobwait({ f.job }, 0)[1] == -1
  end

  local function start(f)
    if alive(f) then return true end
    local exe, dict = locate()
    if not exe then return false end
    f.pending, f.partial, f.inflight = {}, "", {}
    local cmd = { exe, "-q" }
    vim.list_extend(cmd, f.args)
    vim.list_extend(cmd, { "-d", dict })
    f.job = vim.fn.jobstart(cmd, {
      on_stdout = function(_, data)
        -- data[1] は前回の続き、要素の境界が改行に対応する
        for i, chunk in ipairs(data) do
          if i > 1 then
            local line, cb = f.partial, table.remove(f.pending, 1)
            f.partial = ""
            if cb then cb(line) end
          end
          f.partial = f.partial .. chunk
        end
      end,
      on_exit = function() f.job = nil end,
    })
    if f.job <= 0 then f.job = nil end
    return alive(f)
  end

  --- cmigemo を先に起動しておく。辞書ロードを picker を開いた時点で始めておくと、
  --- 最初の変換を待たされない。jobstart 自体は即座に返る。
  function M.warm(flavor)
    start(flavors[flavor or "rg"])
  end

  --- 変換して意味のある入力か。ASCII 英数字・空白・ハイフンのみ、かつ 2 文字以上。
  --- ハイフンは長音を打つのに要る（roba-to -> ロバート、ko-hi- -> コーヒー）。
  --- 日本語や正規表現メタ文字を含む入力はここで弾かれ、変換せず素通しする。
  function M.applicable(s)
    return #s >= 2 and s:match("^[%w%s%-]+$") ~= nil
  end

  --- ローマ字を migemo 正規表現へ。非同期。
  ---
  --- 変換済みならその場で文字列を返す。まだなら nil を返し、cmigemo から
  --- 応答が届いた時点で on_ready を呼ぶ（呼び出し側が再検索する）。
  ---
  --- ここを同期待ちにしてはいけない。transform はキー入力のたびに走るので、
  --- vim.wait でメインループを止めると端末が返す制御シーケンス（DSR 応答など）が
  --- 入力として取り込まれ、入力欄に化けた文字が紛れ込む。
  ---@param word string
  ---@param flavor "rg"|"vim"
  ---@param on_ready? fun() 変換が届いたときに呼ばれる
  ---@return string? 変換済みなら正規表現、まだなら nil
  function M.get(word, flavor, on_ready)
    local f = flavors[flavor or "rg"]
    if f.cache[word] then return f.cache[word] end
    if f.inflight[word] then return nil end   -- 同じ語を二重に投げない
    if not start(f) then return nil end
    f.inflight[word] = true
    f.pending[#f.pending + 1] = function(line)
      f.inflight[word] = nil
      if line ~= "" then f.cache[word] = line end
      if on_ready then vim.schedule(on_ready) end
    end
    vim.fn.chansend(f.job, word .. "\n")
    return nil
  end

  --- 同期版。入力経路では使わないこと（M.get の注意書きを参照）。
  --- 動作確認やスクリプトから呼ぶ用。
  function M.convert(word, flavor)
    local done
    local hit = M.get(word, flavor, function() done = true end)
    if hit then return hit end
    vim.wait(2000, function() return done end, 5)
    return flavors[flavor or "rg"].cache[word] or word
  end

  --- transform の中で例外が出ても picker を巻き込まないようにする。
  --- 失敗したらその picker の migemo を切って通常検索に戻し、
  --- traceback を ~/.local/state/nvim/migemo-error.log に残す。
  ---@param fn fun(picker:table, filter:table)
  local function guard(fn)
    return function(picker, filter)
      local ok, err = xpcall(fn, debug.traceback, picker, filter)
      if ok then return end
      pcall(function()
        local path = vim.fs.joinpath(vim.fn.stdpath("state"), "migemo-error.log")
        local fh = io.open(path, "a")
        if fh then
          fh:write(("[%s] pattern=%q search=%q\n%s\n\n"):format(
            os.date("%Y-%m-%d %H:%M:%S"), tostring(filter.pattern), tostring(filter.search), err))
          fh:close()
        end
        picker.opts.migemo = false
        vim.schedule(function()
          vim.notify("migemo を無効化しました: " .. path, vim.log.levels.WARN)
        end)
      end)
    end
  end

  --- picker に migemo トグルを足す共通部分。
  --- toggles に載せると snacks 側が toggle_migemo アクションと
  --- ハイライト群を自動生成してくれる。
  ---@param transform fun(picker:table, filter:table)
  function M.picker_opts(transform)
    return {
      migemo = false,
      toggles = { migemo = { icon = "あ" } },
      win = { input = { keys = { ["<A-j>"] = { "toggle_migemo", mode = { "i", "n" } } } } },
      filter = { transform = guard(transform) },
    }
  end

end

--- migemo トグル付きの grep。<A-j> で切り替え、有効時はタイトルに "あ" が出る。
--- 既定はオフなので、通常のコード検索の挙動は今までと変わらない。
---
--- grep は rg にパターンを渡すので filter.search を書き換える。transform に渡る
--- filter は picker:find() 内で clone されたものなので、入力欄の表示は変わらない。
function M.grep(opts)
  M.warm("rg")
  return Snacks.picker.grep(vim.tbl_deep_extend("force",
    M.picker_opts(function(picker, filter)
      if not picker.opts.migemo then return end
      -- "kaisha -- -g=*.md" の rg 引数部分は変換しない
      local pat, args = filter.search:match("^(.-)(%s+%-%-%s.*)$")
      pat, args = pat or filter.search, args or ""
      if not M.applicable(pat) then return end
      local re = M.get(pat, "rg", function()
        if not picker.closed then picker:refresh() end
      end)
      -- 未変換のうちはローマ字のまま検索し、変換が届いたら上の refresh で引き直す
      if re then filter.search = re .. args end
    end),
    opts or {}))
end

--- migemo トグル付きの lines（バッファ内検索）。操作は MigemoGrep と同じ <A-j>。
---
--- 絞り込みは finder 側でやる。matcher の regex モードは使わない。
---
--- 経緯: 当初は matcher.regex を transform の中で立てて filter.pattern に
--- 巨大な正規表現（"ka" で 3261 バイト）を渡していたが、その実装だと
--- nvim が落ちた。TUI ではなくサーバ側プロセスが LuaJIT の中で無言の SIGABRT
--- （dmesg に signal 6 が出るだけで stderr には何も出ない。nvim 0.12.4）。
--- 自動再現には至らなかったため真因は未確定。「regex モードのせい」と断定はできない。
--- ただし下の構造に変えてからは再発していない。
---
--- そこで grep と同じ構造にする。変換した正規表現は filter.search に入れ、
--- finder が自前で 1 回だけコンパイルして絞り込む。matcher には空パターンを渡して
--- 素通しさせる。filter.search が変わると finder が再実行されるので、
--- 打鍵ごとの絞り込みもこれで成立する（snacks/picker/core/finder.lua:105）。
function M.lines(opts)
  M.warm("vim")
  local lines = require("snacks.picker.source.lines")
  return Snacks.picker.lines(vim.tbl_deep_extend("force",
    M.picker_opts(function(picker, filter)
      -- オフに戻したとき／変換前は空にしておく。finder はこれを見て素通しする
      filter.search = ""
      if not picker.opts.migemo then return end
      local word = filter.pattern
      if not M.applicable(word) then return end
      local re = M.get(word, "vim", function()
        if not picker.closed then picker:refresh() end
      end)
      if re then
        filter.search = re
        filter.pattern = ""
      end
    end),
    {
      finder = function(o, ctx)
        local items = lines.lines(o, ctx)
        local search = ctx.filter.search
        if search == "" then return items end
        -- 1 回だけコンパイルして使い回す。matcher の regex モードは
        -- 行ごとに vim.regex() を作り直すので、そこを避ける意図もある
        local ok, re = pcall(vim.regex, search)
        if not ok then return items end
        local out = {}
        for _, item in ipairs(items) do
          if re:match_str(item.text) then out[#out + 1] = item end
        end
        return out
      end,
    },
    opts or {}))
end

return M
