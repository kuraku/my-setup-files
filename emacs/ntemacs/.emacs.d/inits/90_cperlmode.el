;; Perlópê›íË
(require 'set-perl5lib)

(autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq auto-mode-alist
	  (append '(("\\.\\([pP][Llm]\\|al\\|psgi\\)$" . cperl-mode))  auto-mode-alist ))

(eval-after-load "cperl-mode"
  '(progn

	 (set-face-bold-p 'cperl-array-face nil)
	 (set-face-background 'cperl-array-face nil)
	 (set-face-bold-p 'cperl-hash-face nil)
	 (set-face-background 'cperl-hash-face nil)
	 
	 (setq cperl-indent-level 4
		   cperl-continued-statement-offset 4
		   cperl-close-paren-offset -4
		   cperl-label-offset -4
		   cperl-comment-column 40
		   cperl-highlight-variables-indiscriminately t
		   cperl-indent-parens-as-block t
		   cperl-tab-always-indent nil
		   cperl-font-lock t)
	 ))

;; 2013-11-26 tue 18:46 èdÇ¢ÇÃÇ≈ÇÕÇ∏Ç∑
;;(add-hook 'cperl-mode-hook
;;		  '(lambda ()
;;			 (require 'perl-completion)
;;			 (add-to-list 'ac-sources 'ac-source-perl-completion)
;;			 (perl-completion-mode t)
;;			 ;
;;			 (local-set-key "\C-c\C-d" 'cperl-perldoc-at-point)
;;			 (flymake-perl-load)
;;			 (setq indent-tabs-mode nil) ))

;;(add-hook 'cperl-mode-hook 'flymake-perl-load)


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

;;(add-hook 'cperl-mode-hook 'flymake-perl-load)

;;(define-key my-key-map "f" 'flymake-mode)

;; ;;; For Flymake PHP
;; (require 'flymake-php)
