;; 英語Fontの設定
(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 140)

;; 日本語Fontの設定
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Ricty"))

;; 違うフォントを使うなら横幅調整が必要
'(setq face-font-rescale-alist
      '((".*Migu 1M.*" . 1.2)))
