;; @ eshell
;; $ eshell t (別のeshellが起動する)
(require 'eshell) ;; use cvs
;(require 'eshell-auto)

;; ***EShellを複数立ちあげる場合***
;; $ eshell t

;; /bin/grep が存在すると仮定する
;; $ grep        #  Lisp 関数 `eshell/grep' を実行します
;; $ /bin/grep  # /bin/grep を実行します
;; $ *grep        # /bin/grep を実行します

;;`/dev/null', `/dev/kill', and`/dev/clip' がある

;; 「.*」の挙動正しく
(setq eshell-glob-include-dot-dot nil)

;; faceが壊れる??
;; (setq eshell-command-aliases-list
;; 	  '(("ls1" "ls -1") ("lsl" "ls -al") ("cd." "cd ..")
;; 		("bsh" "c:/home/masuda/java/bsh.bat")
;; 		("rhino" "c:/home/masuda/js/rhino1_6R6/rhino.bat")))

;; ;;(add-hook 'eshell-mode-hook
;; ;;		  '(lambda ()
;; ;;			 (define-key eshell-mode-map "\C-a" 'eshell-bol)
;; ;;			 ;;(local-set-key "\C-a" 'eshell-bol)
;; ;;			 ;;(set-face-bold-p 'eshell-prompt nil)
;; ;;			 ;;(set-face-bold-p 'eshell-ls-directory nil)
;; ;;			 ;;(set-face-bold-p 'eshell-ls-executable nil)
;; ;;			 ;;(set-face-bold-p 'eshell-ls-archive nil)
;; ;;			 ))

(autoload 'eshell-toggle "esh-toggle"
  "Toggles between the *eshell* buffer and whatever buffer you are editing." t)
(autoload 'eshell-toggle-cd "esh-toggle"
  "Pops up a shell-buffer and insert a \"cd <file-dir>\" command." t)

;;eshellのキー設定 
(global-set-key "\C-ct" 'eshell-toggle)
(global-set-key "\C-ce" 'eshell-toggle)
(global-set-key "\C-cd" 'eshell-toggle-cd)

;; //使えなくなるので参考にのみ
;(defun my-eshell-prompt () (concat (eshell/pwd) "$ " ))
(defun my-eshell-prompt () (concat (file-name-nondirectory (eshell/pwd)) "$ " )) ; only dir
(setq eshell-prompt-function 'my-eshell-prompt)
(setq eshell-prompt-regexp "^[^#$]*[$#] ")
;; memo:eshell-prompt-regexp : "^[^#$\n]* [#$] "

(defun pcomplete/sudo ()
  "Completion rules for the `sudo' command."
  (let ((pcomplete-help "complete after sudo"))
    (pcomplete-here (pcomplete-here (eshell-complete-commands-list)))))

;; (setq eshell-cmpl-ignore-case t)
;; ;補完時に大文字小文字を区別しない

;; written by Stefan Reichoer <reichoer@web.de>
(defun eshell/less (&rest args)
 "Invoke `view-file' on the file.
\"less +42 foo\" also goes to line 42 in the buffer."
 (while args
   (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
       (let* ((line (string-to-number (match-string 1 (pop args))))
              (file (pop args)))
         (view-file file)
         (goto-line line))
     (view-file (pop args)))))

;; tramp を使わないようにつぶす
(fmakunbound 'eshell/sudo)

(require 'ansi-color)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
							  eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

;; 2013-09-11 wed 11:24
;; alias
;(add-to-list 'eshell-command-aliases-list (list "ls" "gls -aF --color=auto"))
;(add-to-list 'eshell-command-aliases-list (list "ls" "ls -aF $*"))
(add-to-list 'eshell-command-aliases-list (list "d" "dirs -v"))
(add-to-list 'eshell-command-aliases-list (list "po" "popd $*"))
(add-to-list 'eshell-command-aliases-list (list "pu" "pushd $*"))

(add-to-list 'eshell-command-aliases-list (list "f" "find-file $1"))

;; eshell-prompt
(setq eshell-prompt-function
      '(lambda ()
		 (concat "(" user-login-name "@" (system-name) ")-(" (eshell/pwd) ")\n -> ")))
(setq eshell-prompt-regexp "^ -> ")
;;(setq eshell-prompt-regexp "^[^#$\n]+@[^#$\n]+\)\-\([^#$\n])\n -> ")

;; sample
;;(setq eshell-prompt-regexp "^[^#$\n]+@[^#$\n]+:[^#$\n]+ [#$%] ")

