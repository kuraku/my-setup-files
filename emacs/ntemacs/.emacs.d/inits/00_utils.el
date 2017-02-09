;; -*- emacs-lisp -*-
;; @@ Utils
;; Time-stamp: <2013-09-11 14:23 akira.masuda>

;; ;;; @ FUNC check & create dir
;; (defun ma:check-create-dir (dir-name)
;;   "create directory for prefile."
;;   (interactive)
;;   (let ((dir (file-name-directory dir-name)))
;; 	(unless (file-exists-p dir)
;; 	  (if (y-or-n-p (format "May I create %s dir on your home?:"
;; 							(expand-file-name dir-name)))
;; 		  (make-directory dir t)))))

;; 10.11.05(fri)-13:19
;; @ ライブラリがあるときだけrequireする
;; via http://e-arrows.sakura.ne.jp/2010/03/macros-in-emacs-el.html
(defmacro req (lib &rest body)
  `(when (locate-library ,(symbol-name lib))
     (require ',lib) ,@body))

;; 10.11.24(wed)-14:24
;; @ load-pathを他のバッファでリスト
(defun ma:list-load-path (&optional arg)
  "load-path を他のバッファでリスト表示する."
  (interactive "P")
  (let ((str) (buf "*List-Load-Path*") (msg "------- load path -------\n\n")
		(list-fmt (if arg "%s:0:\n" "%s\n")))
  	(mapcar (function (lambda (p) (setq str (concat str (format list-fmt p))))) load-path)
	(if (get-buffer buf) (kill-buffer buf))
	(with-current-buffer (get-buffer-create buf)
	  (setq buffer-read-only nil)
  	  (display-buffer (current-buffer))
	  (insert msg) (insert str)
	  ;;(goto-char (length msg))
 	  (setq buffer-read-only t)
	  (if arg (grep-mode) (fundamental-mode)) )))

(defun ma:posren-program ()
  (interactive)
  (let ()
	(setq indent-tabs-mode nil)
	(setq tab-width 4)))

;; new buffer
(defun generate-buffer (buffer-name)
  "新しいバッファを名前をつけて、作る"
  (interactive "sNew Buffer name: ")
  (let ((new-name (format "**%s*" buffer-name)))
	(generate-new-buffer new-name)
	(switch-to-buffer new-name)))
;;(define-key my-key-map "g" 'generate-buffer)

;; 2013.05.24(fri)-14:23
;;C-h（BackSpace）でリージョンを一括削除
(delete-selection-mode 1)

;;
(defun ma:number-region-input (num)
  "リージョンにナンバーをふる。
引き数をつけると、その番号からスタート"
  (interactive "sStart Number:")
  (save-excursion
	(let
		((num (if num (string-to-number num) 1))
		 (e (max (region-end) (region-beginning)))
		 (b (min (region-end) (region-beginning))))
	  (goto-char b)
	  (while (<= (+ (point) 1) e)
		(beginning-of-line)
		(insert (format "%3d: " num))
		(setq e (+ e 5))
		(setq num (+ num 1))
		(forward-line 1)))))

;;
;;; @ time stamp
(autoload 'time-stamp "time-stamp")
(if (not (memq 'time-stamp write-file-hooks))
	(setq write-file-hooks
		  (cons 'time-stamp write-file-hooks)))
(setq time-stamp-format "%:y-%02m-%02d %02H:%02M %u")


;; 2013-09-11 wed 14:22
;; C-Enter でマーク M-o 空け M-n 連番 C-? ヘルプ
;(cua-mode t) ; On/Off toggle
(setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止
