;; -*- emacs-list -*-
;; @@ OTHERS
;; Time-stamp: <2013-12-12 12:12 akira.masuda>

;; M-x occurのように正規表現にマッチする行を表示
(require 'all-ext)

;; 1-1 改行時オートインデント設定
(setq indent-line-function 'indent-relative-maybe)
(global-set-key "\C-m" 'newline-and-indent); Returnキーで改行＋オートインデント
(global-set-key "\C-m" 'indent-new-comment-line); Returnキーで改行＋オートインデント＋コメント行


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
