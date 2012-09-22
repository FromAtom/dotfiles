
;;indent level
;;when push enter
;;intert tab
(setq ruby-indent-level 2
      ruby-deep-indent-paren-style nil
      ruby-indent-tabs-mokde nil)


;;括弧の自動挿入
(require 'ruby-electric nil t)

;;end行に対するハイライト
(when (require 'ruby-block nil t)
  (setq ruby-block-highlight-toggle t))

;;インタラクティブRubyを利用する
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

;;ruby-mode-hook用の関数を定義
(defun ruby-mode-hooks ()
  (inf-ruby-keys)
  (ruby-electric-mode t)
  (ruby-block-mode t))

;;ruby-mode-hookに追加
(add-hook 'ruby-mode-hook 'ruby-mode-hooks)
