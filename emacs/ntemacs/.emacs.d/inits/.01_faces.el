;;; @@ make my face
;;;
; (make-face 'my-01-face)
; ;(set-face-foreground 'my-01-face "brown")
; (set-face-foreground 'my-01-face "tomato")
; (set-face-background 'my-01-face nil)
; (set-face-bold-p 'my-01-face t)
; (set-face-italic-p 'my-01-face nil)
; (setq font-lock-my-01-face 'my-01-face)

(defface my-01-face '((t (:foreground "tomato" :underline t :bold t))) nil)
(defvar my-01-face 'my-01-face)
(defvar font-lock-my-01-face 'my-01-face)

;
(defface my-100-face '((t (:foreground "tomato" :background "white"))) nil)
(defvar my-100-face 'my-100-face)

;;
(make-face 'my-02-face)
;(set-face-foreground 'my-02-face "cyan4")
(set-face-foreground 'my-02-face "lightsteelblue")
(set-face-bold-p 'my-02-face t)
(setq font-lock-my-02-face 'my-02-face)
;;
(make-face 'my-03-face)
(set-face-foreground 'my-03-face "black")
(set-face-background 'my-03-face "lightcyan1")
(setq font-lock-my-03-face 'my-03-face)
;;
(make-face 'my-04-face)
(set-face-foreground 'my-04-face "black")
(set-face-background 'my-04-face "gray90")
(set-face-bold-p 'my-04-face t)
(setq font-lock-my-04-face 'my-04-face)
;;
(make-face 'my-05-face)
(set-face-foreground 'my-05-face "cyan4")
(setq font-lock-my-05-face 'my-05-face)
;;
(make-face 'my-06-face)
(set-face-foreground 'my-06-face "gray65")
(setq font-lock-my-06-face 'my-06-face)
;;
(make-face 'my-07-face)
(set-face-foreground 'my-07-face "orange")
;(set-face-foreground 'my-07-face "hotpink3")
;(set-face-foreground 'my-07-face "green4")
(setq font-lock-my-07-face 'my-07-face)
;;
(make-face 'my-08-face)
(set-face-foreground 'my-08-face "springgreen")
(setq font-lock-my-08-face 'my-08-face)
;;
(make-face 'my-09-face)
(set-face-foreground 'my-09-face "lightsteelblue")
(setq font-lock-my-09-face 'my-09-face)
;;
(make-face 'my-10-face)
(set-face-foreground 'my-10-face "yellow")
(setq font-lock-my-10-face 'my-10-face)
;;
(make-face 'my-11-face)
(set-face-foreground 'my-11-face "tomato")
(setq font-lock-my-11-face 'my-11-face)
;;
(make-face 'my-12-face)
(set-face-foreground 'my-12-face "springgreen")
(set-face-bold-p 'my-12-face t)
(setq font-lock-my-12-face 'my-12-face)
;;
(make-face 'my-13-face)
(set-face-foreground 'my-13-face "red")
;(set-face-bold-p 'my-13-face t)
(setq font-lock-my-13-face 'my-13-face)

;; 03.02.20(Thu)-20:31
(defface my-14-face '((t (:foreground "light goldenrod"))) nil)
(defvar my-14-face 'my-14-face)
(defvar font-lock-my-14-face 'my-14-face)

(defface my-15-face '((t (:foreground "goldenrod1"))) nil)
(defvar my-15-face 'my-15-face)
(defvar font-lock-my-15-face 'my-15-face)

(defface my-16-face '((t (:foreground "SteelBlue1"))) nil)
(defvar my-16-face 'my-16-face)
(defvar font-lock-my-16-face 'my-16-face)

;;
(make-face 'my-bold-face)
(set-face-bold-p 'my-bold-face t)
(setq font-lock-my-bold-face 'my-bold-face)
;;
(make-face 'my-italic-face)
(set-face-italic-p 'my-italic-face t)
(setq font-lock-my-italic-face 'my-italic-face)
;;
;(make-face 'my-underline-face)
;(set-face-underline-p 'my-underline-face t)
;(setq font-lock-my-underline-face 'my-underline-face)

;10.07.30(fri)-15:47
(defface my-underline-face '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-underline-face 'my-underline-face)

;;
(defface masuda-face 
  '((t (:foreground "springgreen" :background nil :bold t :italic t :underline t))) nil)
(defvar masuda-face 'masuda-face)

;(make-face 'masuda-face)
;(set-face-foreground 'masuda-face "springgreen")
;(set-face-background 'masuda-face nil)
;(set-face-bold-p 'masuda-face t)
;(set-face-italic-p 'masuda-face t)
;(setq font-lock-masuda-face 'masuda-face)

(eval-after-load "yascroll"
  '(progn (set-face-background 'yascroll:thumb-face "gray30")))

;; end of face set
