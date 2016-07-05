;; フレームの設定
(setq default-frame-alist
      (append
       (list
        ;; サイズ・位置
        '(width . 136) ; 横幅(文字数)
        '(height . 62) ; 高さ(行数)
        '(top . 20) ; フレーム左上角 y 座標
        '(left . 0) ; フレーム左上角 x 座標
        )
       default-frame-alist)
      )

;; テーマを使う
(when (require 'color-theme)
  (color-theme-initialize)
  ;; color-theme-solorized.el
  (when (require 'color-theme-solarized)
    (color-theme-solarized-dark)))

;; font-lock use-all
(global-font-lock-mode t)

;; カーソルがある行を強調表示
(global-hl-line-mode t)

;; 対応する括弧のハイライト
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match-face nil
                    :background nil :foreground nil
                    :underline t)

;; リージョンに色をつける
(setq transient-mark-mode t)

;; タイトルバーにフルパスを表示
(setq frame-title-format "%f")

;; 行番号を表示
(require 'linum)
(global-linum-mode t)
(set-face-font 'mode-line "Migu 1M-12")
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
