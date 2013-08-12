(defalias 'perl-mode 'cperl-mode)

(setq cperl-indent-level 4
      cperl-continued-statement-offset 4
      cperl-brace-offset -4
      cperl-level-offset -4
      cperl-indent-paren-as-block t
      cperl-close-paren-offset -4
      cperl-indent-region-fix-constructs 1
      cperl-space-always-indent t
      cperl-highlight-variables-indiscriminately t)

'(cperl-set-style "PerlStyle")
(custom-set-variables
 '(cperl-indent-parens-as-block t)
 '(cperl-close-paren-offset -4)
 '(cperl-indent-subs-specially nil))
