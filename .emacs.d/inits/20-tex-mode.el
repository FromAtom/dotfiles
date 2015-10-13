;; YaTeXの読込と設定
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(add-hook 'yatex-mode-hook '(lambda ()(setq auto-fill-function nil)))
(setq load-path (cons "~/src/emacs/yatex" load-path))

(setq tex-command "platex -kanji=utf8")
(setq bibtex-command "pbibtex -kanji=utf8")
(setq dvi2-command "open -a Preview.app")
(setq YaTeX-kanji-code nil)

(setq YaTeX-dvi2-command-ext-alist
  '(("xdvi\\|dvipdfmx" . ".dvi")
    ("ghostview\\|gv" . ".ps")
    ("acroread\\|pdf\\|Preview\\|TeXShop" . ".pdf")))

;; バッファ全体の句読点と読点をコンマとピリオドに変換
(defun replace-commaperiod-buffer ()
  (interactive "r")
  (save-excursion
    (replace-string "、" "，" nil (point-min) (point-max))
    (replace-string "。" "．" nil (point-min) (point-max))))

;; 選択範囲内の全角英数字を半角英数字に変換
(defun hankaku-eisuu-region (start end)
  (interactive "r")
  (while (string-match
          "[０-９Ａ-Ｚａ-ｚ]+"
          (buffer-substring start end))
    (save-excursion
      (japanese-hankaku-region
       (+ start (match-beginning 0))
       (+ start (match-end 0))
       ))))

;; バッファ全体の全角英数字を半角英数字に変換
(defun hankaku-eisuu-buffer ()
  (interactive)
  (hankaku-eisuu-region (point-min) (point-max)))

;; YaTeXモードの時にのみ動作させる用に条件分岐
(defun replace-commaperiod-before-save-if-needed ()
  (when (memq major-mode
              '(yatex-mode))
    (replace-commaperiod-buffer)(hankaku-eisuu-buffer)(ispell)))

(add-hook 'before-save-hook 'replace-commaperiod-before-save-if-needed)

;; スペルチェックを走らせる
(mapc
 (lambda (hook)(add-hook hook '(lambda () (flyspell-mode 1))))
 '(yatex-mode-hook))
