;; 2013-11-06 wed 13:08
(require 'direx)
;; direx:jump-to-directory(require 'direx)
(require 'direx-project)

(defun m:dired-jump ()
  (interactive)
  (cond
   ((one-window-p)
    (direx:jump-to-directory-other-window))
   (t
    (direx:jump-to-directory))))

;; width‚ÍŠÂ‹«‚É‡‚í‚¹‚Ä’²®‚µ‚Ä‚­‚¾‚³‚¢B
(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)
;;(push '(direx:direx-mode :position left) popwin:special-display-config)

;;(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)
(define-key my-key-map "j" 'm:dired-jump)
(define-key my-key-map "\C-j" 'm:dired-jump)
