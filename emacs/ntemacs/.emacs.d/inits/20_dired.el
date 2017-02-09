;; -*- emacs-list -*-
;; @@ Dired
;; Time-stamp: <2016-02-16 20:06 akira.masuda>

;; @ dired
(load "dired-x")

(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
;; 07.10.18(thu)-16:16 b:上のディレクトリへ
(add-hook 'dired-mode-hook
		  '(lambda ()
			 (define-key dired-mode-map "b" 'dired-up-directory)
			 (define-key dired-mode-map "\C-?" 'dired-up-directory)))

(setq dired-guess-shell-alist-default
	  (append '(
				("\\.html?$" "C:/Program Files/Mozilla Firefox/firefox.exe")
				("\\.gz$" "c:/application/convertor/explzh/explzh.exe")
				("\\.zip$" "c:/application/convertor/explzh/explzh.exe")
				("\\.lzh$" "c:/application/convertor/explzh/explzh.exe")
				("\\.tar$" "c:/application/convertor/explzh/explzh.exe")
										;("\\.xls$" "c:/Program\\ Files/MicrosoftOffice2k3/OFFICE11/EXCEL.EXE")
				("\\.xls$" "/usr/bin/ooffice -calc *")
				("\\.doc$" "/usr/bin/ooffice -writer *")
				)
			  dired-guess-shell-alist-default))

;; dired でディレクトリを先頭に表示
(setq ls-lisp-dirs-first t)

;; wdired 061226
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; 今日変更したファイルに色をつける 03.02.11(Tue)-00:41
(defface face-file-edited-today '((t (:foreground "GreenYellow"))) nil)
(defvar face-file-edited-today 'face-file-edited-today)
(defun my-dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   ;; "02-13 15:02" に対応
   (concat (format-time-string "%m-%d" (current-time)) " [0-9]....") arg t))
;; (concat (format-time-string "%m-%d" (current-time)) " [0-9]....") nil nil nil))
;;(concat (format-time-string "%b %e" (current-time)) " [0-9]....") arg t))

(add-hook 'dired-mode-hook
		  '(lambda ()
			 (font-lock-add-keywords
			  major-mode
			  (list
			   '(my-dired-today-search . face-file-edited-today)
			   ))))

;; 新しくbufferを作らない
(require 'dired)
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map "a" 'dired-advertised-find-file)

;; 11.02.15(tue)-13:21
(define-key global-map "\C-x4j" 'dired-jump-other-window)
;;(define-key my-key-map "j" 'dired-jump-other-window)

;; 2016-02-09 tue 17:58
;; diredバッファにファイルをドラッグしてもコピーしない
(setq dired-dnd-protocol-alist
      '(("^file:///" . dnd-open-local-file)
        ("^file://"  . dnd-open-file)
        ("^file:"    . dnd-open-local-file)))

;; let "C-x C-d" dired current directory
(defun dired-here ()
  (interactive)
  (dired "."))

;;(global-unset-key (kbd "\C-x\C-d"))
(global-set-key (kbd "\C-x\C-d") 'dired-here)
