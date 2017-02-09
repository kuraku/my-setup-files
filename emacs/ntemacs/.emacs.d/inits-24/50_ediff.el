;; -*- emacs-list -*-
;; @@ Ediff
;; Time-stamp: <2011-06-10 19:59:15 masuda>
(defun ediff-face-settings ()
  "Face settings for `ediff'."

  (custom-set-faces '(ediff-current-diff-A
					  ((t :background "DarkSeaGreen4" :foreground "white"))))
  (custom-set-faces '(ediff-current-diff-B
					  ((t :background "DodgerBlue1" :foreground "white"))))

  (custom-set-faces '(ediff-fine-diff-A
					  ((t :background "gold4" :foreground "white"))))
  (custom-set-faces '(ediff-fine-diff-B
					  ((t :background "chocolate2" :foreground "white"))))

  ;; フォーカスされない修正箇所 奇数行偶数行
  (custom-set-faces '(ediff-even-diff-A
					  ((t :background "grey30" :foreground "white"))))
  (custom-set-faces '(ediff-even-diff-B
					  ((t :background "grey30" :foreground "white"))))
  (custom-set-faces '(ediff-odd-diff-A
					  ((t :background "grey30" :foreground "white"))))
  (custom-set-faces '(ediff-odd-diff-B
					  ((t :background "grey30" :foreground "white"))))
  )

(eval-after-load "ediff"
  `(ediff-face-settings))

(provide 'ediff-face-settings)