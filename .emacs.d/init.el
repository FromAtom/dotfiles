;;; -*- mode: lisp-interaction; syntax: elisp -*-


;; keyset
(global-set-key "\C-h" 'backward-delete-char) ;C-h as BackSpace
(global-set-key "\M-?" 'help-for-help) ;M-? as help
(global-set-key "\C-q" 'dabbrev-expand)


;; 文字コードをUTF-8に
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

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

;; Load Path
;(setq load-path (cons "~/.emacs.d" load-path))

;; Emacsのバージョンが23以前の場合
(when (> emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d"))

;; サブディレクトリ読み込み関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; confを読み込みに追加
(add-to-load-path "elisp")
(add-to-load-path "conf")
(add-to-load-path "public_repos")

;; .emacs22を読み込み
(load ".emacs24")

;;emoji.el
(require 'emoji)

;;anything.el
(require 'anything)
(require 'anything-config)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)
(define-key global-map (kbd "C-;") 'anything)


;;各種専用elispを読み込み
(load "init-ruby")
(load "init-kawayumi")
(load "init-yaml")
(load "init-perl")
(load "init-haml")
(load "init-tex")
(load "init-modeline")
(load "init-less")

;;バッファ自動再読み込み
(global-auto-revert-mode 1)

;;ファイル名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;;同名ファイルのバッファ名の識別文字列を変更
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;;auto-installを読み込み
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))


'(require 'shell-pop)
'(shell-pop-set-window-height 50)
'(shell-pop-set-internal-mode "eshell")
'(shell-pop-set-internal-mode-shell "/bin/zsh")
'(global-set-key "\C-t" 'shell-pop)


;;対応行を強調表示
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background  "#98FB98"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)


;;smartchr
(require 'smartchr)
(add-hook 'cperl-mode-hook
          '(lambda ()
             (progn
               (local-set-key (kbd "F") (smartchr '("F" "$")))
               (local-set-key (kbd "H") (smartchr '("H" " => ")))
               (local-set-key (kbd "J") (smartchr '("J" "->")))
               (local-set-key (kbd "M") (smartchr '("M" "my ")))
               (local-set-key (kbd "D") (smartchr '("D" "use Data::Dumper; print Dumper ")))
               )))

;;Windows分割
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 200)
        (split-window-horizontally-n 3)
      (split-window-horizontally)))
  (other-window 1))

(global-set-key (kbd "C-t") 'other-window-or-split)

;;

;;起動時にEshellも起動
(add-hook 'after-init-hook (lambda()(eshell)))

(add-to-list 'load-path "~/.emacs.d/elisp/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp//ac-dict")
(ac-config-default)

;;emacs serverを起動
(require 'server)
(unless (server-running-p)
  (server-start))

;; end of file
