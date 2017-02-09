;;; @@ ** outline mode **
(setq outline-regexp
	    "[ \t]*\\(■\\|□\\|▼\\|▽\\|●\\|○\\|◆\\|◇\\|\\|[0-9]+\\.\\)+")

;; outline minor prefix
(setq outline-minor-mode-prefix "\m- ")
;(setq outline-minor-mode-prefix "^x ")

(defconst outline-font-lock-keywords
  '(
	("^[ \t]*\\([0-9]+\\. \\)" (1 font-lock-my-bold-face) )
	("^[ \t]*\\(▼.*\\)$" (1 font-lock-my-02-face) )
	("^[ \t]*\\(▽.*\\)$" (1 font-lock-my-07-face) )
	("^.*\\(■.*\\)$" (1 font-lock-my-01-face) )
	("^.*\\(◆.*\\)$" (1 font-lock-my-15-face) )
	("^.*\\(◇.*\\)$" (1 font-lock-my-16-face) )
	("^.*\\(【.*\\)$" (1 font-lock-my-01-face) )
	("^.*\\(●.*\\)$" (1 font-lock-function-name-face) )
	("^.*\\(○.*\\)$" (1 font-lock-my-08-face) )
	("\\(□\\)" (1 font-lock-comment-face) )
	("\\(「[^\\「]*\\(\\\\\\(.\\|\n\\)[^\\」]*\\)*」\\)" (1 font-lock-variable-name-face) )
	("\\('[^\\'\\`]*\\(\\\\\\(.\\|\n\\)[^\\'\\`]*\\)*'\\)" (1 font-lock-type-face) )
	("\\(\([^\\\(]*\\(\\\\\\(.\\|\n\\)[^\\\)]*\\)*\)\\)" (1 font-lock-my-06-face) )
	("\\(`[^\\']*\\(\\\\\\(.\\|\n\\)[^\\']*\\)*'\\)" (1 font-lock-reference-face) )
	) "additional expressions to highlight in outline mode.")

(put 'outline-mode 'font-lock-defaults '(outline-font-lock-keywords nil t))

;;; @ face を追加する
(font-lock-add-keywords
 'outline-mode
 '(
   ("\\(\\(ht\\|f\\)tps?:[^ \t\n\r\"\']*\\)" (1 font-lock-my-underline-face t))
   ("\\(mailto:[^ \t\n\r\"\']*\\)" (1 font-lock-my-underline-face t))
   ("\\(masuda,? ?a\\(kira\\)?\\)" (1 font-lock-masuda-face t))
   ("^[ \t]*> *> *>\\([^\r\n]*\\)" (1 font-lock-reference-face) )
   ("^[ \t]*> *>\\([^\r\n>]*\\)" (1 font-lock-keyword-face) )
   ("^[ \t]*>\\([^\r\n>]*\\)" (1 font-lock-my-11-face) )
   ("^[ \t]*\|\\([^\r\n>]*\\)" (1 font-lock-my-11-face) )
   ("^[ \t]*\\(\([0-9]+\) ?\\)" (1 font-lock-my-bold-face) )
   ("^[ \t]*\\([0-9]+\) ?\\)" (1 font-lock-my-bold-face) )
   ))

;; top level jump.
(defun outline-jump-root ()
  (interactive)
  (search-backward-regexp "^[^ \t\n\r]+")
  (recenter 0))

;;
(add-hook 'outline-mode-hook
		    '(lambda ()
			   ;; “更新日”の自動更新
			   (make-local-variable 'time-stamp-start)
			   (setq time-stamp-start "更新日:[ \t]+\\\\?[\"<]+")
			   (make-local-variable 'time-stamp-format)
			   ;;(setq time-stamp-format
				;;     '(time-stamp-yyyy/mm/dd time-stamp-hh:mm:ss))
			   ;;
			   (make-local-variable 'time-stamp-strings)
			   (setq time-stamp-strings "更新日: \" \"")
			   ;;
			   (make-local-variable 'time-stamp-old-format-warn)
			   ; 独自のフォーマットでいいのか訊かれるので、
			   (setq time-stamp-old-format-warn nil)
			   ;;
			   (make-local-variable 'fill-column)
			   (setq fill-column 78)
			   (auto-fill-mode)
			   ;;
			   (make-local-variable 'indent-line-function)
			   (setq indent-line-function 'indent-relative-maybe)
			   (local-set-key "\C-m" 'newline-and-indent)
			   ;
			   ;(local-set-key "\C-x\el" 'outline-jump-root)
			   ))
