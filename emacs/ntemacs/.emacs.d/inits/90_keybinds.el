;; -*- emacs-list -*-
;; @@ Keybinds
;; Time-stamp: <2016-02-16 20:04 akira.masuda>
;; my-keyp-map は、00_mykeypmap.el にて定義

;; default の repeat 機能を引き継ぐ (この prefix の場合)
;; C-x ESC ESC
;;(define-key my-key-map "\e" 'repeat-complex-command)

;; @ pwd
(define-key my-key-map "p" 'pwd)
(define-key my-key-map "\C-p" 'pwd)

;;; @ other frame.
;;; 08.01.30(wed)-16:40
;;(define-key my-key-map "f" 'other-frame)

;; @ occur key
;;(define-key my-key-map "o" 'occur)
(define-key my-key-map "o" 'moccur)		;color-moccur
(define-key my-key-map "f" 'moccur-grep-find)		;color-moccur

;; display version of Emacs
(define-key my-key-map "?"
  '(lambda () "Display Emacs Version." (interactive)(message "%s" (emacs-version))))


;; 透明度調整
(if (fboundp 'ma:change-alpha-23)
	(define-key my-key-map "a" 'ma:change-alpha-23))

;; 次のウィンドウと入れ替え
(if (fboundp 'swap-screen-with-cursor)
	(global-set-key [f9] 'swap-screen-with-cursor))

;; 11.04.06(wed)-14:54
(global-set-key [C-up] 'windmove-up)
(global-set-key [C-down] 'windmove-down)
(global-set-key [C-left] 'windmove-left)
(global-set-key [C-right] 'windmove-right)

;; 11.04.12(tue)-10:52
;; フルスクリーン
(if (fboundp 'w32-fullscreen-switch-frame)
	(global-set-key [f11] 'w32-fullscreen-switch-frame))
;; fboundp が nil を返しているよう
;;(global-set-key [f11] 'w32-fullscreen-switch-frame)

;; 11.04.12(tue)-14:18
;; yank with anything
(if (fboundp 'anything-show-kill-ring)
	(global-set-key "\M-y" 'anything-show-kill-ring))

;; 11.04.15(fri)-14:33
(if (fboundp 'generate-buffer)
	(progn
	  (define-key my-key-map "\C-b" 'generate-buffer)
	  (define-key my-key-map "g" 'generate-buffer)
	  (define-key my-key-map "b" 'generate-buffer) ))
;; fboundp が nil を返しているよう
;;(define-key my-key-map "g" 'generate-buffer)

;; linum-mode を使う
;; 10.11.05(fri)-12:54
(define-key my-key-map "n" 'linum-mode)

;; 11.04.18(mon)-15:54
(if (fboundp 'orgmemo)
	(define-key my-key-map "N" 'orgmemo))

;; ;; 2013.05.23(thu)-18:32
;; ;; なぜか動かなくなったので
;; (and (fboundp 'anything)
;; 	 (define-key global-map (kbd "M-x")
;; 	   (lambda () "Execute emacs commands in anything"
;; 		 (interactive)
;; 		 (anything '(anything-c-source-emacs-commands)))) )

;; 13.07.31(wed)-12:49
(if (fboundp 'remember)
    (global-set-key [f8] 'org-remember))

;; date time
(define-key my-key-map "i" 'ma:display-time-date)
(define-key my-key-map "t" 'ma:insert-date-time)

;; dired here
;;(global-set-key (kbd "\C-x\C-d") 'dired-here)
