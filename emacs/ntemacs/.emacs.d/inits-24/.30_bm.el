;; -*- emacs-list -*-
;; @@ bm Visual Bookmark
;; Time-stamp: <2011-08-04 12:00:30 masuda>

;; bm.el
;; 10.11.01(mon)-23:25
(setq-default bm-buffer-persistence t)
(setq bm-restore-repository-on-load t)
(require 'bm)
(require 'bm-ext)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)

;; セーブファイル名の設定
;;(setq bm-repository-file "~/.emacs.d/.bm-repository")

;; fringe部分をクリックしてbookmark
;;(global-set-key (kbd "<left-fringe> <mouse-1>")
;;				#'(lambda(event)
;;					(interactive "e")
;;					(save-excursion
;;					  (mouse-set-point event)
;;					  (bm-toggle))))

;(setq bm-highlight-style 'bm-highlight-line-and-fringe) ; line and fringe
(setq bm-highlight-style 'bm-highlight-only-fringe) ; only fringe
(setq bm-annotate-on-create t)
(global-set-key (kbd "C-@") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)
;(define-key my-key-map ">" 'bm-next)
;(define-key my-key-map "<" 'bm-previous)

;; Saving the repository to file when on exit
;; kill-buffer-hook is not called when emacs is killed, so we
;; must save all bookmarks first
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))