;; -*- emacs-lisp -*-
;; @ helm.el
;; Time-stamp: <2015-02-24 17:50 akira.masuda>

;; dired が重いのを回避
(require 'helm)
(require 'helm-mode)
(defadvice helm-mode (around avoid-read-file-name activate)
  (let ((read-file-name-function read-file-name-function)
        (completing-read-function completing-read-function))
    ad-do-it))
(setq completing-read-function 'my-helm-completing-read-default)
(defun my-helm-completing-read-default (&rest _)
  (apply (cond ;; [2014-08-11 Mon]helm版のread-file-nameは重いからいらない
          ((eq (nth 1 _) 'read-file-name-internal)
           'completing-read-default)
          (t
           'helm--completing-read-default))
         _))

(require 'helm-config)
;;(require 'helm-ag)
(require 'helm-descbinds)

(helm-mode 1)
(helm-descbinds-mode)

;;(helm-autoresize-mode 1)

(global-set-key (kbd "C-/") 'helm-for-files)
;;(global-set-key (kbd "C-;") 'helm-mini)
;;(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-r") 'helm-recentf)

(global-set-key (kbd "C-c b") 'helm-descbinds)
(global-set-key (kbd "C-c o") 'helm-occur)
(global-set-key (kbd "C-c s") 'helm-ag)
(global-set-key (kbd "C-c y") 'helm-show-kill-ring)

;;(define-key global-map (kbd "C-c i")   'helm-imenu)
;;(define-key global-map (kbd "C-x b")   'helm-buffers-list)
;;
(custom-set-variables '(helm-command-prefix-key "C-;"))

;;
(defadvice helm-buffers-sort-transformer (around ignore activate)
  (setq ad-return-value (ad-get-arg 0)))

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;; http://fukuyama.co/nonexpansion
;; 自動補完を無効にする
(setq helm-ff-auto-update-initial-value nil)

;; TAB で補完する
(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)

(setq helm-idle-delay 0.2)
;; 文字列を入力してから検索するまでのタイムラグを設定する（デフォルトは 0.01）
(setq helm-input-idle-delay 0.2)

;; helm-delete-minibuffer-contents-from-point（ミニバッファで C-k 入力時にカーソル以降を
;; 削除する)を設定すると、pattern 文字入力後に action が表示されない症状が出ることの対策
(defadvice helm-select-action (around ad-helm-select-action activate)
  (let ((helm-delete-minibuffer-contents-from-point nil))
    ad-do-it))

;; helm と elscreen を一緒に使う際に helm の helm-follow-mode を使うと、カーソル制御が
;; おかしくなることの対策
(defadvice helm (around ad-helm-for-elscreen activate)
  (let ((elscreen-screen-update-hook nil))
	ad-do-it))

;;
;; [Display not ready] 表示対策
(defun my/helm-exit-minibuffer ()
  (interactive)
  (helm-exit-minibuffer))

(eval-after-load "helm"
  '(progn
     (define-key helm-map (kbd "<RET>") 'my/helm-exit-minibuffer)))

