(require 'auto-complete-swift)
(push 'ac-source-swift-complete ac-sources)

(font-lock-user-keywords 'c-mode)
(defface my-face-b-1 '((t (:background "gray15"))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defun font-lock-user-keywords (mode &optional keywords)
 major-mode
 '(("　" 0 my-face-b-1 append))
  (unless mode
    (error "mode should be non-nil "))
  (font-lock-remove-keywords mode (get mode 'font-lock-user-keywords))
  (font-lock-add-keywords mode keywords)
  (put mode 'font-lock-user-keywords keywords))

(defun swift-mode-indent-conf ()
  (c-set-style "cc-mode")
  (auto-revert-mode)
  (setq indent-tabs-mode t)
)

;; フックを設定する
(add-hook 'swift-mode-hook 'swift-mode-indent-conf)
