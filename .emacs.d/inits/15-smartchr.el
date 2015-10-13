(require 'smartchr)

;; for perl
(add-hook 'cperl-mode-hook
          '(lambda ()
             (progn
               (local-set-key (kbd "F") (smartchr '("F" "$")))
               (local-set-key (kbd "H") (smartchr '("H" " => ")))
               (local-set-key (kbd "J") (smartchr '("J" "->")))
               (local-set-key (kbd "M") (smartchr '("M" "my ")))
               (local-set-key (kbd "D") (smartchr '("D" "use Data::Dumper; warn Dumper ")))
               )))

;; for yatex
;; とりあえず画像周りだけ試す
(add-hook 'yatex-mode-hook
          '(lambda ()
             (progn
               (local-set-key (kbd "F") (smartchr '("F" "
\\begin{figure}[hbtp]
 \\centering
 \\includegraphics[scale=0.2]{}
 \\caption{}
 \\label{fig:}
\\end{figure}
               ")))
               )))
