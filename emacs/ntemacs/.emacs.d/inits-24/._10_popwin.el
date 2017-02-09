;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-position 'bottom)

(push '("*Completions*" :height 0.4) popwin:special-display-config)
(push '("*compilation*" :height 0.4 :noselect t :stick t) popwin:special-display-config)

;; anything
;;(push '("*anything*") popwin:special-display-config)
(push '("anything" :regexp t :height 0.5) popwin:special-display-config)
