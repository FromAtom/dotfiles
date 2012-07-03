;;; -*- mode: lisp-interaction; syntax: elisp -*-


;; keyset
(global-set-key "\C-h" 'backward-delete-char) ;C-h as BackSpace
(global-set-key "\M-?" 'help-for-help) ;M-? as help
(global-set-key "\C-q" 'dabbrev-expand)


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
(add-to-load-path "conf")

;; .emacs22を読み込み
(load ".emacs24")


;;起動時にEshellも起動
(add-hook 'after-init-hook (lambda()(eshell)))














;; end of file
