;; dot.emacs for NTEmacs  -*- emacs-lisp -*-
;; Time-stamp: <2016-07-05 14:38 akira.masuda>
;;
;; change 2006.12.28 MAS
;; updated 2007.09.20 MAS
;; updated 2010.06.08 in posren
;; updated 12.10.17(wed)-11:31 in posren Emacs24

;; Tips
;; ファイルを指定コードで開き直す: C-x RET c 文字コードを入力 RET C-x C-v RET
;; 重複する関数を取得: M-x list-load-path-shadows

(cd "~")

(set-language-environment 'Japanese)

;; @@ set register
(set-register ?i '(file . "~/.emacs.d/init.el"))
(set-register ?m '(file . "~/.emacs.d/ntemacs24.el"))
(set-register ?s '(file . "~/.emacs.d/scratch.el"))
(set-register ?d '(file . "c:/Documents and Settings/akira.masuda/My Documents"))
(set-register ?e '(file . "z:/personal/akira.masuda/Eclipse"))
(set-register ?o '(file . "~/.emacs.d/org/"))

;; @ 圧縮ファイルも読める
(require 'jka-compr)

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
;;(setq ma:byte-comple-list '("~/.emacs.el" "~/.emacs" "~/elisp/howm-conf.el"))
(setq ma:byte-comple-list '("~/.emacs.d/ntemacs24.el"))
(add-hook 'after-save-hook
          (lambda ()
            (mapcar
             (lambda (file)
               (setq file (expand-file-name file))
               (when (string= file (buffer-file-name))
                 (save-excursion (byte-compile-file file))))
			 ma:byte-comple-list)))

;; buffer list
(require 'ibuffer)
(setq ibuffer-default-sorting-mode "recency")
(setq ibuffer-formats
      '((mark modified read-only " " (name 30 30)
              " " (size 6 -1) " " (mode 16 16) " " filename)
        (mark " " (name 30 -1) " " filename)))

;;; @ ruby-mode
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files")
(setq auto-mode-alist
	  (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist
	  (append '(("^#!.*ruby" . ruby-mode)) interpreter-mode-alist))

(add-hook 'ruby-mode-hook
		  '(lambda () (inf-ruby-keys)))
(setq ruby-indent-level 3)

;; **** keisen-mule.el ****
(unless (fboundp 'sref) (defalias 'sref 'aref))
(if window-system
	(autoload 'keisen-mode "keisen-mouse" "MULE版罫線モード＋マウス" t))
(autoload 'keisen-mode "keisen-mule" "MULE版罫線モード" t)

;; @ 以降 2007.09.20 からの変更とか、過去の elisp からの移行
(add-to-list 'auto-mode-alist '("\\.js\\'" . ecmascript-mode))
(autoload 'ecmascript-mode "ecmascript-mode" "ECMAScript" t)
;; javascript-mode
(autoload 'javascript-mode "javascript" "JavaScript" t)

;;
;;20160204 (autoload 'bsh-run "beanshell" "Bean Shell" t)
;;20160204 (setq bsh-jar "C:/home/masuda/java/bsh-2.0b4.jar")
;;20160204 (setq bsh-startup-directory "~/java")
;;20160204 (setq bsh-classpath '("C:/fzk/fzk2/FZK-Java/classes"))

;; color-moccur
;; 10.10.18(mon)-09:57
;; M-x moccur : ファイルバッファのみを検索 (正規表現)
;; C-u M-x moccur : すべてのバッファを検索 (正規表現)
;; M-x dmoccur : 指定したディレクトリ下のファイルを検索 (正規表現)
;; C-u M-x dmoccur : あらかじめ指定しておいたディレクトリ下のファイルを検索できる (正規表現)
;; M-x moccur-grep : grep のようにファイルを検索 (正規表現)
;; M-x moccur-grep-find : grep+find のようにファイルを検索 (正規表現)
;; M-x search-buffers : すべてのバッファを全文検索．
;; M-x grep-buffers : 開いているファイルを対象に grep ．
;; バッファリストで M-x Buffer-menu-moccur : m でマークをつけたバッファのみを対象に検索
;; dired で M-x dired-do-moccur : m でマークをつけたファイルのみを対象に検索
;; moccur の結果でs:一致したバッファのみで再検索
;; moccur の結果でu:一つ前の条件で検索
(require 'color-moccur)
(require 'moccur-edit)

;; 折り返し toggle
(defalias 'tt 'toggle-truncate-lines)

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
;;(show-paren-mode 1)

;; key set
;;(global-set-key "\e=" 'what-line)
(global-set-key "\es" 'enlarge-window)

;;; @ display time
(setq display-time-string-forms
	  '(month "/" day " " dayname " " 24-hours ":" minutes))
;; '(month "/" day " " dayname " "))
(global-set-key [f3] 'display-time-mode)

(defun ma:display-time-date ()
  (interactive)
  (message (format-time-string "%Y.%m.%d (%A) - %R" (current-time))))
(global-set-key [f4] 'ma:display-time-date)

;;; @ date/time insert
(defun ma:insert-date-time (&optional confirm)
  (interactive "P")
  (let* ((wlist '("sun" "mon" "tue" "wed" "thu" "fri" "sat"))
		 (week-str (car (nthcdr (string-to-number (format-time-string "%w" (current-time))) wlist)))
		 date-str)
	(if confirm
		(insert (format-time-string "%y.%m.%d" (current-time)))
	  (progn
		(setq date-str (format-time-string "%Y-%m-%d %%s %R" (current-time)))
		(insert (format date-str week-str))))))

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

;;; @ タブかスペースだけの行は、空にする
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

;;; @ 行末のタブかスペースを消す
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

(define-key my-key-map "l" 'ma:followspace-cut)

;;; @ タブかスペースの連続をスペースひとつだけにする
;;(defun ma:tabspace-cut ()
;; (interactive)
;; (replace-regexp "[ ]+" " " nil (region-beginning) (region-end)))

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
				(replace-regexp "[ 	]+" " " nil b e))
			(message ""))
		(message "マッチしませんでした.")))))

;;(define-key my-key-map " " 'ma:tabspace-cut)

;; ;; history から重複したのを消す (M-x M-p とかの) 03.02.19(Wed)-10:59
(require 'cl)
;; (defun minibuffer-delete-duplicate ()
;;   (let (list)
;; 	(dolist (elt (symbol-value minibuffer-history-variable))
;; 	  (unless (member elt list)
;; 		(push elt list)))
;; 	(set minibuffer-history-variable (nreverse list))))
;; ;;; [2013-02-28 Thu] minibuffer-history-variable が t だとエラーになるので、その場合を外すことにした。
;; for 24.3
(defun minibuffer-delete-duplicate ()
  (unless (eq minibuffer-history-variable t)
    (let (lst)
      (dolist (elm (symbol-value minibuffer-history-variable))
	(unless (member elm lst)
	  (push elm lst)))
      (set minibuffer-history-variable (nreverse lst)))))
 
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

;; 10.07.15(thu)-16:59
(require 'auto-install)

(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; 08.12.11(thu)-17:51
;; auto-complete
;;(require 'auto-complete)
;;(global-auto-complete-mode t)
;;comment 16/7/5

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

;;(global-set-key "\es" 'ma:resize-win-interactively)
(define-key my-key-map "r" 'ma:resize-win-interactively)

;; カーソルを点滅させない
(blink-cursor-mode nil)
;; 他のウィンドウにはカーソルを表示しない
(setq cursor-in-non-selected-windows nil)

;; ツールバーを表示しない
(tool-bar-mode 0)

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

;; ;; speedbar
;; (eval-after-load "speedbar"
;;   '(progn
;; 	 (define-key speedbar-key-map "u" 'speedbar-up-directory)
;; 	 (define-key speedbar-key-map "s" 'speedbar-toggle-show-all-files)
;; 	 (setcdr (assoc 'width speedbar-frame-parameters) 30)
;; 	 ))
;; 
;; ;;(define-key my-key-map "b" 'ma:toggle-speedbar)
;; ;;(define-key my-key-map "b" 'speedbar)
;; ;(define-key my-key-map "\C-b" 'speedbar)

;; ;;
;; (require 'sr-speedbar)
;; ;;(define-key my-key-map "b" 'sr-speedbar-toggle)
;; ;;(setq sr-speedbar-right-side nil)
;; (setq speedbar-show-unknown-files t)

;;; @ Unbind Key
(global-unset-key "\C-x\C-k")
(global-unset-key "\C-x\C-u")
(global-unset-key "\C-xt") ;tutorial
(global-unset-key "\C-z") ;suspend

;; grep find
(setq grep-program "c:/home/bin/egrep.exe")
(setq grep-command "c:/home/bin/egrep.exe -nrH -e \"\" .")
(setq find-program "c:/home/bin/find.exe")
(setq grep-find-command "c:/home/bin/find.exe . -type f -exec c:/home/bin/egrep.exe -nH -e \"\" {} NUL \;")
;;(setq grep-find-command "/bin/find.exe . -type f \| /bin/xargs.exe /bin/grep.exe -nH -e \"\"")

;; for linux
;;(setq grep-program "grep.exe")
;;(setq grep-command "grep -nrH -e \"\" .")
;;(setq find-program "find.exe")
;;(setq grep-find-command "find . -type f \| xargs grep -nH -e \"\"")

;;
(setq develock-auto-enable nil)
;;(require 'develock)

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
;; 20160204 ;; 2016-02-04 thu 16:32 diredとかで候補が出るのがいや
;; 20160204 (icomplete-mode 1)
;; 20160204 
;; 20160204 (define-key icomplete-minibuffer-map [?\C-i] 'minibuffer-force-complete)
;; 20160204 ;(define-key icomplete-minibuffer-map [?\C-m] 'minibuffer-force-complete-and-exit)
;; 20160204 (define-key icomplete-minibuffer-map [?\C-s]  'icomplete-forward-completions)
;; 20160204 (define-key icomplete-minibuffer-map [?\C-r]  'icomplete-backward-completions)
;; 20160204 (defvar icomplete-exceptional-command-list
;; 20160204   '(dired-create-directory
;; 20160204     dired-do-copy
;; 20160204     dired-do-rename))

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

;; @ カーソル付近のファイル/URL を開く
;;(ffap-bindings)
;; rebind to default
(global-set-key "\C-x\C-v" 'find-alternate-file)

;; @ 08.12.21(sun)-23:20
;; デフォールト・ブラウザーを mozilla に設定
;;(setq browse-url-browser-function 'browse-url-mozilla)
;; C-c u でブラウザー起動
(global-set-key "\C-cu" 'browse-url-at-point)
;; 右クリックでブラウザー起動
(global-set-key [mouse-3] 'browse-url-at-mouse)

;;(setq browse-url-mozilla-program "C:/Program Files/Mozilla Firefox/firefox.exe")
;;(setq browse-url-firefox-program browse-url-mozilla-program)

; (setq browse-url-browser-function 'browse-url-generic)
; ;;(setq browse-url-generic-program "google-chrome")
; (setq browse-url-generic-program
; 	  "c:/Documents and Settings/akira.masuda/Local Settings/Application Data/Google/Chrome/Application/chrome.exe")
; 
; (setq browse-url-browser-function 'browse-url-generic
;       browse-url-generic-program "google-chrome")

;;
(setq browse-url-chrome-program
	  "c:/Documents and Settings/akira.masuda/Local Settings/Application Data/Google/Chrome/Application/chrome.exe")

(defun browse-url-chrome (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (start-process "google-chrome" nil browse-url-chrome-program url))
(setq browse-url-browser-function 'browse-url-chrome)

;; @time-stamp
(require 'time-stamp)
;(add-hook 'before-save-hook 'time-stamp)
;(setq time-stamp-active t)

;;(setq time-stamp-start "last updated : ")
;;(setq time-stamp-format "%04y/%02m/%02d")
;;(setq time-stamp-end " \\|$")

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

;; moved inits/
;; ;; Perl用設定
;; (require 'set-perl5lib)
;; 
;; (autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
;; (setq auto-mode-alist
;; 	  (append '(("\\.\\([pP][Llm]\\|al\\)$" . cperl-mode))  auto-mode-alist ))
;; 
;; (eval-after-load "cperl-mode"
;;   '(Progn
;; 
;; 	 (set-face-bold-p 'cperl-array-face nil)
;; 	 (set-face-background 'cperl-array-face nil)
;; 	 (set-face-bold-p 'cperl-hash-face nil)
;; 	 (set-face-background 'cperl-hash-face nil)
;; 	 
;; 	 (setq cperl-indent-level 4
;; 		   cperl-continued-statement-offset 4
;; 		   cperl-close-paren-offset -4
;; 		   cperl-label-offset -4
;; 		   cperl-comment-column 40
;; 		   cperl-highlight-variables-indiscriminately t
;; 		   cperl-indent-parens-as-block t
;; 		   cperl-tab-always-indent nil
;; 		   cperl-font-lock t)
;; 	 ))
;; 
;; ;; 2013-11-26 tue 18:46 重いのではずす
;; ;;(add-hook 'cperl-mode-hook
;; ;;		  '(lambda ()
;; ;;			 (require 'perl-completion)
;; ;;			 (add-to-list 'ac-sources 'ac-source-perl-completion)
;; ;;			 (perl-completion-mode t)
;; ;;			 ;
;; ;;			 (local-set-key "\C-c\C-d" 'cperl-perldoc-at-point)
;; ;;			 (flymake-perl-load)
;; ;;			 (setq indent-tabs-mode nil) ))
;; 
;; ;;(add-hook 'cperl-mode-hook 'flymake-perl-load)
;; 
;; 
;; ;;; For Flymake Perl
;; ;; http://unknownplace.org/memo/2007/12/21#e001
;; (defvar flymake-perl-err-line-patterns
;;   '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))
;; 
;; (defconst flymake-allowed-perl-file-name-masks
;;   '(("\\.pl$" flymake-perl-init)
;; 	("\\.pm$" flymake-perl-init)
;; 	("\\.t$" flymake-perl-init)))
;; 
;; (defun flymake-perl-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;; 					 'flymake-create-temp-inplace))
;; 		 (local-file (file-relative-name
;; 					  temp-file
;; 					  (file-name-directory buffer-file-name))))
;; 	(list "perl" (list "-wc" local-file))))
;; 
;; (defun flymake-perl-load ()
;;   (interactive)
;;   (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
;; 	(setq flymake-check-was-interrupted t))
;;   (ad-activate 'flymake-post-syntax-check)
;;   (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
;;   (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
;;   ;;  (set-perl5lib)
;;   (flymake-mode t))
;; 
;; ;;(add-hook 'cperl-mode-hook 'flymake-perl-load)
;; 
;; ;;(define-key my-key-map "f" 'flymake-mode)
;; 
;; ;; ;;; For Flymake PHP
;; ;; (require 'flymake-php)
;; 
;; /cperl

;; 07.11.13(tue)-18:52
;;; for isearch add-on
;; 単語をC-wで追加した後，C-fとすると一文字ずつ追加
(defun isearch-yank-char ()
  "Pull next character from buffer into search string."
  (interactive)
  (isearch-yank-string
   (save-excursion
	 (and (not isearch-forward) isearch-other-end
		  (goto-char isearch-other-end)))))
;; isearch 中にC-oで occur を起動
(defun isearch-occur ()
  "Invoke `occur' from within isearch."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
	(occur
	 (if isearch-regexp
		 isearch-string (regexp-quote isearch-string)))))
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

;;全角スペースを強調
;;(require 'jaspace)

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
;;(global-set-key [C-right] 'switch-to-last-buffer-cyclic)
;;(global-set-key "\e\C-b" 'switch-to-last-buffer-cyclic)
(global-set-key [M-up] 'switch-to-last-buffer-cyclic)

(defun switch-to-next-buffer-cyclic()
  "Bury current buffer at bottom of list, and show next one."
  (interactive)
  (bury-buffer (buffer-name))
  (switch-to-buffer (get-fl-buffer)))
;;(global-set-key [C-left] 'switch-to-next-buffer-cyclic)
;;(global-set-key "\e\C-f" 'switch-to-next-buffer-cyclic)
(global-set-key [M-down] 'switch-to-next-buffer-cyclic)

;; 08.01.09(wed)-14:22
;; 行折り返しの表示
(set-face-foreground 'fringe "gray58")
(set-face-background 'fringe "gray20")
;; 行折返しでのfringe表示は右側だけにする
;;(if (fboundp 'fringe-mode) (fringe-mode '(nil . nil)))
;; 存在行の表示
(setq default-indicate-buffer-boundaries 'left)
;; 最終行以下を表示
;;(setq indicate-empty-lines t)

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
;;(define-key my-key-map "0" 'ma:exchange-2-windows)

;; 10.11.01(mon)-14:26
;; 次のウィンドウと入れ替え - こちらを採用
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
		(thisbuf (window-buffer)))
	(other-window 1)
	(set-window-buffer thiswin (window-buffer))
	(set-window-buffer (selected-window) thisbuf)))
(define-key my-key-map "0" 'swap-screen-with-cursor)

;; 08.01.21(mon)-12:16
;; 改行の種類表示をかえる
(setq eol-mnemonic-unix  "(LF)")
(setq eol-mnemonic-dos  "(CRLF)")
(setq eol-mnemonic-mac  "(CR)")

;; 08.01.21(mon)-13:24
;;(require 'install-elisp)

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
  (add-change-log-entry nil (expand-file-name "~/ChangeLog") nil t))
;;(define-key my-key-map "M" 'ma:memo)
(define-key my-key-map "M" 'add-change-log-entry)

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
(defun my-explorer-open ()
  (interactive)
  (shell-command "explorer /e,."))
(define-key my-key-map "@" 'my-explorer-open)

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

;; CVS 文字コード 改行コード
(modify-coding-system-alist 'process "^rlog" '(undecided . euc-jp-unix))
(modify-coding-system-alist 'process "^ci" '(undecided . euc-jp-unix))
(modify-coding-system-alist 'process "diff" '(undecided . euc-jp-unix))
(modify-coding-system-alist 'process "^cvs" '(undecided . euc-jp-unix))
;; ; 文字コードは EUC で改行コードは LF で
;; (modify-coding-system-alist 'process "cvs" '(undecided . euc-jp-unix))
;; ; EUC の場合
;;; (modify-coding-system-alist 'process "cvs" '(undecided . euc-japan))
;; ; 改行コードだけ UNIX (LF を用いる)
;; (modify-coding-system-alist 'process "cvs" '(undecided . undecided-unix))
;; sjis の場合
;; (modify-coding-system-alist 'process "cvs" '(undecided . sjis))
;; ; iso-2022-jp
;; (modify-coding-system-alist 'process "cvs" '(undecided . iso-2022-jp))

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
;;(add-hook 'php-mode-hook
;;		  '(lambda ()
;;			 (cake)
;;			 ))

;; @ ttm-menu key
;; 08.04.21(mon)-16:03
;;(global-set-key "\M-@" 'tmm-menubar)

;; @ semantic
;; 08.04.21(mon)-16:03
;;(setq semantic-load-turn-everything-on nil)
;;(require 'semantic-load)

;; @ Clipboard を X とやりとりする
;; 08.04.22(tue)-11:33
(setq x-select-enable-clipboard t)

;; ;; @ org-mode
;; ;; 08.04.22(tue)-14:04
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (add-hook 'org-mode
;; 		  '(lambda ()
;; 			 (local-unset-key (kbd "C-<tab>"))))
;; 
;; (require 'org-install)
;; (setq org-startup-truncated nil)
;; (setq org-return-follows-link t)
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (org-remember-insinuate)
;; (setq org-directory "c:/home/.emacs.d/org/")
;; (setq org-default-notes-file (concat org-directory "index.org"))
;; (setq org-remember-templates
;; 	  '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
;; 		("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
;; 		("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")
;; 		))

;;
(define-key my-key-map "y" 'browse-kill-ring)

;; @ Riece
;; 08.12.16(tue)-23:56
;;(autoload 'riece "riece" "Start Riece" t)

;; 10.07.23(fri)-11:20
(defun ma:toggle-tab-space ()
  (interactive)
  ;;(setq tab-width 4)
  (setq indent-tabs-mode (not indent-tabs-mode))
  (message "indent-tabs-mode is %s" (if indent-tabs-mode "tab" "space")))
(define-key my-key-map "B" 'ma:toggle-tab-space)

;; カーソル位置のフェースを調べる関数
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;;
(defun ma:frame-set ()
  (interactive)
  (progn
	(set-default-font "M+2VM+IPAG circle-10")
	(set-frame-parameter (selected-frame) 'alpha 94)))
(define-key my-key-map "c" 'ma:frame-set)

;; 10.10.04(mon)-15:57
(require 'zlc)
(let ((map minibuffer-local-map))
  ;;; like menu select
  (define-key map (kbd "<down>")  'zlc-select-next-vertical)
  (define-key map (kbd "<up>")    'zlc-select-previous-vertical)
  (define-key map (kbd "<right>") 'zlc-select-next)
  (define-key map (kbd "<left>")  'zlc-select-previous)

  ;;; reset selection
  (define-key map (kbd "C-c") 'zlc-reset)
  )

(require 'nav)
;;(global-set-key "\C-x\C-d" 'nav-toggle)
;;(define-key my-key-map "n" 'nav-toggle)

;; スクロール量調整
(setq scroll-small-size 15)

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

;; TT
(autoload 'tt-mode "tt-mode")
(setq auto-mode-alist
	  (append '(("\\.tt$" . tt-mode))  auto-mode-alist ))

(require 'edit-server)
(edit-server-start)

;;
(autoload (function igrep) "igrep"
  "*Run `grep` PROGRAM to match EXPRESSION in FILES..." t)
(autoload (function igrep-find) "igrep"
  "*Run `grep` via `find`..." t)
(autoload (function dired-do-igrep) "igrep"
  "*Run `grep` on the marked (or next prefix ARG) files." t)
(autoload (function dired-do-igrep-find) "igrep"
  "*Run `grep` via `find` on the marked (or next prefix ARG) directories." t)

;; @template-toolkit mode
(require 'html-tt)
(add-hook 'sgml-mode-hook 'html-tt-load-hook)
(eval-after-load "html-tt"
  '(progn
	 (set-face-foreground 'sequence-face "DarkSeaGreen2")
	 (setq html-tt-font-lock-keywords
		   (list
			'("\\[\%[_ \t\n\r]*[^\%]*\%\\]" 0 html-tt-sequence-face t)
			;;'("\\[\%[_ \t\n\r]*[^\%]+\%\\]" 0 html-tt-sequence-face t)
			'("\\[\% END \%\\]" 0 html-tt-sequence-face t))) ))

;; 10.10.26(tue)-09:52
;; @変更があった部分をハイライトする
(global-highlight-changes-mode nil)
(setq highlight-changes-visibility-initial-state nil)
;; 変更部分を可視化/不可視化のトグル
(define-key my-key-map "v" 'highlight-changes-visible-mode)
;; 変更部分を削除
;;(global-set-key (kbd "H-i") 'highlight-changes-remove-highlight)
;;次の変更箇所移動
(define-key my-key-map "]" 'highlight-changes-next-change)
;;前の変更箇所に移動
(define-key my-key-map "[" 'highlight-changes-previous-change)
(set-face-foreground 'highlight-changes nil)
(set-face-background 'highlight-changes "#382f2f")
(set-face-underline-p 'highlight-changes-delete nil)
(set-face-foreground 'highlight-changes-delete nil)
(set-face-background 'highlight-changes-delete "#916868")

;; 10.10.25(mon)-20:53
(setq initial-scratch-message "\
;; scratch buffer created -- happy hacking

")

;; バッファ名重複対策
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; カーソルライン
;;(global-hl-line-mode t)
;;(set-face-background 'hl-line "gray4")

(defface hlline-face
  '((((class color)
      (background dark))
     ;;(:background "dark slate gray"))
	 (:background "gray20"))
    (((class color)
      (background light))
     (:background "#CC0066"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode t)


;; 10.10.28(thu)-14:21
;; 同じコマンドを連続実行することで挙動を変える（行頭→先頭など）
(when (locate-library "sequential-command-config")
  (require 'sequential-command-config))
(global-set-key "\C-a" 'seq-home)
(global-set-key "\C-e" 'seq-end)
(when (require 'org nil t)
  (define-key org-mode-map "\C-a" 'org-seq-home)
  (define-key org-mode-map "\C-e" 'org-seq-end))
(define-key esc-map "u" 'seq-upcase-backward-word)
(define-key esc-map "c" 'seq-capitalize-backward-word)
(define-key esc-map "l" 'seq-downcase-backward-word)

;; @ 確実に画面下部に横長のウィンドウを作成します
;; 10.11.01(mon)-13:29
(require 'split-root)
(defvar split-root-window-height nil)
(defun display-buffer-function--split-root (buf &optional ignore)
  (let ((window (split-root-window split-root-window-height)))
	(set-window-buffer window buf)
	window))
;; Twitteringの設定を追加
(defadvice twittering-update-status-from-pop-up-buffer (around split-root activate)
  ""
  (let ((display-buffer-function 'display-buffer-function--split-root)
		(split-root-window-height 14)) ;; 表示行数を指定
	ad-do-it))
;; anything.elの設定も
(setq anything-display-function 'display-buffer-function--split-root)

;; 2013.05.07(tue)-15:02 comment for Emacs 24.3
;; ;; redo+
;; ;; 10.11.01(mon)-23:55
;; (require 'redo+)
;; (setq undo-no-redo t)
;; (setq undo-limit 600000)
;; (setq undo-strong-limit 900000)
;; (define-key my-key-map "R" 'redo)

;; tempbuf 不要なバッファを消す
;; 10.11.08(mon)-10:34
(require 'tempbuf)
(add-hook 'compilation-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'completion-list-mode-hook 'turn-on-tempbuf-mode)
(add-hook 'view-mode-hook 'turn-on-tempbuf-mode)

;; Info+
;; 10.11.17(wed)-11:02
(eval-after-load "info" '(require 'info+))


;;(require 'color-theme)
;; デフォルトテーマを設定する
;;(eval-after-load "color-theme"
;;  '(progn
;;     (color-theme-initialize)
;;     (color-theme-subtle-hacker)))

;; マウスカーソルの元いた位置から遠ざかるとマウスカーソルが戻ってくる
(mouse-avoidance-mode 'exile)

;; .ntemacsXX.elc check
;;(if (file-newer-than-file-p my-emacs-init (concat my-emacs-init "c"))
;;	(warn (concat my-emacs-init "c is OLD!!!!!")))

;; image
(auto-image-file-mode t)

;;
(global-set-key "\C-]" 'goto-line)

;; use-package
(eval-when-compile (require 'use-package))
(setq use-package-verbose t)
(setq use-package-minimum-reported-time 0.001)


;; END
