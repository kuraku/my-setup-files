;; -*- emacs-lisp -*-
;; @@ org-mode
;; Time-stamp: <2015-02-05 18:13 akira.masuda>

;; C-c C-q tag
;; C-c C-t TODO/DONE
;; C-c C-c checkbox [ ]
;; C-c l link -> C-c C-l open: C-c C-o
;; C-c . date / C-u C-c . date-time
;; S-up, S-down increment num

;; @ org-mode
;; 08.04.22(tue)-14:04
(add-to-list 'auto-mode-alist '("\\.\\(org\\|txt\\)$" . org-mode))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; skk 併用が×？
;;(add-hook 'org-mode-hook 
;;		  '(lambda ()
;;             (local-set-key (kbd "C-m") 'org-return-indent)))

(require 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
;;(setq org-startup-folded nil) ;;オープン時開いてる
(setq org-startup-folded "showall")
;;(org-remember-insinuate) ;;

(setq org-directory "~/.emacs.d/org/")
(setq org-default-notes-file (concat org-directory "refile.org")) ;;default note

;;(setq org-agenda-files (list org-directory))
(setq org-agenda-files (quote ("~/.emacs.d/org/refile.org"
							   ;;"~/.emacs.d/org/inbox.org"
							   "~/.emacs.d/org/todo.org"
							   "~/.emacs.d/org/note.org")))

;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))

;; remember
(require 'remember)
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(setq org-remember-templates
	  '(("Todo" ?t "** TODO %?  :TODO:\n   %a\n   %T" nil "ToDo")
		("Idea" ?i "** %?  :IDEA:\n  %a\n   %T" nil "New Ideas")
		("Note" ?n "** %?  :NOTE:\n  %a\n   %T" nil "Note")
		))

;; orgmemo
(provide 'orgmemo)
(require 'orgmemo)

(setq orgmemo-file "~/.emacs.d/org/inbox.org")	   ;編集ファイル名
(setq orgmemo-date-format "* %Y-%m-%d" ) ;日付の表示

(setq glz-file "~/.emacs.d/org/glz.org")	   ;GrooveLineZ

(defun orgmemo()
  (interactive)
  (org-open orgmemo-file))
;; inits/90_keybind
;;(if (fboundp 'orgmemo)
;;	(define-key my-key-map "N" 'orgmemo))

(defun glz-org()
  (interactive)
  (org-open glz-file))

;; メモを追加
(defun org-open(file-name)
  (interactive)
  (find-file file-name)
  (goto-line 1)
  (beginning-of-line)
  (if (looking-at (format-time-string  orgmemo-date-format))
	  (orgmemo-add-item)
	(orgmemo-new-item))
  (auto-fill-mode -1) )

(defun orgmemo-new-item()
  (interactive)
  (org-overview)

  (goto-line 1)
  (org-cycle)
  (beginning-of-line)
  (insert "\n")

  (goto-line 1)
  (beginning-of-line)
  (insert (format-time-string  orgmemo-date-format))
  (insert "\n** ")
  (goto-line 2)
  (end-of-line))

(defun orgmemo-add-item()
  (interactive)
  (org-overview)
  (goto-line 1)

  (org-cycle)
  (end-of-line)
  (insert "\n** ")
  (goto-line 2)
  (end-of-line))

; Use IDO for target completion
(setq org-completion-use-ido t)

; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))

; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))

; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)

(add-hook 'org-mode-hook
          (lambda ()
            (set (make-local-variable 'system-time-locale) "C")))

;;(setq org-indent-mode t)
;;(org-return-indent)

;; for mobileorg
(setq org-mobile-directory "~/org-mobile")
(setq org-mobile-inbox-for-pull "~/org-mobile/index.org") ;pullしたデータの置き場
(setq org-agenda-files (list "index.org" "mobileorg.org"
                             "todo.org")) ;転送するファイル
										;
(setq my-org-pull-from-server-command "sh /home/bin/org-download.sh")
(setq my-org-push-to-server-command "sh /home/bin/org-upload.sh")

;;upload
(defun ma:org-mobile-pull ()
  (interactive)
  (if (=   (shell-command my-org-pull-from-server-command) 0)
	  (progn (kill-buffer "*Shell Command Output*")
			 (delete-other-windows))))
;;download
(defun ma:org-mobile-push ()
  (interactive)
  (if (=   (shell-command my-org-push-to-server-command) 0)
      (progn (kill-buffer "*Shell Command Output*")
             (delete-other-windows))))

(defadvice org-mobile-pull (before org-mobile-download activate)
  (if (=   (shell-command my-org-pull-from-server-command) 0)
    (progn (kill-buffer "*Shell Command Output*")
           (delete-other-windows)))
  )
(defadvice org-mobile-push (after org-mobile-upload activate)
  (if (=   (shell-command my-org-push-to-server-command) 0)
      (progn (kill-buffer "*Shell Command Output*")
             (delete-other-windows))))

;;; orgmemo.el ends here
