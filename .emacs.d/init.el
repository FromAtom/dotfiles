;; El-get用の準備
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;見た目
(el-get-bundle elpa:color-theme)
(el-get-bundle color-theme-solarized)

(el-get-bundle auto-complete)
(el-get-bundle anything)
(el-get-bundle smartchr)
(el-get-bundle git-gutter-fringe)
(el-get-bundle helm)

(el-get-bundle init-loader)
(init-loader-load "~/.emacs.d/inits")
