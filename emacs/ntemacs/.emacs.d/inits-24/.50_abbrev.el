;; @ abbrev

(load "abbrev-complete")

;(setq abbrev-file-name "~/.abbrev_defs")
(define-key esc-map  " " 'expand-abbrev) ;; M-SPC
(quietly-read-abbrev-file)
(setq save-abbrevs 'silently)


(define-abbrev-table
  'emacs-lisp-mode-abbrev-table
  '(
    ("(r"   "require")
    ("r"   "require")
    ("(l"   "(lambda() (interactive)()")
    ))