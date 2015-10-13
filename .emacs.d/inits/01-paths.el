;; サブディレクトリ読み込み関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
              (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; サブディレクトリにパスを通す
; (add-to-load-path "elisp")
; (add-to-load-path "conf")
; (add-to-load-path "public_repos")
