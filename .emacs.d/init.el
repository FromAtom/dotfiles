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

;; .emacs22を読み込み
(load ".emacs24")


;;Ruby用elispを読み込み
(load "init-ruby")
(load "init-haml")
(load "init-tex")


;;YaTeX設定
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))
(setq load-path (cons "~/src/emacs/yatex" load-path))

(setq bibtex-command "pbibtex -kanji=utf8")
(setq YaTeX-kanji-code 4)



;;auto-installを読み込み
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))


(require 'shell-pop)
(shell-pop-set-window-height 50)
(shell-pop-set-internal-mode "eshell")
(shell-pop-set-internal-mode-shell "/bin/zsh")
(global-set-key "\C-t" 'shell-pop)



;;起動時にEshellも起動
(add-hook 'after-init-hook (lambda()(eshell)))


(add-to-list 'load-path "~/.emacs.d/elisp/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp//ac-dict")
(ac-config-default)




;; end of file
