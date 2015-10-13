;; 文字コード設定
(set-default-coding-systems 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)

;; Max OS Xのファイルネーム設定
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; Windowsのファイルネーム設定
(when (eq window-system 'w32)
  (set-file-name-coding-system 'cp932)
  (setq locale-coding-system 'cp932)
  (set-file-name-coding-system 'cp932))

;; scratchの初期メッセージを変更
(setq initial-scratch-message "Scratch!!!\n")

;; HTMLのMETAタグに'Shift_JIS'とか書かれてるとその形式で保存されてしまうのを防ぐ
(setq auto-coding-functions nil)

;; file名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;; yes-noの選択肢をy-nにする
(fset 'yes-or-no-p 'y-or-n-p)

;;; Autosaveファイルの場所指定
;; (setq auto-save-list-file-prefix (expand-file-name "~/.emacs.d/.autosave/"))
;; オートセーブファイルを作らない
(setq auto-save-default nil)

;; Backup fileの場所指定
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/.backup"))
            backup-directory-alist))

;;同名ファイルのバッファ名の識別文字列を変更
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; スクロールを一行ずつにする
(setq mac-mouse-wheel-smooth-scroll t)
(setq scroll-step 1)

;; 行の先頭でC-kを一回押すだけで行全体を消去する
(setq kill-whole-line t)

;;タブの代わりに半角スペースを使う
(setq-default tab-width 4 indent-tabs-mode nil)

;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;; ログの記録行数を増やす
(setq message-log-max 10000)

;; サーバ起動
(require 'server)
(unless (server-running-p)
  (server-start))

;; クライアントを終了するとき終了するかどうかを聞かない
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;;自動再読み込み
(global-auto-revert-mode 1)

;;; 定義マクロファイル設定
(defvar kmacro-save-file "~/.emacs.d/inits/70-mymacros.el")

;;; debug用
(setq debug-on-error nil)

;;; symlinkは必ず追いかける
(setq vc-follow-symlinks t)

;;; 最後に改行無い時は挿入
(setq require-final-newline t)
(setq mode-require-final-newline t)

;; 前回編集していた場所を記憶し，ファイルを開いた時にそこへカーソルを移動
(load "saveplace")
(setq-default save-place t)

;; カレントディレクトリで起動（eshell用）
(cd "./")

;; ビープ音消去
(setq ring-bell-function 'ignore)

;;矩形選択を有効に
(cua-mode t)
(setq cua-enable-cua-key nil)

;; 保存時に行末のスペースを削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; コピペ時にテキスト属性（色情報など）は保存しない
;; http://www-tsujii.is.s.u-tokyo.ac.jp/~yoshinag/tips/elisp_tips.html#yankoff
(defadvice kill-new (around my-kill-ring-disable-text-property activate)
  (let ((new (ad-get-arg 0)))
    (set-text-properties 0 (length new) nil new)
    ad-do-it))
