;; -*- emacs-list -*-
;; @@ ddskk
;; Time-stamp: <2014-03-17 12:26 akira.masuda>

;; @@ SKK
;; 08.04.21(mon)-17:57
(require 'skk-setup)

;; SKK add 060313
;;(autoload 'skk-mode "skk" nil t)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(define-key my-key-map "u" 'skk-undo-kakutei)

;;(setq skk-large-jisyo "c:/emacs-23/etc/skk/SKK-JISYO.L")
(setq skk-large-jisyo "c:/home/.emacs.d/SKK-JISYO.L")

(add-hook 'isearch-mode-hook
		  (function (lambda ()
					  (and (boundp 'skk-mode) skk-mode
						   (skk-isearch-mode-setup)))))

(add-hook 'isearch-mode-end-hook
		  (function
		   (lambda ()
			 (and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
			 (and (boundp 'skk-mode-invoked) skk-mode-invoked
				  (skk-set-cursor-properly)))))

(setq skk-egg-like-newline t)

(eval-after-load "skk"
  '(progn
	 (setq skk-rom-kana-rule-list
		   (nconc skk-rom-kana-rule-list
				  '(("z!" nil "！")
					(":" nil ":")
					(";" nil ";")
					("?" nil "？")
					;("?" nil "?")
					("z " nil "　")
					("z8" nil "【")
					("z9" nil "】")
					("z1" nil "！")
					("z3" nil "＃")
					)))))

;;;;注釈を表示
;;(setq skk-show-annotation t)

(setq skk-cursor-hiragana-color "red") ;; skk-13
(setq skk-cursor-latin-color "DodgerBlue") ;; skk-13

;; @ 07.10.30(tue)-15:34 ver 13.1
;;候補が近くに出る
(setq skk-show-inline t)
;;確定Undo カーソルの位置がちゃんとする
(setq skk-undo-kakutei-return-previous-point t)

;; for SKK
;; Emacs23 でエラーになるので
(or (fboundp 'char-int)
	(fset 'char-int (symbol-function 'identity)))


;; C-qで半角カナ
;; ダメなら M-x japanese-hankaku-region
(setq skk-use-jisx0201-input-method t)
(setq skk-search-katakana 'jisx0201-kana)
