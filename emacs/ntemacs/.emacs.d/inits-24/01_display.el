;; -*- emacs-list -*-
;; @@ Display
;; Time-stamp: <2016-10-14 12:31 akira.masuda>

;; Window settings
(if window-system
    (progn
      (set-frame-parameter nil 'alpha 85)  ; 透明度
      (tool-bar-mode nil)                  ; ツールバー非表示
      (set-scroll-bar-mode nil)            ; スクロールバー非表示
      (setq line-spacing 0.2)              ; 行間
      (when (>= emacs-major-version 23)
        (tool-bar-mode nil)
		(set-default-font "M+2VM+IPAG circle-10")
        (set-fontset-font (frame-parameter nil 'font)
                          'japanese-jisx0208
                          (font-spec :family "M+2VM+IPAG circle" :size 14)))
      (setq ns-pop-up-frames nil)))


;; Color Settings
;;(set-face-foreground 'default "seashell2")
(set-face-foreground 'default "white")
;;(set-face-background 'default "black")
(set-face-background 'default "black")
;;(set-face-background 'default "DarkSlateGrey")
(set-face-background 'cursor "LimeGreen")
;;(set-face-background 'cursor "pink")
(set-face-foreground 'mode-line "white")
(set-face-background 'mode-line "aquamarine4")
;;(set-face-background 'mode-line "darkslategrey")
(set-face-foreground 'modeline-inactive "white")
(set-face-background 'modeline-inactive "DarkSeaGreen4")

;; モードライン(アクティブでないバッファ)の文字色。
;;(set-face-foreground 'mode-line-inactive "white")
;; モードライン(アクティブでないバッファ)の背景色。
;;(set-face-background 'mode-line-inactive "grey50")
(set-face-bold-p 'mode-line nil)
;130329;(set-face-underline-p 'modeline "DarkOliveGreen")
;;(set-face-underline 'mode-line-inactive "gray60") ;;old
(set-face-background 'mode-line-inactive "gray60")

;; 07.12.19(wed)-13:42
;; space tab color
;;; タブと全角スペースを目立たせる
(defface my-face-zenkaku '((t (:background "gray25" :foreground "white"))) nil)
;;(defface my-face-b-1 '((t (:background "LightCyan1" :foreground "black"))) nil)
(defface my-face-last-space '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-zenkaku 'my-face-zenkaku)
(defvar my-face-last-space 'my-face-last-space)
(defface my-face-under-gray '((t (:foreground "gray25" :underline t))) nil)
(defvar my-face-under-gray 'my-face-under-gray)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
	 ("　" 0 my-face-zenkaku append)
	 ("[（）？]" 0 my-face-zenkaku append)
	 ("\t" 0 my-face-under-gray append) ;;	 
	 ("[ ]+$" 0 my-face-last-space append) ;;  
	 )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks 
		  '(lambda ()
			 (if font-lock-mode nil (font-lock-mode t))) t)

;;
(setq w32-use-w32-font-dialog nil)

;; default window place
(setq default-frame-alist
	  (append (list
			   '(width . 100)
			   '(height . 52)
			   '(top . 16)
			   '(left . 20))
			  default-frame-alist))

;;(setcdr (assoc 'height default-frame-alist) 66) ;; ignore??
;;(set-frame-height (selected-frame) 56)
(setq initial-frame-alist default-frame-alist)

;; ウィンドウ半透明
(cond
 (is_emacs22 ;; emacs-ver "22"
  (set-alpha 85))
 ((or is_emacs23 is_emacs24)
  ;;(ma:set-alpha-23 83))
  (set-frame-parameter (selected-frame) 'alpha 86)) ;; def 90
 )
;;
(defun ma:set-alpha (&optional alpha)
  (interactive "P")
  (let ((al (if alpha alpha 8)))
	(set-active-alpha (/ al 10.0))
	(set-inactive-alpha (/ al 10.0))))

(defun ma:change-alpha ()
  (interactive)
  (if (fboundp 'set-alpha)
	  (progn
		(let ((tr 80) c)
		  (set-alpha (list tr (- tr 10)))
		  (catch 'endFlg
			(while t
			  (message "change alpha set. p:up n:down alpha:%s/%s" tr (- tr 10))
			  (setq c (read-char))
			  (cond ((= c ?p)
					 (setq tr (or (and (> (+ tr 5) 100) 100) (+ tr 5)))
					 (set-alpha (list tr (- tr 10))))
					((= c ?n)
					 (setq tr (or (and (<= (- tr 5) 0) 1) (- tr 5)))
					 (set-alpha (list tr (- tr 10))))
					((and (/= c ?p) (/= c ?n))
					 (message "quit alpha:%s/%s" tr (- tr 10))
					 (throw 'endFlg t)))))))
	(message "don't exist set-alpha()")))

(defun ma:set-alpha-23 (alpha)
  (interactive)
  (let* ((op (frame-parameter (selected-frame) 'alpha))
		 val)
	(unless op
	  (setq op 100))
	(when (setq val (cond
					 ((eq alpha 'up) (if (> op 95) 100 (+ op 5)))
					 ((eq alpha 'down) (if (> 5 op) 5 (- op 5)))
					 ((eq alpha 'clear) 100)
					 ((numberp alpha) alpha)
					 (t nil)))
	  (set-frame-parameter (selected-frame) 'alpha val))))

(defun ma:change-alpha-23 ()
  (interactive)
  (if (fboundp 'ma:set-alpha-23)
	  (progn
		(let ((tr 90) (n 1) c)
		  (ma:set-alpha-23 tr)
		  (catch 'endFlg
			(while t
			  (message "change alpha set. p:up n:down alpha:%s" tr)
			  (setq c (read-char))
			  (cond ((= c ?p)
					 (setq tr (or (and (> (+ tr n) 100) 100) (+ tr n)))
					 (ma:set-alpha-23 tr))
					((= c ?n)
					 (setq tr (or (and (<= (- tr n) 0) 1) (- tr n)))
					 (ma:set-alpha-23 tr))
					((and (/= c ?p) (/= c ?n))
					 (message "quit alpha:%s" tr)
					 (throw 'endFlg t)))))))
	(message "don't exist set-alpha()")))
;;(define-key my-key-map "a" 'ma:change-alpha-23)

;; window タイトル
;;(setq frame-title-format `("%b" (buffer-file-name " (%f)")))
;;(setq frame-title-format (format "emacs@%s : %%f" (system-name)))
(setq frame-title-format "Emacs: %b")

;; 11.01.11(tue)-18:28
;; 正規表現を見易く
(set-face-foreground 'font-lock-regexp-grouping-backslash "#666")
(set-face-foreground 'font-lock-regexp-grouping-construct "#f60")

;; 11.02.15(tue)-12:40
;; ポップアップ
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
;; my-key j で dired-jump-other-window を呼ぶように設定されている
(push '(dired-mode :position top) popwin:special-display-config)

;; 11.03.15(tue)-17:34
(defun ma:ms-gothic-font ()
  (interactive)
  (set-default-font "ＭＳ ゴシック-10"))

;; 11.04.12(tue)-10:48
;; フルスクリーン win用
;; 通常時の nil
(defvar w32-window-full nil)

(defun w32-fullscreen-switch-frame ()
  (interactive)
  (setq w32-window-full (not w32-window-full))
  (if w32-window-full
	  (w32-fullscreen-maximize-frame)
	(w32-fullscreen-restore-frame)
    ))
  
(defun w32-fullscreen-maximize-frame ()
  "Maximize the current frame (windows only)"
  (interactive)
  (w32-send-sys-command 61488))

(defun w32-fullscreen-restore-frame ()
  "Restore a minimized/maximized frame (windows only)"
  (interactive)
  (w32-send-sys-command 61728))

;;
;; 11.04.08(fri)-13:43
;; scrollbar
;(if window-system
;    (progn
;	  (require 'yascroll)
;	  (global-yascroll-bar-mode 1) ))

