;; -*- emacs-list -*-
;; @@ OTHERS
;; Time-stamp: <2013-12-12 12:12 akira.masuda>

;; M-x occur�̂悤�ɐ��K�\���Ƀ}�b�`����s��\��
(require 'all-ext)

;; 1-1 ���s���I�[�g�C���f���g�ݒ�
(setq indent-line-function 'indent-relative-maybe)
(global-set-key "\C-m" 'newline-and-indent); Return�L�[�ŉ��s�{�I�[�g�C���f���g
(global-set-key "\C-m" 'indent-new-comment-line); Return�L�[�ŉ��s�{�I�[�g�C���f���g�{�R�����g�s


;; 2013-09-18 wed 10:52
;;
;; use only one desktop
;; (setq desktop-path '("~/.emacs.d/"))
;; (setq desktop-dirname "~/.emacs.d/")
;; (setq desktop-base-file-name "emacs-desktop")
;; (setq desktop-globals-to-save '(extended-command-history))
;; (setq desktop-files-not-to-save "")
;; 
;; (require 'desktop)
;; (desktop-save-mode 1)
;; (defun my-desktop-save ()
;;   (interactive)
;;   ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
;;   (if (eq (desktop-owner) (emacs-pid))
;; 	  (desktop-save desktop-dirname)))
;; (add-hook 'auto-save-hook 'my-desktop-save)


;; ;; color-theme.el
;; (when (require 'color-theme)
;;   (color-theme-initialize)
;; ;; color-theme-solarized.el
;;   (when (require 'color-theme-solarized)
;;     (color-theme-solarized-dark)))
