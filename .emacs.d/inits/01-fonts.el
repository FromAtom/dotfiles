;; 英語Fontの設定
(set-face-attribute 'default nil
                    :family "HackGen"
                    :height 180)

;; 日本語Fontの設定
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "HackGen"))

;; 違うフォントを使うなら横幅調整が必要
