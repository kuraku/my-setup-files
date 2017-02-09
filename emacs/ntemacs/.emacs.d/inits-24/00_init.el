;; -*- emacs-list -*-
;; @@ Init
;; Time-stamp: <2014-02-13 17:45 akira.masuda>

;; Emacsデフォルトの設定など

;;; @ FUNC check & create dir
(defun ma:check-create-dir (dir-name)
  "create directory for prefile."
  (interactive)
  (let ((dir (file-name-directory dir-name)))
	(unless (file-exists-p dir)
	  (if (y-or-n-p (format "May I create %s dir on your home?:"
							(expand-file-name dir-name)))
		  (make-directory dir t)))))

;; 12.10.16(tue)-18:28 for emacs24
(when is_emacs24
  (setq directory-sep-char ?/)
  ;;
  (setq x-select-enable-clipboard nil)
  (setq select-active-regions t)
  (setq mouse-drag-copy-region t)
  (setq x-select-enable-primary t)
  
  (global-set-key [mouse-2] 'mouse-yank-at-click))

;;; @ key setting
(keyboard-translate ?\C-h ?\C-?)

;;(load-library "term/vt100")
;;(load-library "term/bobcat")

;; startup message none
(setq inhibit-startup-message nil)
;; eof line
(setq next-line-add-newlines nil)
;; kill line
(setq kill-whole-line t)
;; line number
(line-number-mode 1)
;; tab width
(setq-default tab-width 4)

;; help-for-help
(global-set-key "\eh" 'help-for-help)

;;(global-set-key "\C-x\C-b" 'ibuffer)
(global-set-key "\C-x\C-b" 'bs-show)
(setq bs--show-all t)

;;(global-set-key "\C-x\C-b" 'electric-buffer-list)
(eval-after-load "ebuff-menu"
  '(progn
     (define-key electric-buffer-menu-mode-map "x" 'Buffer-menu-execute)
     (define-key electric-buffer-menu-mode-map "f"
	   'Electric-buffer-menu-select) ))

;;;; @ other window.p
;;(global-set-key "\C-x\C-n" 'other-window)
;;
;;(defun other-window-backward (&optional n)
;;  "select nth previous window."
;;  (interactive "p")
;;  (other-window (- (prefix-numeric-value n))))
;;
;;(global-set-key "\C-x\C-p" 'other-window-backward)

;; @ NEW
;;次のウィンドウへ移動
(define-key global-map (kbd "C-x C-n") 'next-multiframe-window)
;;前のウィンドウへ移動
(define-key global-map (kbd "C-x C-p") 'previous-multiframe-window)

;;(defun other-frame-backward (&optional n)
;;  "select nth previous frame."
;;  (interactive "p")
;;  (other-frame (- (prefix-numeric-value n))))
;;(global-set-key "\C-x\ep" 'other-frame-backward)

;;(global-set-key "\e*" 'query-replace-regexp)

;; @ goto line
;;(define-key global-map "\C-]" 'goto-line)
;; -> M-g M-g

;; @ スクロールバー OFF
(set-scroll-bar-mode nil)

;; ミニバッファの大きさを変える(ない)
(setq resize-mini-windows t)

;; 他のウィンドウにはカーソルを表示しない
(setq cursor-in-non-selected-windows nil)

;;
;;(show-paren-mode t)

;; no backup
(setq make-backup-files nil)

;; ブックマークをすぐに保存 (1回の変更で)
(setq bookmark-save-flag 1)

;; @ 使ってないか?
(setq user-full-name "MASUDA Akira"
	  user-full-name-ja "増田 明"
	  user-mail-address "masuda@posren.com")
;; user-mail-address "masuda@kuraku.net")

;;; @ where to put save file
(setq name-savedir "~/.emacs.d/.saves/")
(ma:check-create-dir name-savedir)
(when (file-exists-p name-savedir)
  (setq auto-save-list-file-prefix name-savedir))

;; @ region 反転しない
;; 08.04.21(mon)-11:58
(setq transient-mark-mode nil)

;; @ 場所保存
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/.places")

;;; @ History
(add-hook 'kill-emacs-hook 'save-histories)
;;(defvar histories-file (concat "~/.histories-" (system-name))
;;  "*File name for keeping histories.")
(defvar histories-file  "~/.emacs.d/.histories"
  "*File name for keeping histories.")

(defvar histories-save-history-list 
  '(extended-command-history
	command-history
	;;compile-history
	file-name-history
	;;grep-find-history
	;;grep-history
	query-replace-history
	regexp-history
	shell-command-history)
  "*List of history lists for keeping.")

(defun save-histories ()
  "Save history lists into `histories-file'."
  (let ((history-list histories-save-history-list)
		history)
    (save-excursion
	  (set-buffer (find-file histories-file))
	  (erase-buffer)
	  (while (setq history (car history-list))
		(pp `(setq ,history ',(eval history)) (current-buffer))
		(setq history-list (cdr history-list)))
	  (save-buffer))))

(if (file-readable-p histories-file)
    (load-file histories-file))
