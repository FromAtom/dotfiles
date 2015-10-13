(defalias 'perl-mode 'cperl-mode)

(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.psgi$" . cperl-mode))
(add-to-list 'auto-mode-alist '("^cpanfile$" . cperl-mode))

;; インデント周りの設定
(setq cperl-indent-level 4
      cperl-continued-statement-offset 4
      cperl-brace-offset -4
      cperl-level-offset -4
      cperl-indent-paren-as-block t
      cperl-close-paren-offset -4
      cperl-indent-region-fix-constructs 1
      cperl-space-always-indent t
      cperl-highlight-variables-indiscriminately t)
