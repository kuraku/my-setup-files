;;-----------------------------------------------------------------
;; psvn.el
;;-----------------------------------------------------------------
;; (require 'psvn)
;; 
;; (setq svn-status-verbose nil)
;; (setq svn-status-hide-unmodified t)
;; ;; ログにファイル名を出さない
;; ;; (setq svn-status-default-log-arguments nil)
;; ;; プレフィクスをC-x sにする
;; ;; (global-set-key (kbd "C-x s") svn-global-keymap

(define-key svn-status-mode-map "q" 'egg-self-insert-command)
(define-key svn-status-mode-map "Q" 'svn-status-bury-buffer)
(define-key svn-status-mode-map "p" 'svn-status-previous-line)
(define-key svn-status-mode-map "n" 'svn-status-next-line)
(define-key svn-status-mode-map "<" 'svn-status-examine-parent)

(add-hook 'dired-mode-hook
          '(lambda ()
             (require 'dired-x)
             ;;(define-key dired-mode-map "V" 'cvs-examine)
             (define-key dired-mode-map "V" 'svn-status)
             (turn-on-font-lock)
             ))

(setq svn-status-hide-unmodified t)

(setq process-coding-system-alist
      (cons '("svn" . euc-jp) process-coding-system-alist))


;; dsvn.el
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)


;; Tortoise-SVN
;;(require 'tortoise-svn)
;;(add-to-list 'exec-path "C:/Program Files/TortoiseSVN/bin/")


(require 'vc-svn17)
