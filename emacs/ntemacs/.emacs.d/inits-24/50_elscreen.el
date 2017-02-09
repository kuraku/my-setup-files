;; -*- emacs-list -*-
;; @@ ElScreen
;; Time-stamp: <2015-02-04 11:25 akira.masuda>

(if (and is_emacs24 is_window-sys)
	(progn

;; @@ ELScreen
(when (>= emacs-major-version 24)
	  (elscreen-start))
;;(load "elscreen" "ElScreen" t)
;;(load "elscreen-speedbar" t)
;;(load "elscreen-dired" t)

(elscreen-set-prefix-key "\C-t")
(setq elscreen-display-tab nil) ;; tab 表示
;;(setq elscreen-display-tab 8) ; タブの幅（６以上じゃないとダメ）
(setq elscreen-tab-display-create-screen nil) ;;[!] create ボタン非表示
(setq elscreen-tab-display-control nil) ;;[<->] control ボタン非表示
(setq elscreen-tab-display-kill-screen nil) ;;[X] ボタン非表示
;;(setq elscreen-tab-width 10) ;; tabサイズ newVer では廃止
(define-key elscreen-map  "d" 'elscreen-kill)
(define-key elscreen-map  "\C-d" 'elscreen-kill)
(define-key elscreen-map  "o" 'elscreen-toggle)
(define-key elscreen-map  "\C-o" 'elscreen-toggle)
(define-key elscreen-map  "l" 'elscreen-select-and-goto)
(define-key elscreen-map  "\C-l" 'elscreen-select-and-goto)
;; tab color
(set-face-background 'elscreen-tab-other-screen-face "Gray30")
(set-face-foreground 'elscreen-tab-other-screen-face "Gray85")
(set-face-background 'elscreen-tab-current-screen-face "Gray90")

;; Elscreen タブをやめ、タイトルに表示
(defun elscreen-frame-title-update-old ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
		   (screen-to-name-alist (elscreen-get-screen-to-name-alist))
		   (title (mapconcat
				   (lambda (screen)
					 (format "[%d]%s%s"
							 screen (elscreen-status-label screen)
							 (assoc-default screen screen-to-name-alist)))
				   screen-list " ")))
      (if (fboundp 'set-frame-name)
		  (set-frame-name title)
		(setq frame-title-format title)))))

(eval-after-load "elscreen"
  '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))

;; タイトルも個々をカットするようにした、キタないが
(defun elscreen-frame-title-update ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
		   (screen-to-name-alist (elscreen-get-screen-to-name-alist))
		   (eltitle-len (+ 16 2))
		   etitle
		   (title (mapconcat
				   (lambda (screen)
					 (setq etitle
						   (format "%d%s%s"
								   screen (elscreen-status-label screen)
								   (assoc-default screen screen-to-name-alist)))
					 (setq etitle (if (> (length etitle) eltitle-len)
						 (concat (substring etitle 0 eltitle-len)  "..")
					   etitle) )
					 (setq etitle (if (string= (elscreen-status-label screen) "+")
									  (format "<<%s>>" etitle) etitle))
					 etitle)
				   screen-list "   ")))
      (if (fboundp 'set-frame-name)
		  (set-frame-name title)
		(setq frame-title-format title)))))

;; 10.12.02(thu)-12:19
;; twmode
;; (setq elscreen-twmode-mode-to-nickname-alist
;;   '(("^kukraku/" .
;; 	 (lambda ()
;; 	   (format "tw:%s" (substring buf (length "kuraku/") (buffer-name (current-buffer)))))))
;; ;;  :type '(alist :key-type string :value-type (choice string function))
;; ;;  :tag "twmode major-mode to screen nickname alist"
;; ;;  :set (lambda (symbol value)
;; ;;         (custom-set-default symbol value)
;; ;;         (elscreen-rebuild-mode-to-nickname-alist))
;; ;;  :group 'twmode)
;; )
;; (elscreen-set-buffer-to-nickname-alist 'elscreen-twmode-mode-to-nickname-alist)
;; よくわからん

;; other tab name
;; shellタブが分かり難いのでツブす
(setq my-els-nickname-alist
      '(("[Ss]hell" . (lambda () (format "%s" (buffer-name (current-buffer)))))))
(elscreen-set-buffer-to-nickname-alist 'my-els-nickname-alist)

))
