(require 'org-toodledo)
(setq org-toodledo-userid "td4ae92a5ac2537 ") ;; emailじゃなく，ToodledoのSettingsから見られる「Unique ID」を記述
(setq org-toodledo-password "sher88Lock")

;; Useful key bindings for org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (local-unset-key "\C-o")
            (local-set-key "\C-od" 'org-toodledo-mark-task-deleted)
            (local-set-key "\C-os" 'org-toodledo-sync)))
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (local-unset-key "\C-o")
            (local-set-key "\C-od" 'org-toodledo-agenda-mark-task-deleted)))
