;; El-get用の準備

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get-bundle anything)
(el-get-bundle smartchr)
(el-get-bundle git-gutter-fringe)
(el-get-bundle helm)

;; modes
(el-get-bundle swift-mode)
(el-get-bundle web-mode)
(el-get-bundle js2-mode)
(el-get-bundle coffee-mode)
(el-get-bundle slim-mode)
(el-get-bundle yaml-mode)
(el-get-bundle markdown-mode)
(el-get-bundle yatex)

;; company-mode
(el-get-bundle dash)
(el-get-bundle company-mode)

;; campany-mode for Swift
(el-get-bundle yasnippet)
(el-get-bundle nathankot/company-sourcekit)

;; カスタムテーマのパスを設定
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(setq custom-theme-directory "~/.emacs.d/themes")

;; あれこれロードする
(el-get-bundle init-loader)
(init-loader-load "~/.emacs.d/inits")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(inhibit-startup-screen t))
