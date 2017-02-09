;; dot.emacs for NTEmacs  -*- emacs-lisp -*-
;; change 2006.12.28 MAS
;; updated 2007.09.20 MAS
;; updated 2009.10.06 mas
;; Time-stamp: <2010-11-05 19:09:32 masuda>

;; Tips
;; ファイルを指定コードで開き直す: C-x RET c 文字コードを入力 RET C-x C-v RET
;; 重複する関数を取得: M-x list-load-path-shadows

;; @ emacs version
(defconst ma:emacs-ver
	  (concat (int-to-string emacs-major-version)
			  "." (int-to-string emacs-minor-version)))
;;
(setq load-path
      (append (list (expand-file-name "~/elisp/")) load-path))

;; @ CD home
(cd "~")

;;
(global-font-lock-mode t)

;;; @ coding-system
;; 
(set-terminal-coding-system 'euc-jp)
(set-keyboard-coding-system 'euc-jp)
(set-buffer-file-coding-system 'euc-jp)
(setq default-buffer-file-coding-system 'euc-jp)
(prefer-coding-system 'euc-jp)
(set-default-coding-systems 'euc-jp)
(setq file-name-coding-system 'euc-jp)

;;; @ FUNC check & create dir
(defun ma:check-create-dir (dir-name)
  "create directory for prefile."
  (interactive)
  (let ((dir (file-name-directory dir-name)))
	(unless (file-exists-p dir)
	  (if (y-or-n-p (format "May I create %s dir on your home?:"
							(expand-file-name dir-name)))
		  (make-directory dir t)))))
;;; @ FUNC check file
(defun ma:check-file (file-name)
  (interactive)
  (let ((file file-name))
	(unless (file-exists-p file)
	  (progn
		(message (format "file not found: %s" file))
		(sit-for 2)))))

;;; @ where to put save file
(setq name-savedir "~/.saves/")
(ma:check-create-dir name-savedir)
(if (file-exists-p name-savedir)
    (setq auto-save-list-file-prefix name-savedir))

;; @ region 反転しない
;; 08.04.21(mon)-11:58
(setq transient-mark-mode nil)

;; @ My key perfix
;; Keymap C-TAB (or C-x ESC)
;; 08.01.16(wed)-11:36
(defvar my-key-map (make-sparse-keymap)
  "keymap for masuda commands of C-tab.")
;(global-set-key (kbd "C-<tab>") my-key-map)
(global-set-key (kbd "C-x x") my-key-map)
(global-set-key (kbd "C-x ESC") my-key-map)
(global-set-key [?\C-;] my-key-map) ;'
;(global-set-key (kbd "C-x ESC") ;my-key-map)
;				'(lambda () (interactive)(message "My prefix key is \"C-<tab>\".")))

;; default の repeat 機能を引き継ぐ (この prefix の場合)
;; C-x ESC ESC
;(define-key my-key-map "\e" 'repeat-complex-command)

;; display version of Emacs
(define-key my-key-map "?"
  '(lambda () "Display Emacs Version." (interactive)(message "%s" (emacs-version))))

;;; @ key setting
(keyboard-translate ?\C-h ?\C-?)

(load-library "term/vt100")
;(load-library "term/bobcat")

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

;(global-set-key "\C-x\C-b" 'ibuffer)
(global-set-key "\C-x\C-b" 'bs-show)
(setq bs--show-all t)

;(global-set-key "\C-x\C-b" 'electric-buffer-list)
(eval-after-load "ebuff-menu"
  '(progn
     (define-key electric-buffer-menu-mode-map "x" 'Buffer-menu-execute)
     (define-key electric-buffer-menu-mode-map "f"
	   'Electric-buffer-menu-select) ))

;;; @ other window.p
(global-set-key "\C-x\C-n" 'other-window)

(defun other-window-backward (&optional n)
  "select nth previous window."
  (interactive "p")
  (other-window (- (prefix-numeric-value n))))

(global-set-key "\C-x\C-p" 'other-window-backward)

;;
(define-key my-key-map "p" 'pwd)

;;; @ occur key
(define-key my-key-map "o" 'occur)

;;; @ goto line
(define-key global-map "\C-]" 'goto-line)

;;; @
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.places")

;;
(load "dired-x")
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
; 07.10.18(thu)-16:16 b:上のディレクトリへ
(add-hook 'dired-mode-hook
		  '(lambda ()
			 (define-key dired-mode-map "b" 'dired-up-directory)
			 (define-key dired-mode-map "\C-?" 'dired-up-directory)))

;; @@ set register
(set-register ?m '(file . "~/.emacs23.unix.el"))
(set-register ?e '(file . "~/.emacs.el"))
(set-register ?s '(file . "/usr/local/share/emacs/site-lisp"))
(set-register ?f '(file . "~/.folders"))
(set-register ?w '(file . "~/.wl"))
;(set-register ?d '(file . "~/memo.txt"))
(set-register ?d '(file . "c:/Documents and Settings/masuda/デスクトップ"))


;;
;(set-scroll-bar-mode nil)

;; @ 圧縮ファイルも読める
(require 'jka-compr)

;; dired でディレクトリを先頭に表示
(setq ls-lisp-dirs-first t)

;; ミニバッファの大きさを変える(ない)
(setq resize-mini-windows t)

;; 他のウィンドウにはカーソルを表示しない
(setq cursor-in-non-selected-windows nil)

;; no backup
(setq make-backup-files nil)

;;; @ match-paren
(define-key emacs-lisp-mode-map "%" 'match-paren)
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
 "Go to the matching parenthesis if on parenthesis otherwise insert %."
 (interactive "p")
 (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
 ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
 (t (self-insert-command (or arg 1)))))

;; 読み込みが遅いわけはないので外す
;; ;; @ 03.09.03(Wed)-20:28
;; ;; do Byte-comple when the file save.
;; (setq ma:byte-comple-list '("~/.emacs23.unix.el"))
;; (add-hook 'after-save-hook
;; 		  (lambda ()
;; 			(mapcar
;; 			 (lambda (file)
;; 			   (setq file (expand-file-name file))
;; 			   (when (string= file (buffer-file-name))
;; 				 (save-excursion (byte-compile-file file))))
;; 			 ma:byte-comple-list)))

;;; @ line Top
(defun line-to-top-of-window ()
  "カーソル位置をウィンドウのトップにする"
  (interactive)
  (recenter 0))
(global-set-key "\el" 'line-to-top-of-window)

;;; @ History
(add-hook 'kill-emacs-hook 'save-histories)

;(defvar histories-file (concat "~/.histories-" (system-name))
;  "*File name for keeping histories.")
(defvar histories-file  "~/.histories"
  "*File name for keeping histories.")

(defvar histories-save-history-list '(extended-command-history
					command-history
					;compile-history
					file-name-history
					;grep-find-history
					;grep-history
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

;; buffer list
;(require 'ibuffer)
;(setq ibuffer-default-sorting-mode "recency")
;(setq ibuffer-formats
;      '((mark modified read-only " " (name 30 30)
;              " " (size 6 -1) " " (mode 16 16) " " filename)
;        (mark " " (name 30 -1) " " filename)))

; ;;; @ ruby-mode
; (autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files")
; (setq auto-mode-alist
;       (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
; (setq interpreter-mode-alist
;       (append '(("^#!.*ruby" . ruby-mode)) interpreter-mode-alist))
; 
; (add-hook 'ruby-mode-hook
; 	  '(lambda ()
; 	     (inf-ruby-keys)))
; (setq ruby-indent-level 3)

;; 08.02.07(thu)-13:50
(setq user-full-name "MASUDA Akira"
	  user-full-name-ja "増田 明"
	  user-mail-address "masuda@posren.com")

;; wdired 061226
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; 折り返し toggle
(defalias 'tt 'toggle-truncate-lines)

;; @@ mysql 
(setq sql-mysql-program "/usr/local/mysql/bin/mysql")

(eval-after-load "sql"
  (progn
	;;(load-library "sql-indent")
	(when (locate-library "sql-complete")
	  (load-library "sql-complete"))
	;;(load-library "sql-transform") 
	))

(defun sql-in-mysql ()
  (if (and (buffer-live-p sql-buffer)
		   (string-match "mysql" sql-prompt-regexp))
      t
    nil))

(defvar sql-mysql-coding-system-alist
  '((euc-jp . "ujis")
    (shift_jis . "sjis")
    (shift_jis . "cp932")
    (euc-jp . "eucjpms")
    (utf-8 . "utf8")))

(defun sql-mysql-get-coding-system (mysql-charset)
  (car (rassoc mysql-charset sql-mysql-coding-system-alist)))

(defun sql-mysql-set-charset (mysql-charset)
  (interactive "sCharset: ")
  (if (and (buffer-live-p sql-buffer)
		   (sql-in-mysql))
      (let ((cs (sql-mysql-get-coding-system mysql-charset)))
		(if cs
			(progn
			  (sql-send-string (format "charset %s;" mysql-charset))
			  (set-buffer-process-coding-system cs cs))
		  (message "Unknown charset: %s" mysql-charset)))))

;(add-hook 'sql-interactive-mode-hook
;		  '(lambda ()
;			 (if (sql-in-mysql)
;				 (sql-mysql-set-charset "ujis"))))

;; anything for mysql
(eval-after-load "anything"
  '(progn
	 (setq db-lists 
		   (list "posren3_admin" "posren3_analyze" "posren3_au" "posren3_central"
				 "posren3_contents" "posren3_geo" "posren3_livedoor" "posren3_member"
				 "posren3_payment" "posren3_sbm"))
	 (setq anything-c-source-posren-db
	   '((name . "posren DB")
		 (candidates . db-lists)
		 (action
		  . (("Insert" . (lambda (candidate)
						   (insert (concat "use " candidate ";"))))))))
	 (defun anything-posren-db ()
	   (interactive)
	   (anything 'anything-c-source-posren-db))

	 (setq anything-c-source-sql
		   '((name . "insert SQL")
			 (candidates "select" "count" "update" "join" "alter add" "alter change")
			 (action
			  . (("Insert" . (lambda (candidate)
							   (cond
								((equal "select" candidate)
								 (insert "SELECT * FROM table1 \n  WHERE ;"))
								((equal "count" candidate)
								 (insert "SELECT count(id) FROM table1 \n  WHERE ;"))
								((equal "update" candidate)
								 (insert "UPDATE table1 SET col=val \n  WHERE ;"))
								((equal "join" candidate)
								 (insert (concat "SELECT table1.* FROM table1\n"
												 "  LEFT JOIN table2 ON table1.id=table2.id\n"
												 "  WHERE table2.id IS NULL ;")))
								((equal "alter add" candidate)
								 (insert "ALTER TABLE table1 ADD column1 condition ;"))
								((equal "alter change" candidate)
								 (insert "ALTER TABLE table1 CHANGE column1 column-new condition ;"))
								)))))))

	 (defun anything-sql ()
	   (interactive)
	   (anything 'anything-c-source-sql))
	 ))

;; mysql end

; key set
;(global-set-key "\e=" 'what-line)
(global-set-key "\es" 'enlarge-window)

;;; @ display time
(setq display-time-string-forms
	  '(month "/" day " " dayname " " 24-hours ":" minutes))
;  '(month "/" day " " dayname " "))
(global-set-key [f3] 'display-time-mode)

(defun ma:display-time-date ()
  (interactive)
  (message (format-time-string "%Y.%m.%d (%A) - %r" (current-time))))
(global-set-key [f4] 'ma:display-time-date)
(define-key my-key-map "i" 'ma:display-time-date)

;;; @ date/time insert
(defun ma:insert-date-time (&optional confirm)
  (interactive "P")
  (let* ((wlist '("sun" "mon" "tue" "wed" "thu" "fri" "sat"))
		 (week-str (car (nthcdr (string-to-number (format-time-string "%w" (current-time))) wlist)))
		 date-str)
	(if confirm
	    (insert (format-time-string "%y.%m.%d" (current-time)))
	  (progn
		(setq date-str (format-time-string "%y.%m.%d(%%s)-%R" (current-time)))
		(insert (format date-str week-str))))))
(define-key my-key-map "t" 'ma:insert-date-time)

;;; @ debug-on-error toggle
(defun ma:toggle-debug-on ()
  (interactive)
  (setq debug-on-error (not debug-on-error))
  (message "Debug-on-error flag is %s" (or (and debug-on-error "ON") "OFF") ))
(define-key my-key-map "d" 'ma:toggle-debug-on)

;;; @ 行頭が、タブかスペースだけの行は、空にする
(defun ma:only-tabspace-cut ()
  (interactive)
  (let ((n 0))
	  (save-excursion
	    (beginning-of-buffer)
	    (while (re-search-forward "^[ 	]+$" nil t)
		  (setq n (+ n 1))))
	  (if (> n 0)
		  (if (y-or-n-p (format "%d 個にマッチしました 変換しますか?" n))
			  (progn
			    (save-excursion
				  (beginning-of-buffer)
				  (replace-regexp "^[ 	]+$" "" nil)))
		    (message ""))
		  (message "マッチしませんでした."))))
;
(define-key my-key-map "k" 'ma:only-tabspace-cut)

;;; @ 行末が、タブかスペースだけの行は、空にする
;; (delete-trailing-whitespace) と同じ機能
(defun ma:followspace-cut ()
  (interactive)
  (let ((n 0))
      (save-excursion
        (beginning-of-buffer)
        (while (re-search-forward "[ 	]+$" nil t)
          (setq n (1+ n))))
      (if (> n 0)
          (if (y-or-n-p (format "%d 個にマッチしました 変換しますか?" n))
              (progn
                (save-excursion
                  (beginning-of-buffer)
                  (replace-regexp "[ 	]+$" "" nil)))
            (message ""))
          (message "マッチしませんでした."))))
;
(define-key my-key-map "l" 'ma:followspace-cut)

;;; @ タブかスペースの連続をスペースひとつだけにする
;(defun ma:tabspace-cut ()
;  (interactive)
;  (replace-regexp "[	 ]+" " " nil (region-beginning) (region-end)))

(defun ma:tabspace-cut ()
  (interactive)
  (let
	  ((n 0)
	   (e (max (region-end) (region-beginning)))
	   (b (min (region-end) (region-beginning))))
	(save-excursion
	  (goto-char b)
	  (catch 'loop
		(while t
		  (if (> (+ (point) 1) e)
			  (throw 'loop t)
			(if (re-search-forward "[ 	]+" nil t)
				(setq n (+ n 1))
			  (throw 'loop t)))))
	  (if (> n 0)
		  (if (y-or-n-p (format "%d 個にマッチしました 変換しますか?" n))
			  (progn
				(goto-char b)
				(replace-regexp "[	 ]+" " " nil b e))
			(message ""))
		(message "マッチしませんでした.")))))

(define-key my-key-map " " 'ma:tabspace-cut)

;; history から重複したのを消す (M-x M-p とかの) 03.02.19(Wed)-10:59
(require 'cl)
(defun minibuffer-delete-duplicate ()
  (let (list)
    (dolist (elt (symbol-value minibuffer-history-variable))
      (unless (member elt list)
        (push elt list)))
    (set minibuffer-history-variable (nreverse list))))
(add-hook 'minibuffer-setup-hook 'minibuffer-delete-duplicate)

;; カーソルを点滅させない
(blink-cursor-mode nil)
;; 他のウィンドウにはカーソルを表示しない
(setq cursor-in-non-selected-windows nil)

;; ツールバーを表示しない
;(tool-bar-mode 0)

;(defun ma:toggle-toolbar ()
;  (interactive)
;  (if tool-bar-mode
;	  (tool-bar-mode 0) (tool-bar-mode 1))
;  (message "Tool-bar is %s" (or (and tool-bar-mode "ON") "OFF") ))
;(define-key my-key-map "m" 'ma:toggle-toolbar)

(define-key my-key-map "m"
  '(lambda ()
	 "ツールバー表示を ON/OFF"
	 (interactive)
	 (if tool-bar-mode
		 (tool-bar-mode 0) (tool-bar-mode 1))
	 (message "Tool-bar is %s" (or (and tool-bar-mode "ON") "OFF") )))

;; メニューバーを表示しない 03.02.18(Tue)-11:12
(menu-bar-mode -1)

(define-key my-key-map ","
  '(lambda ()
	 "メニューバー表示を ON/OFF"
	 (interactive)
	 (if menu-bar-mode
		 (menu-bar-mode -1) (menu-bar-mode 1))
	 (message "Menu-bar is %s" (or (and menu-bar-mode "ON") "OFF") )))

;;
(setq display-time-string-forms
  '(" " month "/" day " " 24-hours ":" minutes))
  ;;'((substring year -2) "/" month "/" day " " dayname " " 24-hours ":" minutes))
;(display-time)

;;; @ Unbind Key
(global-unset-key "\C-x\C-k")
(global-unset-key "\C-x\C-u")
(global-unset-key "\C-xt") ;tutorial
;(global-unset-key "\C-z") ;suspend

;; grep find
;; (setq grep-program "c:/bin/grep.exe")
;; (setq grep-command "c:/bin/grep.exe -nrH -e \"\" .")
;; (setq find-program "c:/bin/find.exe")
;; ;(setq grep-find-command "c:/bin/find.exe . -type f -exec c:/bin/grep.exe -nH -e \"\" {} NUL \;")
;; (setq grep-find-command "/bin/find.exe . -type f \| /bin/xargs.exe /bin/grep.exe -nH -e \"\"")

;; for linux
;(setq grep-program "grep.exe")
(setq grep-command "grep -nrH -e \"\" .")
;(setq find-program "find.exe")
(setq grep-find-command "find . -type f \| xargs grep -nH -e \"\"")

;;
(setq develock-auto-enable nil)
;(require 'develock)

(defun ma:toggle-develock-auto ()
  (interactive)
  (setq develock-auto-enable (not develock-auto-enable))
  (if (and develock-auto-enable
		   (not (featurep 'develock)))
	  (require 'develock))
  (message "develock-auto-enable is %s" (or (and develock-auto-enable "ON") "OFF") ))
(define-key my-key-map "v" 'ma:toggle-develock-auto)

;;
(icomplete-mode 1)

;; @ eshell
;; 「.*」の挙動正しく
(setq eshell-glob-include-dot-dot nil)

(setq eshell-command-aliases-list
	  '(("ls" "ls -aF --color") ("ls1" "ls -1") ("lsl" "ls -al") ("cd." "cd ..")
		("bsh" "c:/home/masuda/java/bsh.bat")
		("rhino" "c:/home/masuda/js/rhino1_6R6/rhino.bat")))

(autoload 'eshell-toggle "esh-toggle"
  "Toggles between the *eshell* buffer and whatever buffer you are editing." t)
(autoload 'eshell-toggle-cd "esh-toggle"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
(global-set-key "\C-ct" 'eshell-toggle)
(global-set-key "\C-cd" 'eshell-toggle-cd)

;; @time-stamp
(require 'time-stamp)
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)
;(setq time-stamp-start "last updated : ")
;(setq time-stamp-format "%04y/%02m/%02d")
;(setq time-stamp-end " \\|$")

;; 07.11.13(tue)-18:52
;;; for isearch add-on
; 単語をC-wで追加した後，C-fとすると一文字ずつ追加
(defun isearch-yank-char ()
  "Pull next character from buffer into search string."
  (interactive)
  (isearch-yank-string
   (save-excursion
     (and (not isearch-forward) isearch-other-end
          (goto-char isearch-other-end)))))
; isearch 中にC-oで occur を起動
(defun isearch-occur ()
  "Invoke `occur' from within isearch."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur
     (if isearch-regexp
         isearch-string (regexp-quote isearch-string)))))
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;; etags
;(visit-tags-table "~/TAGS")
;(visit-tags-table "~/TAGS_FZK")

;;; @ cyclic buffer change
;;; 99.03.03(Wed)-12:02:32
;; 08.01.07(mon)-15:48 再登録、ヒストリバック的に使用する様に
(defun get-fl-buffer (&optional arg)
  (let
	  (name (get-buf nil)
			(blist (buffer-list)))
	(if arg (setq blist (reverse blist)))
	(catch 'loop
	  (while blist
		(setq name (buffer-name (car blist)))
		(if (not
			 ;; 移動しないバッファのデータ
			 (string-match "^ \\|^\\*ftp\\|^\\*Messages\\*\\|-Log\\*$\\|^TAGS$" name)) ;; change 2008.01
			(progn
			  (setq get-buf name)
			  (throw 'loop t)))
		(setq blist (cdr blist))))
	  get-buf))

(defun switch-to-last-buffer-cyclic()
  "Popup last buffer from buffer list, and show it"
  (interactive)
  (switch-to-buffer (get-fl-buffer 1)))
;(global-set-key [C-down] 'switch-to-last-buffer-cyclic)
(global-set-key [C-right] 'switch-to-last-buffer-cyclic)
;(global-set-key "\e\C-b" 'switch-to-last-buffer-cyclic)

(defun switch-to-next-buffer-cyclic()
  "Bury current buffer at bottom of list, and show next one."
  (interactive)
  (bury-buffer (buffer-name))
  (switch-to-buffer (get-fl-buffer)))
;;(global-set-key [C-up] 'switch-to-next-buffer-cyclic)
(global-set-key [C-left] 'switch-to-next-buffer-cyclic)
;(global-set-key "\e\C-f" 'switch-to-next-buffer-cyclic)

;; 08.01.09(wed)-14:22
;; 行折り返しの表示
(set-face-foreground 'fringe "gray28")
(set-face-background 'fringe "gray8")
;; 行折返しでのfringe表示は右側だけにする
;(if (fboundp 'fringe-mode) (fringe-mode '(nil . nil)))
;; 存在行の表示
(setq default-indicate-buffer-boundaries 'left)
;; 最終行以下を表示
;(setq indicate-empty-lines t)

;;10.04.20(tue)-12:10
(set-face-foreground 'font-lock-comment-face "red")

;; 08.01.16(wed)-10:23
;; 次のウィンドウと入れ替え - つくりかけ
(defun ma:exchange-2-windows ()
  (interactive)
  (save-excursion
	(setq buf1 (buffer-name)) ;current buf-win
	(other-window 1)
	(setq buf2 (buffer-name)) ;other buf-win
	(switch-to-buffer buf1)
	(other-window -1)
	(switch-to-buffer buf2)
	(other-window 1)))
(define-key my-key-map "0" 'ma:exchange-2-windows)

;; 08.01.21(mon)-12:16
;; 改行の種類表示をかえる
(setq eol-mnemonic-unix  "(LF)")
(setq eol-mnemonic-dos  "(CRLF)")
(setq eol-mnemonic-mac  "(CR)")

;; 08.01.21(mon)-13:24
;(require 'install-elisp)

;; 08.01.21(mon)-16:03
;; 日付をカレンダーより入力
(eval-after-load "calendar"
  '(progn
     (define-key calendar-mode-map "\C-m" 'ma:cal-insert-day)
     (defun ma:cal-insert-day ()
       (interactive)
       (let ((day nil)
             (calendar-date-display-form
			  '((format "[%4s-%02d-%02d]" year
						(string-to-int month) (string-to-int day)))))
		 (setq day (calendar-date-string
					(calendar-cursor-to-date t)))
		 (exit-calendar)
		 (insert day)))))

;; means Sunday (default), 1 means Monday, and so on.
(setq calendar-week-start-day 1)

;; 08.01.21(mon)-17:42
;; 'calc' is simply calc
(defalias 'calc 'calculator)

;; 08.01.21(mon)-18:57
(defun ma:toggle-v-h-windows ()
  "change split windows set"
  (interactive)
  (let* ((wintree (window-tree))
		 (winlst (nthcdr 2 (car wintree)))
		 (h-or-v (car (car wintree)))
		 (buflst ()) bufcnt (lcnt 1) (eflg t))
	(mapcar (lambda (w)
			  (if (not (eq (type-of w) 'window)) (setq eflg nil)))
			winlst)
	(if eflg
		(progn
		  ;; get buffer list
		  (mapcar (lambda (w)
					(push (window-buffer w) buflst))
				  winlst)
		  (setq buflst (reverse buflst))
		  ;;
		  (setq bufcnt (length buflst))
		  (if (>  bufcnt 1)
			  (progn
				(delete-other-windows)
				(if h-or-v
					(while (> bufcnt lcnt)
					  (split-window-horizontally) ;h
					  (setq lcnt (1+ lcnt)))
				  (while (> bufcnt lcnt)
					(split-window-vertically) ;v
					(setq lcnt (1+ lcnt))))
				;;
				(mapcar (lambda (b)
						  (switch-to-buffer b)
						  (other-window 1))
						buflst)
				;;
				(balance-windows)
				))
		  )
	  (message "cannot change window."))))
(define-key my-key-map "9" 'ma:toggle-v-h-windows)

;; 08.01.24(thu)-09:53
;;(require 'text-translator-load)
;;(define-key my-key-map "h" 'text-translator)
;;(define-key my-key-map "H" 'text-translator-translate-last-string)
;;(setq text-translator-default-engine "excite.co.jp_enja")
;;
;; 08.01.24(thu)-19:25
(put 'upcase-region 'disabled nil)

;; 08.01.25(fri)-10:39
;; @ copy. one line scroll
(defun scroll-up-one-line ()
  (interactive)
  (scroll-up 1))
(global-set-key [?\C-,] 'scroll-up-one-line)
(defun scroll-down-one-line ()
  (interactive)
  (scroll-down 1))
(global-set-key [?\C-.] 'scroll-down-one-line)

;; 08.02.27(wed)-11:01
;; yank 時に次の yank 候補を minibuffer に表示
(defun my-yank-display ()
  (unless (or (eq kill-ring-yank-pointer nil)
              ;; kill-ringが空だったり
              (= (aref (buffer-name) 0) ? ))
              ;; minibuf で yank しようとしていなければ
    (if (eq (cdr kill-ring-yank-pointer) nil)
        (message "end of kill-ring")
      (message (car (cdr kill-ring-yank-pointer))))))

(defun my-yank (arg)
  "Yank with displaying next"
  (interactive "*P")
  (yank arg)
  (my-yank-display)
  (setq this-command 'yank))

(defun my-yank-pop (arg)
  "Yank-pop with displaying next"
  (interactive "*p")
  (yank-pop arg)
  (my-yank-display)
  (setq this-command 'yank))

(global-set-key "\C-y" 'my-yank)
(global-set-key "\M-y" 'my-yank-pop)

;; 08.04.09(wed)-16:54
(defun ma:sjis-coding-system ()
  (interactive)
  (set-terminal-coding-system 'sjis)
  (set-keyboard-coding-system 'sjis)
  (set-buffer-file-coding-system 'sjis)
  (setq default-buffer-file-coding-system 'sjis)
  (prefer-coding-system 'sjis)
  (set-default-coding-systems 'sjis)
  (setq file-name-coding-system 'sjis))

;; @ ttm-menu key
;; 08.04.21(mon)-16:03
(global-set-key "\M-@" 'tmm-menubar)

;; @ org-mode
;; 08.04.22(tue)-14:04
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(add-hook 'org-mode
		  '(lambda ()
			 (local-unset-key (kbd "C-<tab>"))))

;; 08.06.23(mon)-12:34
;;(setq tramp-shell-prompt-pattern "^.*[#$%>] *")

;;
(define-key my-key-map "y" 'browse-kill-ring)

;; 08.12.11(thu)-17:51
;; auto-complete
;(require 'auto-complete)
;(global-auto-complete-mode t)

;; 新しくbufferを作らない
(require 'dired)
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map "a" 'dired-advertised-find-file)

;; TRAMP load
(require 'tramp)
(setq tramp-default-method "ssh")

;; color
(set-face-foreground 'default "white")
;(set-face-background 'default "black")
(set-face-bold-p 'modeline nil)
(set-face-foreground 'modeline "cyan")
(set-face-background 'modeline "white")
;(set-face-underline-p 'modeline "green")
(set-face-foreground 'modeline-inactive "blue")
(set-face-background 'modeline-inactive "black")


;; Add pahts to SKK and APEL
(require 'skk-autoloads)
;;;; @@ SKK add 060313
;;(autoload 'skk-mode "skk" nil t)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(define-key my-key-map "u" 'skk-undo-kakutei)

(setq skk-large-jisyo "~/elisp/SKK-JISYO.L")

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
					    '(("!" nil "!")
						  (":" nil ":")
						  (";" nil ";")
						  ("?" nil "?"))))))

;;;;注釈を表示
(setq skk-hiragana-cursor-color "red") ;; かなモードのカーソル色 (skk-10)
(setq skk-latin-cursor-color "blue") ;; ACSII (skk-10)
;(setq skk-cursor-hiragana-color "red") ;; skk-13
;(setq skk-cursor-latin-color "DodgerBlue") ;; skk-13

;;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ miss point 10.07.26(mon)

;; @ 07.10.30(tue)-15:34 ver 13.1
;;候補が近くに出る
;(setq skk-show-inline t)
;;確定Undo カーソルの位置がちゃんとする
;(setq skk-undo-kakutei-return-previous-point t)

;; perl
(defalias 'perl-mode 'cperl-mode)

;(add-hook 'cperl-mode-hook
;          (lambda ()
;            (require 'perl-debug)
;            (perl-debug-set-coding-system)
;            (define-key perl-mode-map "\C-cc" 'perl-debug-lint)
;            (define-key cperl-mode-map "\C-cd" 'perl-debug)))

(load-file "~/elisp/perl-setup.el")

;(eval-after-load "flymake"
;  '(progn
;	  (set-face-foreground 'flymake-errline "purple") ))

;; auto-install
(require 'auto-install)
(setq auto-install-directory (expand-file-name "~/elisp/"))
;;(add-to-list 'load-path auto-install-directory)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; 07.09.26(wed)-20:01
;; anything
(if (not (boundp 'image-load-path))
	(require 'image)) ;; なぜかロードされないようでエラーになる image-load-path がない
(require 'anything-config)
(require 'recentf)
(require 'anything-etags)
(require 'anything-grep)
(recentf-mode 1)
(global-set-key "\C-x\C-a" 'anything)
;(global-set-key [?\C-;] 'anything) ;'
(global-set-key [?\C-_] 'anything) ; キーは「C-/」
(global-set-key [f12] 'anything)
(define-key anything-map "\en" 'anything-next-source)
(define-key anything-map "\ep" 'anything-previous-source)
 
;; http://dev.ariel-networks.com/Members/matsuyama/open-anything-emacs
(defadvice anything-check-minibuffer-input (around sit-for activate)
  (if (sit-for anything-idle-delay t)
	  ad-do-it))

;; 10.10.12(tue)-18:44
(require 'recentf-ext)

;; anything Occur 
(defvar anything-c-source-occur
  '((name . "Occur")
    (init . (lambda ()
              (setq anything-c-source-occur-current-buffer
                    (current-buffer))))
    (candidates . (lambda ()
                    (setq anything-occur-buf (get-buffer-create "*Anything Occur*"))
                    (with-current-buffer anything-occur-buf
                      (erase-buffer)
                      (let ((count (occur-engine anything-pattern
                                                 (list anything-c-source-occur-current-buffer) anything-occur-buf
                                                 list-matching-lines-default-context-lines nil
                                                 list-matching-lines-buffer-name-face
                                                 nil list-matching-lines-face
                                                 (not (eq occur-excluded-properties t)))))
                        (when (> count 0)
                          (let ((lines (split-string (buffer-string) "\n" t)))
                            (cdr lines)))))))
    (action . (("Goto line" . (lambda (candidate)
                                (goto-line (string-to-number candidate) anything-c-source-occur-current-buffer)))))
    (requires-pattern . 3)
    (volatile)))


;; Register
(defvar anything-c-source-register
  '((name . "Registers")
    (candidates . anything-c-registers)
    (action ("insert" . insert))))
;; based on list-register.el
(defun anything-c-registers ()
  (loop for (char . val) in register-alist
        collect
        (let ((key (single-key-description char))
              (string (cond
                       ((numberp val)
                        (int-to-string val))
                       ((markerp val)
						(let ((buf (marker-buffer val)))
						  (if (null buf)
							  "a marker in no buffer"
							(concat
							 "a buffer position:"
							 (buffer-name buf)
							 ", position "
							 (int-to-string (marker-position val))))))
					   ((and (consp val) (window-configuration-p (car val)))
						"conf:a window configuration.")
					   ((and (consp val) (frame-configuration-p (car val)))
						"conf:a frame configuration.")
					   ((and (consp val) (eq (car val) 'file))
						(concat "file:"
								(prin1-to-string (cdr val))
								"."))
					   ((and (consp val) (eq (car val) 'file-query))
						(concat "file:a file-query reference: file "
								(car (cdr val))
								", position "
								(int-to-string (car (cdr (cdr val))))
								"."))
					   ((consp val)
						(let ((lines (format "%4d" (length val))))
						  (format "%s: %s\n" lines
								  (truncate-string
								   (mapconcat (lambda (y) y) val
											  "^J") (- (window-width) 15)))))
					   ((stringp val)
						val)
					   (t
						"GARBAGE!"))))
          (cons (format "register %3s: %s" key string) string))))

(defvar anything-c-source-semantic
  '((name . "Semantic Tags")
    (init . (lambda ()
              (setq anything-c-source-semantic-candidates
                    (anything-c-source-semantic-construct-candidates (semantic-fetch-tags) 0))))
    (candidates . (lambda ()
                    (mapcar 'car anything-c-source-semantic-candidates)))
    (action . (("Goto tag" . (lambda (candidate)
                               (let ((tag (cdr (assoc candidate anything-c-source-semantic-candidates))))
                                 (semantic-go-to-tag tag))))))))

;; anything sources set
(setq anything-sources
      (list
	   anything-c-source-buffers+
	   anything-c-source-recentf
	   anything-c-source-file-name-history
	   anything-c-source-emacs-commands
	   anything-c-source-occur
	   ;;anything-c-source-register
	   ;;anything-c-source-bookmarks
	   ;;anything-c-source-google-suggest
	   ;;anything-c-source-file-cache
	   ;;anything-c-source-man-pages
	   anything-c-source-info-pages
	   ;;anything-c-source-calculation-result
	   anything-c-source-locate
	   ;;anything-c-source-semantic
	   anything-c-source-posren-db
	   anything-c-source-sql
	   anything-c-source-kill-ring
	   anything-c-source-etags-select
	   ))

(eval-after-load "anything"
  (progn
    (set-face-foreground 'anything-header "white")
	(set-face-background 'anything-header "blue")
	(set-face-foreground 'anything-isearch-match "white")
	(set-face-background 'anything-isearch-match "IndianRed")
	(set-face-foreground 'anything-dir-heading "blue")
	(set-face-background 'anything-dir-heading nil)
	(set-face-foreground 'anything-dir-priv "blue")
	(set-face-background 'anything-dir-priv nil) 
	(set-face-background 'anything-visible-mark "yellow") 
	(set-face-underline-p 'anything-visible-mark t) 
))

;; END anything setup

;; window resize
(defun ma:resize-win-interactively ()
  (interactive)
  (let (key)
	(catch 'quit
	  (message "p:cls-1, n:cls+1, <:row-1, >:row+1 ")
	  (while t
		(setq key (read-char))
		(cond
		 ((= key ?n) (enlarge-window 1))
		 ((= key ?p) (enlarge-window -1))
		 ((= key ?>) (enlarge-window 1 t))
		 ((= key ?<) (enlarge-window -1 t))
		 (t (throw 'quit t)))
		))
	(message "Resize END.")))

(define-key my-key-map "r" 'ma:resize-win-interactively)

;; speedbar
(eval-after-load "speedbar"
  '(progn
	 (define-key speedbar-key-map "u" 'speedbar-up-directory)
	 (define-key speedbar-key-map "s" 'speedbar-toggle-show-all-files)
	 (setcdr (assoc 'width speedbar-frame-parameters) 20)
	 ))
;(define-key my-key-map "b" 'speedbar)
;(define-key my-key-map "\C-b" 'speedbar)

;; 10.10.05(tue)-17:05
(require 'sr-speedbar)
(define-key my-key-map "b" 'sr-speedbar-toggle)
(setq speedbar-show-unknown-files t)

(add-hook 'speedbar-mode-hook
          '(lambda ()
             (speedbar-add-supported-extension 
			  '("js" "as" "html" "css" "php" "sql" "csv" "tsv" "cgi" "bak" "txt" "tar" "gz" "tar.gz"))))

;; 縦分割線
(set-face-foreground 'vertical-border "blue")
(set-face-background 'vertical-border "black")

;; スクロール量調整
(setq scroll-small-size 10)

(defun scroll-up-small ()
 "Small scroll up just " scroll-small-size " lines like other editors."
 (interactive)
 (scroll-up scroll-small-size)
 (forward-line scroll-small-size))
(defun scroll-down-small ()
 "Small scroll down just " scroll-small-size " lines like other editors."
 (interactive)
 (scroll-down scroll-small-size)
 (forward-line (- scroll-small-size))) ;; `next-line' is not recommended.
;; Override
(global-set-key "\C-v" 'scroll-up-small)
(global-set-key "\M-v" 'scroll-down-small)

;; 10.10.21(thu)-10:49
(when (locate-library "descbinds-anything")
  (require 'descbinds-anything)
  (descbinds-anything-install))

;; 同時押し
;; 10.10.26(tue)-14:55
(when (and (locate-library "key-chord") (locate-library "space-chord"))
  (require 'key-chord nil 'noerror)
  (eval-after-load "key-chord"
	'(progn (key-chord-mode 1)))
  ;; SPC-SPC を独自キーに
  (require 'space-chord nil 'noerror)
  (eval-after-load "space-chord"
	'(progn (setq space-chord-delay 0.1)
			(space-chord-define-global " " my-key-map)
			;; command-map-prefix my-key "/"
			(if (boundp 'anything-command-map-prefix-key)
				(space-chord-define-global "/" anything-command-map)) )))

;; バッファ名重複対策
(when (locate-library "uniquify")
  (require 'uniquify)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; カーソルライン
(global-hl-line-mode t)
(set-face-foreground 'hl-line "white")
(set-face-background 'hl-line "black")
(set-face-underline-p 'hl-line t)

;; 10.10.28(thu)-14:21
;; 同じコマンドを連続実行することで挙動を変える（行頭→先頭など）
(when (locate-library "sequential-command-config")
  (require 'sequential-command-config)
  (global-set-key "\C-a" 'seq-home)
  (global-set-key "\C-e" 'seq-end))
(when (require 'org nil t)
  (define-key org-mode-map "\C-a" 'org-seq-home)
  (define-key org-mode-map "\C-e" 'org-seq-end))
(define-key esc-map "u" 'seq-upcase-backward-word)
(define-key esc-map "c" 'seq-capitalize-backward-word)
(define-key esc-map "l" 'seq-downcase-backward-word)


;; elc check ; 読み込み速度が遅いはずはない
;(setq my-init-el "~/.emacs23.unix.el")
;(if	(file-newer-than-file-p my-init-el (concat my-init-el "c"))
;	(warn (concat my-init-el "c is OLD!!!!!")))
;; EOF
