;; フレームサイズの設定

;; カラーテーマを指定
(customize-set-variable 'frame-background-mode 'dark)
(load-theme 'solarized t)

;; Emacs終了時にフレームサイズを保存する
(defun frame-size-save ()
  (set-buffer
   (find-file-noselect (expand-file-name "~/.emacs.d/.framesize")))
  (erase-buffer)
  (insert (concat
           "(set-frame-width (selected-frame) "
           (int-to-string (frame-width))
           ") (set-frame-height (selected-frame) "
           (int-to-string (frame-height))
           ")"))
  (save-buffer)
  (kill-buffer))
(add-hook 'kill-emacs-hook 'frame-size-save)

;; Emacs起動時に前回のフレームサイズを復元する
(defun frame-size-resume ()
  (let* ((file "~/.emacs.d/.framesize"))
    (if (file-exists-p file)
        (load-file file))))
(add-hook 'window-setup-hook 'frame-size-resume)

;; font-lock use-all
(global-font-lock-mode t)

;; カーソルがある行を強調表示
(global-hl-line-mode t)

;; 対応する括弧のハイライト
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
'(set-face-attribute 'show-paren-match-face nil
                    :background nil :foreground nil
                    :underline t)

;; リージョンに色をつける
(setq transient-mark-mode t)

;; タイトルバーにフルパスを表示
(setq frame-title-format "%f")

;; ツールバーを非表示
(tool-bar-mode 0)

;; 行番号を表示
(require 'linum)
(global-linum-mode t)
(set-face-font 'mode-line "HackGen-12")
(setq linum-format "%3d")

;; 画面上に出るメニュー(y文字)を消す
(menu-bar-mode -1)

;; 画面横に出るスクロールバーを消す
(scroll-bar-mode -1)

;; 画面上に出るツールバー(アイコン画像)を消す
(tool-bar-mode -1)

;; 非active windowにはカーソルを表示しない
(setq cursor-in-non-selected-windows nil)

;; 選択したとき色がつくようにする
(transient-mark-mode t)

;; タブと全角スペースを表示する
(defface my-face-b-1 '((t (:background "gray15"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defun font-lock-user-keywords (mode &optional keywords)
 major-mode
 '(("\t" 0 my-face-b-2 append)
   ("　" 0 my-face-b-1 append)
   ("[ \t]+$" 0 my-face-u-1 append)
   )
  (unless mode
    (error "mode should be non-nil "))
  (font-lock-remove-keywords mode (get mode 'font-lock-user-keywords))
  (font-lock-add-keywords mode keywords)
  (put mode 'font-lock-user-keywords keywords))

;; スプラッシュ画面を出さない
(setq inhibit-startup-message t)
(buffer-menu)
