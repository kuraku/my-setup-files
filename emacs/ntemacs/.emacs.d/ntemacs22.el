;; dot.emacs for NTEmacs  -*- emacs-lisp -*-
;; change 2006.12.28 MAS
;; updated 2007.09.20 MAS
;; updated 2010.06.08 in posren
;; Time-stamp: <2010-06-10 15:57:00 masuda>

;; Tips
;; ファイルを指定コードで開き直す: C-x RET c 文字コードを入力 RET C-x C-v RET
;; 重複する関数を取得: M-x list-load-path-shadows

;; @ emacs version
(defconst ma:emacs-ver
	  (concat (int-to-string emacs-major-version)
			  "." (int-to-string emacs-minor-version)))
(defconst my-emacs22-p (= emacs-major-version 22)
  "Non-nil if running Emacs 22.")
(defconst my-emacs22-0-p
  (and (= emacs-major-version 22) (= emacs-minor-version 0))
  "Non-nil if running Emacs 22.0")
(defconst my-emacs23-p (= emacs-major-version 23)
  "Non-nil if running Emacs 23.")

;; @ emacs client Set
;; 08.04.23(wed)-14:57
;(server-start)

;;; @ coding-system
;; 
;(cond (my-emacs22-p
;	   (require 'un-define)))
;(set-language-environment "Japanese")

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)

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
(global-set-key (kbd "C-<tab>") my-key-map)
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

;;; @ other frame.
;;; 08.01.30(wed)-16:40
(define-key my-key-map "f" 'other-frame)
(global-set-key "\C-x\en" 'other-frame)

(defun other-frame-backward (&optional n)
  "select nth previous frame."
  (interactive "p")
  (other-frame (- (prefix-numeric-value n))))
(global-set-key "\C-x\ep" 'other-frame-backward)

;;
;(global-set-key "\e*" 'query-replace-regexp)

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

;; @ SKK
;; 08.04.21(mon)-17:57
(require 'skk-setup)

;;;; @@ SKK add 060313
;;(autoload 'skk-mode "skk" nil t)
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
(define-key my-key-map "u" 'skk-undo-kakutei)

(setq skk-large-jisyo "c:/emacs/22.2/etc/skk/SKK-JISYO.L")
;;;(setq skk-large-jisyo "C:/Application/IME/SKK-JISYO/SKK-JISYO.L.unannotated")
;;;(setq skk-large-jisyo "~/emacs/22.0.50/archives/SKK-JISYO.L.unannotated")

;;;; check skk-jisyo
;;(ma:check-file skk-large-jisyo)

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
;;(setq skk-show-annotation t)

;(setq skk-hiragana-cursor-color "red") ;; かなモードのカーソル色 (skk-10)
;(setq skk-latin-cursor-color "blue") ;; ACSII (skk-10)
(setq skk-cursor-hiragana-color "red") ;; skk-13
(setq skk-cursor-latin-color "DodgerBlue") ;; skk-13

;; @ 07.10.30(tue)-15:34 ver 13.1
;;候補が近くに出る
(setq skk-show-inline t)
;;確定Undo カーソルの位置がちゃんとする
(setq skk-undo-kakutei-return-previous-point t)

; elscreen
(load "elscreen" "ElScreen" t)
(elscreen-set-prefix-key "\C-t")
(setq elscreen-display-tab t) ;; tab 表示
(setq elscreen-tab-display-create-screen nil) ;;[!] create ボタン非表示
(setq elscreen-tab-display-control nil) ;;[<->] control ボタン非表示
(setq elscreen-tab-display-kill-screen nil) ;;[X] ボタン非表示
;(setq elscreen-tab-width 10) ;; tabサイズ newVer では廃止
(define-key elscreen-map  "d" 'elscreen-kill)
(define-key elscreen-map  "\C-d" 'elscreen-kill)
(define-key elscreen-map  "o" 'elscreen-toggle)
(define-key elscreen-map  "\C-o" 'elscreen-toggle)
(define-key elscreen-map  "l" 'elscreen-select-and-goto)
(define-key elscreen-map  "\C-l" 'elscreen-select-and-goto)
;; tab color
;(set-face-background 'elscreen-tab-other-screen-face "Gray75")
;(set-face-foreground 'elscreen-tab-other-screen-face "Gray20")
(set-face-background 'elscreen-tab-other-screen-face "Gray30")
(set-face-foreground 'elscreen-tab-other-screen-face "Gray85")
(set-face-background 'elscreen-tab-current-screen-face "Gray70")


;; @@ set register
(set-register ?m '(file . "~/.ntemacs22"))
(set-register ?s '(file . "c:/emacs/site-lisp"))
(set-register ?d '(file . "c:/Documents and Settings/masuda/デスクトップ"))
(set-register ?p '(file . "z:/memo.txt"))
(set-register ?e '(file . "z:/Desktop/Eclipse/workspace"))

;;
;;(tool-bar-mode nil)

;;
(set-scroll-bar-mode nil)

;; @ 圧縮ファイルも読める
(require 'jka-compr)

;; dired でディレクトリを先頭に表示
(setq ls-lisp-dirs-first t)

;; ミニバッファの大きさを変える(ない)
(setq resize-mini-windows t)
(cond
 (my-emacs22-0-p ;;(equal ma:emacs-ver "22.0")
  (resize-minibuffer-mode 1)))

;; 他のウィンドウにはカーソルを表示しない
(setq cursor-in-non-selected-windows nil)

;;
;(show-paren-mode t)

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

;; @ 03.09.03(Wed)-20:28
;; do Byte-comple when the file save.
;(setq ma:byte-comple-list '("~/.emacs.el" "~/.emacs" "~/elisp/howm-conf.el"))
(setq ma:byte-comple-list '("~/.ntemacs22"))
(add-hook 'after-save-hook
          (lambda ()
            (mapcar
             (lambda (file)
               (setq file (expand-file-name file))
               (when (string= file (buffer-file-name))
                 (save-excursion (byte-compile-file file))))
			 ma:byte-comple-list)))

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

;; color
(set-face-foreground 'default "seashell2")
;;(set-face-foreground 'default "white")
(set-face-background 'default "black")
;(set-face-background 'default "DarkSlateGrey")
(set-face-background 'cursor "LimeGreen")
;(set-face-background 'cursor "pink")
(set-face-foreground 'modeline "white")
(set-face-background 'modeline "aquamarine4")
;(set-face-background 'modeline "darkslategrey")
(set-face-foreground 'modeline-inactive "white")
(set-face-background 'modeline-inactive "DarkSeaGreen4")
;
;; モードライン(アクティブでないバッファ)の文字色。
;;(set-face-foreground 'mode-line-inactive "white")
;; モードライン(アクティブでないバッファ)の背景色。
;(set-face-background 'mode-line-inactive "grey50")
(set-face-bold-p 'modeline nil)
(set-face-underline-p 'modeline "DarkOliveGreen")
;(set-face-underline 'mode-line-inactive "gray60") ;;old
(set-face-background 'mode-line-inactive "gray60")

;;
(setq w32-use-w32-font-dialog nil)

;; default window place

(setq default-frame-alist
	  (append (list
			   '(width . 100)
			   '(height . 66)
			   '(top . 10)
			   '(left . -30))
			  default-frame-alist))

;(setcdr (assoc 'height default-frame-alist) 66) ;; ignore??
;(set-frame-height (selected-frame) 56)
(setq initial-frame-alist default-frame-alist)

;(require 'color-occur)

;; buffer list
(require 'ibuffer)
(setq ibuffer-default-sorting-mode "recency")
(setq ibuffer-formats
      '((mark modified read-only " " (name 30 30)
              " " (size 6 -1) " " (mode 16 16) " " filename)
        (mark " " (name 30 -1) " " filename)))

(cond
 (my-emacs22-0-p ;; emacs-ver "22.0"
  ;; 透明 アクティブアルファ
  (set-active-alpha 0.8)
  ;; 非アクティブアルファ
  (set-inactive-alpha 0.8))
 (t
  (set-alpha 85)))
;;
(defun ma:set-alpha (&optional alpha)
  (interactive "P")
  (let
	  ((al (if alpha alpha 8)))
	(set-active-alpha (/ al 10.0))
	(set-inactive-alpha (/ al 10.0))))

(defun ma:change-alpha-22.0 ()
  (interactive)
  (if (fboundp 'set-active-alpha)
	  (progn
		(let ((tr 8) c)
		  (set-active-alpha (/ tr 10.0))
		  (catch 'endFlg
			(while t
			  (message "change alpha set. p:up n:down alpha:0.%s:0.%s" tr (- tr 1))
			  (setq c (read-char))
			  (cond ((= c ?p)
					 (setq tr (or (and (> (+ tr 1) 10) 10) (+ tr 1)))
					 (set-active-alpha (/ tr 10.0))
					 (set-inactive-alpha (/ (- tr 1) 10.0)))
					((= c ?n)
					 (setq tr (or (and (<= (- tr 1) 0) 1) (- tr 1)))
					 (set-active-alpha (/ tr 10.0))
					 (set-inactive-alpha (/ (- tr 1) 10.0)))
					((and (/= c ?p) (/= c ?n))
					 (message "quit alpha:0.%s:0.%s" tr (- tr 1))
					 (throw 'endFlg t)))))))
	(message "Can't exec set-active-alpha")))

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
(define-key my-key-map "a" 'ma:change-alpha)

;;; @ ruby-mode
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files")
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist
      (append '(("^#!.*ruby" . ruby-mode)) interpreter-mode-alist))

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (inf-ruby-keys)))
(setq ruby-indent-level 3)

; ;; @ w3m
; (require 'w3m-load)
; 
; ;;
; ;(autoload 'newsticker-start "newsticker" "Start Newsticker" t)
; ;(autoload 'newsticker-show-news "newsticker" "Goto Newsticker buffer" t)
; ;(add-hook 'newsticker-mode-hook 'imenu-add-menubar-index)
; (setq newsticker-url-list
;       '(;;("はてなブックマーク - 注目エントリー一覧" "http://b.hatena.ne.jp/entrylist?mode=rss&amp;sort=hot")
; 		;;("はてなブックマーク 最近の人気エントリー" "http://b.hatena.ne.jp/hotentry?mode=rss")
; 		("エルエル" "http://10e.org/index.rdf")
; 		("TBN" "http://tbn2.blog50.fc2.com/?xml")
;         ))
; 
; (autoload 'w3m-region "w3m"
;   "Render region in current buffer and replace with result." t)
; (setq newsticker-html-renderer 'w3m-region)
; (setq w3m-use-cookies t)
; 
; (setq w3m-fill-column 80)
; 
; (require 'mime-w3m)

;;;
;(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

;;; @@ ange ftp
;(setq ange-ftp-ftp-program-name "C:/masuda/emacs/22.0.50/bin/ftp.exe")
;; check file
;(ma:check-file ange-ftp-ftp-program-name)

;; 08.02.07(thu)-13:50
(setq user-full-name "MASUDA Akira"
	  user-full-name-ja "増田 明"
	  user-mail-address "masuda@posren.com")
;;	  user-mail-address "masuda@kuraku.net")

;; **** keisen-mule.el ****
(unless (fboundp 'sref) (defalias 'sref 'aref))
(if window-system
	(autoload 'keisen-mode "keisen-mouse" "MULE版罫線モード＋マウス" t))
(autoload 'keisen-mode "keisen-mule" "MULE版罫線モード" t)

;; wdired 061226
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; @ 以降 2007.09.20 からの変更とか、過去の elip からの移行
(add-to-list 'auto-mode-alist '("\\.js\\'" . ecmascript-mode))
(autoload 'ecmascript-mode "ecmascript-mode" "ECMAScript" t)
;; javascript-mode
(autoload 'javascript-mode "javascript" "JavaScript" t)

; JDEE
;; (require 'jde)
;; (autoload 'jde-mode "jde" "Java Development Environment for Emacs." t)
;; (setq auto-mode-alist (cons '("\.java$" . jde-mode) auto-mode-alist))
; CEDET
;; (setq semantic-load-turn-useful-things-on t)
;; (load "cedet")

(autoload 'bsh-run "beanshell" "Bean Shell" t)
(setq bsh-jar "C:/home/masuda/java/bsh-2.0b4.jar")
(setq bsh-startup-directory "~/java")
(setq bsh-classpath '("C:/fzk/fzk2/FZK-Java/classes"))

;; @ CD home
(cd "~")

;; moccur
;; apel の add-local-hook が無くなって動かない、
; (autoload 'moccur "color-moccur" nil t)
; (autoload 'moccur-grep "color-moccur" nil t)
; (autoload 'moccur-grep-find "color-moccur" nil t)
; (load "moccur-edit")

;; 折り返し toggle
(defalias 'tt 'toggle-truncate-lines)

;; DB2
;; db2=> connect to DBFZZ2S USER fzzzs USING fzk
;; * sql-mode で使える機能 (予めDBに接続)
;; C-c C-c: sql-send-paragraph [;] が区切り、空行は含めない
;; C-c C-r: sql-send-region
;; C-c C-b: sql-send-buffer [;]を入れればそのまま実行
;(setq sql-database "DBFZZ2S")
;(setq sql-user "fzzzs")
;(setq sql-password "fzk")
;(setq sql-server "larsclone:60620")
(setq sql-db2-program "C:/PROGRA~1/IBM/SQLLIB/BIN/db2cmd.exe")
(setq sql-db2-options '("-c" "-i" "-w" "db2" "-tv"))
(put 'narrow-to-region 'disabled nil)
;;
(defadvice sql-db2
  (around before-tt activate)
  ad-do-it
  ;; (rename-buffer "*DB2 SQL*")
  (toggle-truncate-lines)
  (sit-for 2)
  (db2-conn))
  ;;(insert "connect to DBLZZ1T USER fz0tb USING fz0tb;"))

;; DBname/user/passwd
(setq ma:db2-usrpw
	  '(("DBLZZ1T" "fz0tb" "fz0tb")
		("DBFZZ2S" "fzzzs" "fzk")))

(defun db2-conn ()
  (interactive)
  (let (db user passwd
		   (db-alist ()))
	(mapcar (lambda (acc)
			  (setq db-alist (append db-alist (list (nth 0 acc)))))
			ma:db2-usrpw)
	(setq db-name
		  (completing-read "DB NAME: " db-alist nil t (nth 0 db-alist)))
	(mapcar (lambda (dbac)
			  (if (equal db-name (nth 0 dbac))
				  (progn
					(setq user (nth 1 dbac))
					(setq passwd (nth 2 dbac)))))
			ma:db2-usrpw)
	(insert (format "connect to %s USER %s USING %s;"
					db-name user passwd))))

;; mysql 
(defun sql-send-string (string)
  "Send a string to the SQL process."
  (interactive "sSQL:")
  (if (buffer-live-p sql-buffer)
      (save-excursion
		(comint-send-string sql-buffer string)
		(if (string-match "\n$" string)
			()
		  (comint-send-string sql-buffer "\n"))
		(message "Send string to buffer %s" (buffer-name sql-buffer))
		(if sql-pop-to-buffer-after-send-region
			(pop-to-buffer sql-buffer)
		  (display-buffer sql-buffer)))
    (message "No SQL process started.")))

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

(add-hook 'sql-interactive-mode-hook
		  '(lambda ()
			 (if (sql-in-mysql)
				 (sql-mysql-set-charset "sjis"))))
;; mysql end

;; 括弧の対応ハイライト
;(show-paren-mode 1)

; key set
;(global-set-key "\e=" 'what-line)
(global-set-key "\es" 'enlarge-window)

;; new buffer
(defun generate-buffer (buffer-name)
  "新しいバッファを名前をつけて、作る"
  (interactive "sNew Buffer name: ")
  (generate-new-buffer (concat "*" buffer-name "*"))
  (switch-to-buffer (concat "*" buffer-name "*")))
;使っていない switch-buffer で作ってしまう
;(define-key my-key-map "g" 'generate-buffer)

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

;;; @ ナンバリング
;; 99.03.02(Tue)-10:36:55
(defun ma:number-region (&optional start-num)
  "リージョンにナンバーをふる。
引き数をつけると、その番号からスタート"
  (interactive "P")
  (save-excursion
	  (let
		  ((num (if start-num start-num 1))
		   (e (max (region-end) (region-beginning)))
		   (b (min (region-end) (region-beginning))))
	    (goto-char b)
	    (while (<= (+ (point) 1) e)
		  (beginning-of-line)
		  (insert (format "%3d: " num))
		  (setq e (+ e 5))
		  (setq num (+ num 1))
		  (forward-line 1)))))

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

;; 今日変更したファイルに色をつける 03.02.11(Tue)-00:41
(defface face-file-edited-today '((t (:foreground "GreenYellow"))) nil)
(defvar face-file-edited-today 'face-file-edited-today)
(defun my-dired-today-search (arg)
  "Fontlock search function for dired."
  (search-forward-regexp
   ;; "02-13 15:02" に対応
   (concat (format-time-string "%m-%d" (current-time)) " [0-9]....") arg t))
;;   (concat (format-time-string "%m-%d" (current-time)) " [0-9]....") nil nil nil))
   ;;(concat (format-time-string "%b %e" (current-time)) " [0-9]....") arg t))

(add-hook 'dired-mode-hook
          '(lambda ()
             (font-lock-add-keywords
              major-mode
              (list
               '(my-dired-today-search . face-file-edited-today)
               ))))

;; window タイトル
;(setq frame-title-format `("%b" (buffer-file-name "  (%f)")))
;(setq frame-title-format (format "emacs@%s : %%f" (system-name)))
(setq frame-title-format "Emacs: %b")

;; history から重複したのを消す (M-x M-p とかの) 03.02.19(Wed)-10:59
(require 'cl)
(defun minibuffer-delete-duplicate ()
  (let (list)
    (dolist (elt (symbol-value minibuffer-history-variable))
      (unless (member elt list)
        (push elt list)))
    (set minibuffer-history-variable (nreverse list))))
(add-hook 'minibuffer-setup-hook 'minibuffer-delete-duplicate)

;; C-p:上に移動 C-n:下に移動 C-f:右に移動 C-b:左に移動
;; p:サイズ縮小 n:サイズ拡大 f:サイズ拡大 b:サイズ縮小
;; C-a:画面左端へ移動 q:終了．適当な位置，サイズになったら，q
(defun ma:window-ctrl ()
  "Window size and position control."
  (interactive)
  (let* ((rlist (frame-parameters (selected-frame)))
		 (tMargin (cdr (assoc 'top rlist)))
		 (lMargin (cdr (assoc 'left rlist)))
		 (displaywidth (x-display-pixel-width))
		 (displayheight (x-display-pixel-height))
		 (fObj (selected-frame))
		 (nCHeight (frame-height))
		 (nCWidth (frame-width))
		 endFlg
		 c)
	(catch 'endFlg
	  (while t
		(message "locate[%d:%d] size[%dx%d] move:C-p,C-n,C-f,C-b resize:p,n,f,b quit:q"
				 lMargin tMargin nCWidth nCHeight)
		(set-mouse-position
		 (if (or (featurep 'meadow) (eq system-type 'windows-nt)) ;; change 07.09.21-12:11
				 (selected-frame) (selected-window)) nCWidth 0)
		(setq c (read-char))
		(cond ((= c ?f) (set-frame-width fObj (setq nCWidth (+ nCWidth 2))))
			  ((= c ?b) (set-frame-width fObj (setq nCWidth (- nCWidth 2))))
			  ((= c ?n) (set-frame-height fObj (setq nCHeight (+ nCHeight 2))))
			  ((= c ?p) (set-frame-height fObj (setq nCHeight (- nCHeight 2))))
			  ((= c 6) (modify-frame-parameters
						nil (list (cons 'left (setq lMargin (+ lMargin 20))))))
			  ((= c 2) (modify-frame-parameters
						nil (list (cons 'left (setq lMargin (- lMargin 20))))))
			  ((= c 14) (modify-frame-parameters
						 nil (list (cons 'top (setq tMargin (+ tMargin 20))))))
			  ((= c 16) (modify-frame-parameters
						 nil (list (cons 'top (setq tMargin (- tMargin 20))))))
			  ((= c 1) (modify-frame-parameters
						nil (list (cons 'left (setq lMargin 0)))))
			  ((= c 5) (modify-frame-parameters
						nil (list (cons 'left
										(setq lMargin
											  (- displaywidth (frame-pixel-width)))))))
			  ((= c ?q) (message "quit") (throw 'endFlg t)))))))

(define-key my-key-map "w" 'ma:window-ctrl)

; ;; 07.09.26(wed)-20:01
; (require 'anything-config)
; (global-set-key "\C-x\C-a" 'anything)
; (global-set-key [?\C-;] 'anything) ;'
; (define-key anything-map "\en" 'anything-next-source)
; (define-key anything-map "\ep" 'anything-previous-source)
; ;(anything-iswitchb-setup)
; 
; ;; http://dev.ariel-networks.com/Members/matsuyama/open-anything-emacs
; (defadvice anything-check-minibuffer-input (around sit-for activate)
;   (if (sit-for anything-idle-delay t)
; 	  ad-do-it))
; 
; ;; add
; ;; Occur
; (defvar anything-c-source-occur
;   '((name . "Occur")
;     (init . (lambda ()
;               (setq anything-c-source-occur-current-buffer
;                     (current-buffer))))
;     (candidates . (lambda ()
;                     (setq anything-occur-buf (get-buffer-create "*Anything Occur*"))
;                     (with-current-buffer anything-occur-buf
;                       (erase-buffer)
;                       (let ((count (occur-engine anything-pattern
;                                                  (list anything-c-source-occur-current-buffer) anything-occur-buf
;                                                  list-matching-lines-default-context-lines nil
;                                                  list-matching-lines-buffer-name-face
;                                                  nil list-matching-lines-face
;                                                  (not (eq occur-excluded-properties t)))))
;                         (when (> count 0)
;                           (let ((lines (split-string (buffer-string) "\n" t)))
;                             (cdr lines)))))))
;     (action . (("Goto line" . (lambda (candidate)
;                                 (goto-line (string-to-number candidate) anything-c-source-occur-current-buffer)))))
;     (requires-pattern . 3)
;     (volatile)))
; 
; ;; Register
; (defvar anything-c-source-register
;   '((name . "Registers")
;     (candidates . anything-c-registers)
;     (action ("insert" . insert))))
; ;; based on list-register.el
; (defun anything-c-registers ()
;   (loop for (char . val) in register-alist
;         collect
;         (let ((key (single-key-description char))
;               (string (cond
;                        ((numberp val)
;                         (int-to-string val))
;                        ((markerp val)
; 						(let ((buf (marker-buffer val)))
; 						  (if (null buf)
; 							  "a marker in no buffer"
; 							(concat
; 							 "a buffer position:"
; 							 (buffer-name buf)
; 							 ", position "
; 							 (int-to-string (marker-position val))))))
; 					   ((and (consp val) (window-configuration-p (car val)))
; 						"conf:a window configuration.")
; 					   ((and (consp val) (frame-configuration-p (car val)))
; 						"conf:a frame configuration.")
; 					   ((and (consp val) (eq (car val) 'file))
; 						(concat "file:"
; 								(prin1-to-string (cdr val))
; 								"."))
; 					   ((and (consp val) (eq (car val) 'file-query))
; 						(concat "file:a file-query reference: file "
; 								(car (cdr val))
; 								", position "
; 								(int-to-string (car (cdr (cdr val))))
; 								"."))
; 					   ((consp val)
; 						(let ((lines (format "%4d" (length val))))
; 						  (format "%s: %s\n" lines
; 								  (truncate-string
; 								   (mapconcat (lambda (y) y) val
; 											  "^J") (- (window-width) 15)))))
; 					   ((stringp val)
; 						val)
; 					   (t
; 						"GARBAGE!"))))
;           (cons (format "register %3s: %s" key string) string))))
; 
; ;; @semantic
; ;; 08.04.21(mon)-15:52
; (defun anything-c-source-semantic-construct-candidates (tags depth)
;   (apply 'append 
; 		 (mapcar '(lambda (tag)
; 					(when (and (listp tag)
; 							   (or (equal (semantic-tag-type tag) "class")
; 								   (eq (semantic-tag-class tag) 'function)))
; 					  (cons (cons (concat (make-string (* depth 2) ?\s)
; 										  (semantic-format-tag-summarize tag nil t)) tag)
; 							(anything-c-source-semantic-construct-candidates (semantic-tag-components tag) (1+ depth)))))
; 				 tags)))
; 
; (defvar anything-c-source-semantic
;   '((name . "Semantic Tags")
;     (init . (lambda ()
;               (setq anything-c-source-semantic-candidates
;                     (anything-c-source-semantic-construct-candidates (semantic-fetch-tags) 0))))
;     (candidates . (lambda ()
;                     (mapcar 'car anything-c-source-semantic-candidates)))
;     (action . (("Goto tag" . (lambda (candidate)
;                                (let ((tag (cdr (assoc candidate anything-c-source-semantic-candidates))))
;                                  (semantic-go-to-tag tag))))))))
; 
; ;; anything sources set
; (setq anything-sources
;       (list
; 	   anything-c-source-buffers
; 	   anything-c-source-file-name-history
; 	   anything-c-source-emacs-commands
; 	   anything-c-source-occur
; 	   anything-c-source-register
; 	   anything-c-source-bookmarks
; 	   ;anything-c-source-google-suggest
; 	   ;;anything-c-source-file-cache
; 	   ;;anything-c-source-man-pages
; 	   anything-c-source-info-pages
; 	   ;;anything-c-source-calculation-result
; 	   anything-c-source-locate
; 	   ;;anything-c-source-semantic
; 	   ))
; 
; (eval-after-load "anything"
;   '(progn
; 	 (set-face-bold-p 'anything-header t)
; 	 (set-face-foreground 'anything-header "black")
; 	 (set-face-background 'anything-header "DarkSeaGreen4")
; 	 (set-face-foreground 'anything-isearch-match "white")
; 	 (set-face-background 'anything-isearch-match "IndianRed")
; 	 ))

;;
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

;(global-set-key "\es" 'ma:resize-win-interactively)
(define-key my-key-map "r" 'ma:resize-win-interactively)

;; カーソルを点滅させない
(blink-cursor-mode nil)
;; 他のウィンドウにはカーソルを表示しない
(setq cursor-in-non-selected-windows nil)

;; ツールバーを表示しない
(tool-bar-mode 0)
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
; (defun ma:toggle-menubar ()
;   (interactive)
;   (if menu-bar-mode
; 	  (menu-bar-mode -1) (menu-bar-mode 1))
;   (message "Menu-bar is %s" (or (and menu-bar-mode "ON") "OFF") ))
; (define-key my-key-map "," 'ma:toggle-menubar)

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
(display-time)

;;
;(defun ma:toggle-speedbar ()
;  (interactive)
;  (cond ((equal speedbar-frame nil) (speedbar nil))
;		(t (speedbar))))
(eval-after-load "speedbar"
  '(progn
	 (define-key speedbar-key-map "u" 'speedbar-up-directory)
	 (define-key speedbar-key-map "s" 'speedbar-toggle-show-all-files)
	 (setcdr (assoc 'width speedbar-frame-parameters) 30)
	 ))

;(define-key my-key-map "b" 'ma:toggle-speedbar)
(define-key my-key-map "b" 'speedbar)
(define-key my-key-map "\C-b" 'speedbar)

;; 07.09.28(fri)-17:11
(if my-emacs22-0-p ;;(equal ma:emacs-ver "22.0")
	(progn
	  (require 'gnuserv)
	  (gnuserv-start)
	  ;; not new frame
	  (setq gnuserv-frame (selected-frame))))

;;; @ Unbind Key
(global-unset-key "\C-x\C-k")
(global-unset-key "\C-x\C-u")
(global-unset-key "\C-xt") ;tutorial
(global-unset-key "\C-z") ;suspend

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

;; 07.09.26(wed)-20:19
;(require 'iswitchb)
(require 'iswitchb)
;(require 'iswitchb-fc)
;(setq iswitchb-buffer-ignore '("^ " "*Buffer"))
;(iswitchb-default-keybindings)
;;; when create buffer not prompt
;(setq iswitchb-prompt-newbuffer nil)

(icomplete-mode 1)

;; rss
(autoload 'newsticker-start "newsticker" "Emacs Newsticker" t)
(autoload 'newsticker-show-news "newsticker" "Emacs Newsticker" t)

(setq newsticker-url-list
	  '(;;("KuRaKu" "http://kuraku.net/krk/index.xml")
		("はてなブックマーク 最近の人気エントリー"
		 "http://b.hatena.ne.jp/hotentry?mode=rss")
		("IT戦記" "http://d.hatena.ne.jp/amachang/rss")
		("ヒビノアワ" "http://cheebow.info/chemt/index.xml")
		))

;; @ eshell
;; 「.*」の挙動正しく
(setq eshell-glob-include-dot-dot nil)

(setq eshell-command-aliases-list
	  '(("ls1" "ls -1") ("lsl" "ls -al") ("cd." "cd ..")
		("bsh" "c:/home/masuda/java/bsh.bat")
		("rhino" "c:/home/masuda/js/rhino1_6R6/rhino.bat")))

; ;;; mapae 07.10.03(wed)-09:47
; (require 'mapae)
; (setq mapae-perl-command "/usr/bin/perl") ;; perl.exeへの絶対パス
; (setq mapae-command "/home/masuda/src/elisp/mapae/mapae.pl") ;; mapae.plへの絶対パス
; (setq mapae-recent-post-count 5) ;;最近のタイトル一覧で取得するエントリ数
; (global-set-key "\C-cwn" 'mapae-new-post)
; (global-set-key "\C-cwr" 'mapae-get-recent-post)
; (global-set-key "\C-cwg" 'mapae-get-post)
; (global-set-key "\C-cwl" 'mapae-get-recent-titles)
; (global-set-key "\C-cwp" 'mapae-ping-update)
; 
; ;(setq mapae-browser-command "C:/Program Files/Internet Explorer/iexplore.exe")
; (setq mapae-browser-option '("<URL>"))

;; @ カーソル付近のファイル/URL を開く
;(ffap-bindings)
;; rebind to default
(global-set-key "\C-x\C-v" 'find-alternate-file)

; ;; bf-mode
; (require 'bf-mode)
; ;; 別ウィンドウに表示するサイズの上限
; (setq bf-mode-browsing-size 10)
; ;; 別ウィンドウに表示しないファイルの拡張子
; (setq bf-mode-except-ext '("\\.exe$" "\\.com$"))
; ;; 容量がいくつであっても表示して欲しいもの
; (setq bf-mode-force-browse-exts
;       (append '("\\.texi$" "\\.el$")
;               bf-mode-force-browse-exts))

;; html は w3m で表示する
;(setq bf-mode-html-with-w3m t)
;; 圧縮されたファイルを表示
(setq bf-mode-archive-list-verbose t)
;; ディレクトリ内のファイル一覧を表示
(setq bf-mode-directory-list-verbose t)
;;
(define-key dired-mode-map "v" 'bf-mode)
;;上限のサイズ
(setq bf-mode-browsing-size 500)

; ;; @ browse-url
; (setq thing-at-point-url-path-regexp
;       "[^]\t\n \"'()<>[^`{}]*[^]\t\n \"'()<>[^`{}.,;]+")
; 
; (setq thing-at-point-url-regexp
;       (concat
;        "\\<\\(h?t?tps?://\\|ftp://\\|gopher://\\|"
;        "telnet://\\|wais://\\|file:/\\|s?news:\\|mailto:\\)"
;        thing-at-point-url-path-regexp))
; 
; (setq browse-url-browser-function '(("." . browse-url-firefox)))
; ;(setq browse-url-browser-function '(("." . w3m-browse-url)))
; (setq browse-url-firefox-program "firefox")
; (defun browse-url-firefox (url &optional new-window)
;   (interactive (browse-url-interactive-arg "URL: "))
;   (if (string-match "^t?tp://" url)
;       (setq url (concat "http://" (substring url (match-end 0)))))
;   (if (string-match "^t?tps://" url)
;       (setq url (concat "https://" (substring url (match-end 0)))))
;   (start-process (concat browse-url-firefox-program url) nil
; 		 browse-url-firefox-program "-remote"
; 		 (concat "openurl(" url ", new-tab)")))

; @ 08.12.21(sun)-23:20
; デフォールト・ブラウザーを mozilla に設定
(setq browse-url-browser-function 'browse-url-mozilla)
; C-c u でブラウザー起動
(global-set-key "\C-cu" 'browse-url-at-point)
; 右クリックでブラウザー起動
(global-set-key [mouse-3] 'browse-url-at-mouse)

(setq browse-url-mozilla-program "C:/Program Files/Mozilla Firefox/firefox.exe")

;; @time-stamp
(require 'time-stamp)
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)
;(setq time-stamp-start "last updated : ")
;(setq time-stamp-format "%04y/%02m/%02d")
;(setq time-stamp-end " \\|$")

;; @ flymake
(require 'flymake)
;; display error in minibuffer
(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))

(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")
(global-set-key "\egn" 'flymake-goto-next-error)
(global-set-key "\egp" 'flymake-goto-prev-error)
(global-set-key "\egc" 'flymake-start-syntax-check)
(global-set-key "\eg?" 'credmp/flymake-display-err-minibuf)

; ;; Ruby
; ;; Invoke ruby with '-c' to get syntax checking
; (defun flymake-ruby-init ()
;   (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;                        'flymake-create-temp-inplace))
;          (local-file  (file-relative-name
;                        temp-file
;                        (file-name-directory buffer-file-name))))
;     (list "ruby" (list "-c" local-file))))
; (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
; (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
; (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
; (add-hook
;  'ruby-mode-hook
;  '(lambda ()
;     ;; Don't want flymake mode for ruby regions in rhtml files
;     (if (not (null buffer-file-name)) (flymake-mode))))

; ;;
; (setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
;                                      interpreter-mode-alist))
; (autoload 'run-ruby "inf-ruby"
;   "Run an inferior Ruby process")
; (autoload 'inf-ruby-keys "inf-ruby"
;   "Set local key defs for inf-ruby in ruby-mode")
; (autoload 'rubydb "rubydb3x"
;   "ruby debug run")
; (add-hook 'ruby-mode-hook
;           '(lambda ()
;             (inf-ruby-keys)))

;; javascript
(add-hook 'javascript-mode-hook
		  (lambda ()
			(require 'flymake-jsl)
			(setq flymake-check-was-interrupted t)))
(add-hook 'ecmascript-mode-hook
		  (lambda ()
			(setq flymake-jsl-mode-map 'ecmascript-mode-map)
			(require 'flymake-jsl)
			(setq flymake-check-was-interrupted t)))

(setq js-indent-level 4)
 
;;; For Flymake Perl
;(require 'flymake-perl)
(require 'set-perl5lib)
;(add-hook 'perl-mode-hook
;           '(lambda ()
;              (flymake-perl-load)))
;; Perl用設定
;; http://unknownplace.org/memo/2007/12/21#e001
(defvar flymake-perl-err-line-patterns
  '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))

(defconst flymake-allowed-perl-file-name-masks
  '(("\\.pl$" flymake-perl-init)
    ("\\.pm$" flymake-perl-init)
    ("\\.t$" flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
  (set-perl5lib)
  (flymake-mode t))

(add-hook 'cperl-mode-hook 'flymake-perl-load)

(define-key my-key-map "f" 'flymake-mode)

; ;;; For Flymake PHP
; (require 'flymake-php)

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

;; 07.12.19(wed)-13:42
;; space tab color
;;; タブと全角スペースを目立たせる
(defface my-face-zenkaku '((t (:background "gray40" :foreground "white"))) nil)
;(defface my-face-b-1 '((t (:background "LightCyan1" :foreground "black"))) nil)
(defface my-face-last-space '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-zenkaku 'my-face-zenkaku)
(defvar my-face-last-space 'my-face-last-space)
(defface my-face-under-gray '((t (:foreground "gray10" :underline t))) nil)
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
(add-hook 'find-file-hooks '(lambda ()
							  (if font-lock-mode
								  nil
								(font-lock-mode t))) t)

;;全角スペースを強調
;(require 'jaspace)


;; 07.12.28(fri)-11:31
;; http://ubulog.blogspot.com/search/label/emacs
(defun ma:outtree ()
  "outline-tree
見出しを別ウィンドウで表示させる.
by yama @ Thu Mar 29 23:37:45 2007"
  (interactive)
  (if 'outline-mode (outline-mode))
  (hide-body)
  (let* ((basename (princ (buffer-name)))
         (newtmp (concat basename "-tree")))
    (if (get-buffer newtmp)
        (unless (get-buffer-window newtmp)
            (split-window-vertically 10)
            (switch-to-buffer newtmp)
            (other-window 1))
      (progn
        (make-indirect-buffer (current-buffer) newtmp)
        (split-window-vertically 10)
        (switch-to-buffer newtmp)
        (if 'outline-mode (outline-mode))
        (hide-sublevels 1)
        (other-window 1)))))

;; instead toggle-truncate-lines
;;(defun ma:toggle-truncate-lines ()
;;  "折り返し表示をトグル動作します."
;;  (interactive)
;;  (if truncate-lines
;;      (setq truncate-lines nil)
;;    (setq truncate-lines t))
;;  (recenter))

;; 08.01.07(mon)-12:25
;; def: '(5 ((shift) . 1)
;; マウスホイールの感度を調整 (5 > 1)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1) ((control))))

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

;; 08.01.09(wed)-11:14
;; ミニバッファの文字削除を楽に、
;; C-d: セパレータで削除、 M-C-d: ~/ → c:/home/masuda
;; http://ko.meadowy.net/~shirai/diary/20030819.html#p01
; (defvar minibuf-shrink-type0-chars '((w3m-input-url-history . (?/ ?+ ?:))
; 									 (read-expression-history . (?\) ))
; 									 (t . (?/ ?+ ?~ ?:)))
;   "*minibuffer-history-variable とセパレータと見なす character の alist。
; type0 はセパレータを残すもの。")
;
; (defvar minibuf-shrink-type1-chars '((file-name-history . (?.))
; 									 (w3m-input-url-history . (?# ?? ?& ?.))
; 									 (t . (?- ?_ ?. ? )))
;   "*minibuffer-history-variable とセパレータと見なす character の alist。
; type1 はセパレータを消去するもの。")
;
; (defun minibuf-shrink-get-chars (types)
;   (or (cdr (assq minibuffer-history-variable types))
;       (cdr (assq t types))))
;
; (defun minibuf-shrink (&optional args)
;   "point が buffer の最後なら 1 word 消去する。その他の場合は delete-char を起動する。
; 単語のセパレータは minibuf-shrink-type[01]-chars。"
;   (interactive "p")
;   (if (/= (if (fboundp 'field-end) (field-end) (point-max)) (point))
;       (delete-char args)
;     (let ((type0 (minibuf-shrink-get-chars minibuf-shrink-type0-chars))
; 		  (type1 (minibuf-shrink-get-chars minibuf-shrink-type1-chars))
; 		  (count (if (<= args 0) 1 args))
; 		  char)
;       (while (not (zerop count))
; 		(when (memq (setq char (char-before)) type0)
; 		  (delete-char -1)
; 		  (while (eq char (char-before))
; 			(delete-char -1)))
; 		(setq count (catch 'detect
; 					  (while (/= (if (fboundp 'field-beginning)
; 									 (field-beginning) (point-min))
; 								 (point))
; 						(setq char (char-before))
; 						(cond
; 						 ((memq char type0)
; 						  (throw 'detect (1- count)))
; 						 ((memq char type1)
; 						  (delete-char -1)
; 						  (while (eq char (char-before))
; 							(delete-char -1))
; 						  (throw 'detect (1- count)))
; 						 (t (delete-char -1))))
; 					  ;; exit
; 					  0))))))
;
; (defvar minibuf-expand-filename-original nil)
; (defvar minibuf-expand-filename-begin nil)
;
; (defun minibuf-expand-filename (&optional args)
;   "file-name-history だったら minibuffer の内容を expand-file-name する。
; 連続して起動すると元に戻す。C-u 付きだと link を展開する。"
;   (interactive "P")
;   (when (eq minibuffer-history-variable 'file-name-history)
;     (let* ((try-again (eq last-command this-command))
; 		   (beg (cond
; 				 ;; Emacs21.3.50 + ange-ftp だと2回目に変になる
; 				 ((and try-again minibuf-expand-filename-begin)
; 				  minibuf-expand-filename-begin)
; 				 ((fboundp 'field-beginning) (field-beginning))
; 				 (t (point-min))))
; 		   (end (if (fboundp 'field-end) (field-end) (point-max)))
; 		   (file (buffer-substring-no-properties beg end))
; 		   (remote (when (string-match "^\\(/[^:/]+:\\)/" file)
; 					 (match-string 1 file)))
; 		   (home (if (string-match "^\\(/[^:/]+:\\)/" file)
; 					 (expand-file-name (format "%s~" (match-string 1 file)))
; 				   (expand-file-name "~"))))
;       (unless try-again
; 		(setq minibuf-expand-filename-begin beg))
;       (cond
;        ((and args try-again minibuf-expand-filename-original)
; 		(setq file (file-chase-links (expand-file-name file))))
;        (args
; 		(setq minibuf-expand-filename-original file)
; 		(setq file (file-chase-links (expand-file-name file))))
;        ((and try-again minibuf-expand-filename-original)
; 		(setq file minibuf-expand-filename-original)
; 		(setq minibuf-expand-filename-original nil))
;        (t
; 		(setq minibuf-expand-filename-original file)
; 		(if (string-match (concat "^" (regexp-quote home)) file)
; 			(if remote
; 				(setq file (concat remote "~" (substring file (match-end 0))))
; 			  (setq file (concat "~" (substring file (match-end 0)))))
; 		  (setq file (expand-file-name file)))))
;       (delete-region beg end)
;       (insert file))))
;
; (mapcar (lambda (map)
; 		  (define-key map "\C-d" 'minibuf-shrink)
; 		  (define-key map "\M-\C-d" 'minibuf-expand-filename))
; 		(delq nil (list (and (boundp 'minibuffer-local-map)
; 							 minibuffer-local-map)
; 						(and (boundp 'minibuffer-local-ns-map)
; 							 minibuffer-local-ns-map)
; 						(and (boundp 'minibuffer-local-completion-map)
; 							 minibuffer-local-completion-map)
; 						(and (boundp 'minibuffer-local-must-match-map)
; 							 minibuffer-local-must-match-map))))

;; ;; 08.01.09(wed)-13:30
;; ;; Ee - Emacs Information Manager
;; (require 'ee-autoloads)
;; 
;; ;; アウトラインの該当個所を表示
;; ;; ee のアウトライン表示で該当箇所を別ウィンドウに表示できる．
;; (defadvice previous-line
;;   (after ee activate)
;;   (if (and (eq major-mode 'ee-mode)
;;            (string-match "ee-outline" (buffer-name (current-buffer))))
;;       (ee-outline-display-buffer)))
;; 
;; (defadvice next-line
;;   (after ee activate)
;;   (if (and (eq major-mode 'ee-mode)
;;            (string-match "ee-outline" (buffer-name (current-buffer))))
;;       (ee-outline-display-buffer)))
;; 
;; (defadvice ee-view-record-select-or-expansion-show-or-hide
;;   (around ee-delete-window activate)
;;   (if (and (eq major-mode 'ee-mode)
;;            (string-match "ee-outline" (buffer-name (current-buffer))))
;;       (progn
;;         ad-do-it
;;         (delete-other-windows))
;;     ad-do-it))
;; 
;; (define-key my-key-map "e"
;;   '(lambda ()
;; 	 "事前にoutline-modeを起動してからee-outlineにする"
;; 	 (interactive)
;; 	 (outline-mode)
;; 	 (ee-outline)))

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

;; 08.01.15(tue)-14:56 line-number-toggle
;; http://homepage1.nifty.com/blankspace/emacs/wb-line-number.html
;(require 'wb-line-number)
;;(wb-line-number-toggle)
;(setq wb-line-number-scroll-bar t)

;(defun ma:line-num ()
;  (interactive)
;  (wb-line-number-toggle))
;(fset 'ma:line-num (symbol-function 'wb-line-number-toggle))
(defalias 'ma:line-num 'wb-line-number-toggle)
(define-key my-key-map "n" 'ma:line-num)

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

;; 08.02.06(wed)-17:08
;; create strings "1,2,3, .."
(defun ma:csv-numclm (&optional mx sp st)
  "args: max number, sepalator, start number"
  (interactive "P")
  (let ((n (if st st 1)) (sep (if sp sp ",")) (max (if mx mx 10)) (s ""))
	(while (<= n max)
	  (setq s (concat s (int-to-string n) sep))
	  (setq n (1+ n)))
	(insert (substring s 0 -1)) (insert "\n")))

;; 08.02.07(thu)-14:16
;; 共通のメモ ChangeLog を開く
(defun ma:memo ()
  (interactive)
  (add-change-log-entry nil (expand-file-name "./ChangeLog") nil t))
;;(define-key my-key-map "M" 'ma:memo)
(define-key my-key-map "M" 'add-change-log-entry)

;; Load howm setup file
;(load "~/elisp/howm-conf")

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

;; 08.02.27(wed)-11:04
;; 開いているファイルのあるディレクトリを explorer で開く
;(defun my-explorer-open ()
;  (interactive)
;  (shell-command "explorer /e,."))
;(define-key my-key-map "@" 'my-explorer-open)

;;
;(load "google")

;;
; (load "mime-setup") ;; wl の設定ではないが、無ければ追加しておく。
; (autoload 'wl "wl" "Wanderlust" t)
; (autoload 'wl-draft "wl" "Write draft with Wanderlust." t)

;; @ 08.04.04(fri)-11:12 
;; woman set
;; 初回起動が遅いので cache 作成。
(setq woman-cache-filename (expand-file-name "~/woman_cache"))
;; 新しく frame は作らない。
(setq woman-use-own-frame nil)

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

; ;; psvn.el
; ;;-----------------------------------------------------------------
; (require 'psvn)
; 
; (define-key svn-status-mode-map "q" 'egg-self-insert-command)
; (define-key svn-status-mode-map "Q" 'svn-status-bury-buffer)
; (define-key svn-status-mode-map "p" 'svn-status-previous-line)
; (define-key svn-status-mode-map "n" 'svn-status-next-line)
; (define-key svn-status-mode-map "<" 'svn-status-examine-parent)
; 
; (add-hook 'dired-mode-hook
;           '(lambda ()
;              (require 'dired-x)
;              ;;(define-key dired-mode-map "V" 'cvs-examine)
;              (define-key dired-mode-map "V" 'svn-status)
;              (turn-on-font-lock)
;              ))
; 
; ;; SVN (psvn.el)
; ;; 文字コードに気をつけること
; (add-hook 'svn-log-edit-mode-hook
; 		  '(lambda ()
; ;;			 (set-buffer-file-coding-system 'sjis)))
; 			 (set-buffer-file-coding-system 'utf-8-unix)))
; ;;  (setq svn-status-svn-executable "svn2")
; ;(setq svn-status-hide-unmodified t)
; (setq process-coding-system-alist
; ;;	  (cons '("svn" . sjis) process-coding-system-alist))
; 	  (cons '("svn" . utf-8-unix) process-coding-system-alist))
; (defadvice svn-status
;   (around sit-for activate)
;   ad-do-it
; ;;  (message "coding system is sjis"))
;   (message "coding system is utf-8-unix"))
; 
; ;(setq svn-status-hide-unmodified t)
; (define-key my-key-map "s" 'svn-status)

;; 08.04.15(tue)-15:17
;(load "urlencode")

;; 08.04.20(sun)-01:56
;; navi2ch
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

;; php-mode
;; @ 08.04.21(mon)-12:02
(autoload 'php-mode "php-mode" "PHP mode" t)

(defcustom php-file-patterns (list "\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'")
  "*List of file patterns for which to automatically invoke php-mode"
  :type '(repeat (regexp :tag "Pattern"))
  :group 'php)

(let ((php-file-patterns-temp php-file-patterns))
  (while php-file-patterns-temp
    (add-to-list 'auto-mode-alist
                 (cons (car php-file-patterns-temp) 'php-mode))
    (setq php-file-patterns-temp (cdr php-file-patterns-temp))))

;; 08.07.29(tue)-16:47
(add-hook 'php-mode-hook
          '(lambda ()
			 (cake)
			 ))

;; @ ttm-menu key
;; 08.04.21(mon)-16:03
(global-set-key "\M-@" 'tmm-menubar)

;; @ semantic
;; 08.04.21(mon)-16:03
;(setq semantic-load-turn-everything-on nil)
;(require 'semantic-load)

;; 08.04.02(wed)-18:23
;; shinonome-font
(cond (window-system
	   (cond (my-emacs22-p
			  ;(set-default-font "-*-M+2VM+IPAG circle-normal-r-*-*-11-*-*-*-*-*--*-*")
			  )

			 (my-emacs23-p
			  (set-default-font "M+2VM+IPAG circle-10")

			;(set-default-font "Verdana-9")
			;(set-fontset-font (frame-parameter nil 'font)
			;					'japanese-jisx0208
			;					'("ＭＳ ゴシック" . "unicode-bmp"))
			  ;; (set-default-font "Bitstream Vera Sans Mono-8")
			  ;; (set-fontset-font (frame-parameter nil 'font)
			  ;;				'japanese-jisx0208
			  ;;				'("VL ゴシック" . "unicode-bmp"))
			  )
			 )))

;; for SKK
;; Emacs23 でエラーになるので
(or (fboundp 'char-int)
    (fset 'char-int (symbol-function 'identity)))

;; @ Clipboard を X とやりとりする
;; 08.04.22(tue)-11:33
(setq x-select-enable-clipboard t)

;; @ org-mode
;; 08.04.22(tue)-14:04
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(add-hook 'org-mode
		  '(lambda ()
			 (local-unset-key (kbd "C-<tab>"))))

;; @ migemo
;; 08.04.26(sat)-00:40
;(load "migemo.el")

;; @
;; 08.04.29(tue)-14:58
; (defun check-mapae-buffer ()
;   (interactive)
;   (if (switch-to-buffer "+mapae:new")
; 	  (progn
; 		(message "mapae buf exist"); 
;		(save-buffer "./mapae_new.bak"))))
; 
; (add-hook 'kill-emacs-hook 'check-mapae-buffer)

;; @ twittering
(require 'twittering-mode)
;(setq twittering-username "kuraku")
;(setq twittering-password "passwd")
(setq twittering-icon-mode t)

; ;; @ Twitter twit.el
; ;(load "twit")
; (autoload 'twit-show-recent-tweets "twit" "Twitter mode" t)
; (autoload 'twit-follow-recent-tweets "twit" "Twitter mode" t)
; (defalias 'twit 'twit-show-recent-tweets)
; 
; ;(twit-mode t)
; ;(setq twit-username "kuraku")
; ;(setq twit-password "YOUR_PASSWORD")
; (setq url-http-real-basic-auth-storage
; 	  '(("twitter.com:80" ("Twitter API" . "a3VyYWt1OmFyaTg4a2E="))))
; (setq twit-follow-idle-interval 180)
; 
; (eval-after-load "twit"
;   '(progn
; 	 (twit-mode t)
; 	 (set-face-foreground 'twit-author-face "LightGreen")
; 	 (set-face-foreground 'twit-location-face "cyan")
; 	 (set-face-foreground 'twit-timestamp-face "DarkKhaki")
; 	 (set-face-foreground 'twit-user-id-face "goldenrod1")
; 	 (set-face-foreground 'twit-uri-face "DodgerBlue")
; 	 (set-face-foreground 'twit-src-info-face "IndianRed1")
; 
; 	 (define-key twit-status-mode-map "?" 'twit-help)
; 	 (define-key twit-followers-mode-map "?" 'twit-follow-help)
; 	 ;;(defvar twit-status-mode-map (make-sparse-keymap))
; 	 ;;(defvar twit-followers-mode-map (make-sparse-keymap))
; ))
; 
; (defun twit-help ()
;   (interactive)
;   (message "w:post W:reply r,s:recent-tweets <,>:begin,end @:show-replies f:list-friends F:list-followers"))
; 
; (defun twit-follow-help ()
;   (interactive)
;   (message "A:following-create D:following-destroy <,>:begin,end "))

; ;;; Twittering mode
; ;;;
; (require 'twittering-mode)
; (setq twittering-username "kuraku")
; (setq twittering-password (rot13-string "nev88xn"))
; (twittering-icon-mode t)
; ;(twittering-scroll-mode t)
; (setq twittering-timer-interval 1800) ; def:90
; (setq twittering-status-format " %i %s(%S),  %@:\n %t\n%L (via %f)")
; ;(setq twittering-jojo-mode t)

;; 08.06.23(mon)-12:34
;;(setq tramp-shell-prompt-pattern "^.*[#$%>] *")


;; @ 08.07.10(thu)-13:03
;(require 'cake)

; ;; 08.09.15(mon)-08:53
; ;; git-emacs
; 
; ;(defadvice git-status-quit
; ;  (after my-git-status-quit activate)
; ;  (delete-window))
; 
; ;(require 'ido)
; ;(ido-mode t)
; 
; (require 'git-emacs)
; 
; (define-key global-map "\C-x\C-g" 'git-status)
; (define-key my-key-map "g" 'git-status)
; 
; (setq git--repository-bookmarks
;       '("git://github.com/xcezx/scratch.git"
;         "git://github.com/xcezx/dotfiles.git"))

;;
(define-key my-key-map "y" 'browse-kill-ring)

;; 08.10.01(wed)-12:26
;; ansi-term
; (load-library "~/elisp/shell-toggle-patched.el")
; (autoload 'shell-toggle "shell-toggle"
;   "Toggles between the *shell* buffer and whatever buffer you are editing."
;   t)
; (autoload 'shell-toggle-cd "shell-toggle"
;   "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)
; (global-set-key "\C-ct" 'shell-toggle)
; (global-set-key "\C-cd" 'shell-toggle-cd)
; (put 'downcase-region 'disabled nil)

;; 08.12.11(thu)-17:51
;; auto-complete
;(require 'auto-complete)
;(global-auto-complete-mode t)

;; @ Riece
;; 08.12.16(tue)-23:56
;(autoload 'riece "riece" "Start Riece" t)

;; 新しくbufferを作らない
(require 'dired)
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map "a" 'dired-advertised-find-file)

;; added posren
;(fixed-width-set-fontset "msgothic" 12)

;; check font (insert (prin1-to-string (x-list-fonts "*")))
(load-file "~/elisp/my-outline.el")
(load-file "~/elisp/my-faces.el")
(load-file "~/elisp/my-font.el")