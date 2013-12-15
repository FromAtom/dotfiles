;;ispellをaspellに置き換え
(setq ispell-program-name "/usr/local/bin/aspell")

;;日本語まじりでも使えるようにする
(eval-after-load "ispell"
 '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
