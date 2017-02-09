;; -*- emacs-lisp -*-
;; @ anything.el
;; Time-stamp: <2011-05-31 11:29:25 masuda>

(require 'anything-startup)
;;(require 'anything-config)
(require 'recentf)
;;(require 'anything-etags)
;;(require 'anything-grep)
;;(require 'anything-ipa)
(recentf-mode 1)
(global-set-key "\C-x\C-a" 'anything)
(global-set-key [?\C-/] 'anything)
;;(global-set-key [f12] 'anything)
(define-key anything-map "\en" 'anything-next-source)
(define-key anything-map "\ep" 'anything-previous-source)
;;(anything-iswitchb-setup)

;; http://dev.ariel-networks.com/Members/matsuyama/open-anything-emacs
(defadvice anything-check-minibuffer-input (around sit-for activate)
  (if (sit-for anything-idle-delay t)
	  ad-do-it))

;; 10.10.12(tue)-18:44
(require 'recentf-ext)

;; anything Occur
(defvar anything-c-source-occur
  '((name . "Occur")
	(init . (lambda ()
			  (setq anything-c-source-occur-current-buffer
					(current-buffer))))
	(candidates . (lambda ()
					(setq anything-occur-buf (get-buffer-create "*Anything Occur*"))
					(with-current-buffer anything-occur-buf
					  (erase-buffer)
					  (let ((count (occur-engine anything-pattern
												 (list anything-c-source-occur-current-buffer) anything-occur-buf
												 list-matching-lines-default-context-lines nil
												 list-matching-lines-buffer-name-face
												 nil list-matching-lines-face
												 (not (eq occur-excluded-properties t)))))
						(when (> count 0)
						  (let ((lines (split-string (buffer-string) "\n" t)))
							(cdr lines)))))))
	(action . (("Goto line" . (lambda (candidate)
								(goto-line (string-to-number candidate) anything-c-source-occur-current-buffer)))))
	(requires-pattern . 3)
	(volatile)))

;; Register
(defvar anything-c-source-register
  '((name . "Registers")
	(candidates . anything-c-registers)
	(action ("insert" . insert))))
;; based on list-register.el
(defun anything-c-registers ()
  (loop for (char . val) in register-alist
		collect
		(let ((key (single-key-description char))
			  (string (cond
					   ((numberp val)
						(int-to-string val))
					   ((markerp val)
						(let ((buf (marker-buffer val)))
						  (if (null buf)
							  "a marker in no buffer"
							(concat
							 "a buffer position:"
							 (buffer-name buf)
							 ", position "
							 (int-to-string (marker-position val))))))
					   ((and (consp val) (window-configuration-p (car val)))
						"conf:a window configuration.")
					   ((and (consp val) (frame-configuration-p (car val)))
						"conf:a frame configuration.")
					   ((and (consp val) (eq (car val) 'file))
						(concat "file:"
								(prin1-to-string (cdr val))
								"."))
					   ((and (consp val) (eq (car val) 'file-query))
						(concat "file:a file-query reference: file "
								(car (cdr val))
								", position "
								(int-to-string (car (cdr (cdr val))))
								"."))
					   ((consp val)
						(let ((lines (format "%4d" (length val))))
						  (format "%s: %s\n" lines
								  (truncate-string
								   (mapconcat (lambda (y) y) val
											  "^J") (- (window-width) 15)))))
					   ((stringp val)
						val)
					   (t
						"GARBAGE!"))))
		  (cons (format "register %3s: %s" key string) string))))

;; @semantic
;; 08.04.21(mon)-15:52
(defun anything-c-source-semantic-construct-candidates (tags depth)
  (apply 'append 
		 (mapcar '(lambda (tag)
					(when (and (listp tag)
							   (or (equal (semantic-tag-type tag) "class")
								   (eq (semantic-tag-class tag) 'function)))
					  (cons (cons (concat (make-string (* depth 2) ?\s)
										  (semantic-format-tag-summarize tag nil t)) tag)
							(anything-c-source-semantic-construct-candidates (semantic-tag-components tag) (1+ depth)))))
				 tags)))

(defvar anything-c-source-semantic
  '((name . "Semantic Tags")
	(init . (lambda ()
			  (setq anything-c-source-semantic-candidates
					(anything-c-source-semantic-construct-candidates (semantic-fetch-tags) 0))))
	(candidates . (lambda ()
					(mapcar 'car anything-c-source-semantic-candidates)))
	(action . (("Goto tag" . (lambda (candidate)
							   (let ((tag (cdr (assoc candidate anything-c-source-semantic-candidates))))
								 (semantic-go-to-tag tag))))))))

;; bm.el source by Matsuyama
(defvar anything-c-source-bm
  '((name . "Visible Bookmarks")
	(init . (lambda ()
			  (let ((bookmarks (bm-lists)))
				(setq anything-bm-marks
					  (delq nil
							(mapcar (lambda (bm)
									  (let ((start (overlay-start bm))
											(end (overlay-end bm)))
										(if (< (- end start) 2)
											nil
										  (format "%7d: %s"
												  (line-number-at-pos start)
												  (buffer-substring start (1- end))))))
									(append (car bookmarks) (cdr bookmarks))))))))
	(candidates . (lambda ()
					anything-bm-marks))
	(action . (("Goto line" . (lambda (candidate)
								(goto-line (string-to-number candidate))))))))

;; 10.11.05(fri)-11:22
;; bm-repositoryに保存されてる全バッファ，ファイルを対象にブックマークにジャンプ
;; via http://d.hatena.ne.jp/peccu/20100402/bmglobal
(defvar anything-c-source-bm-global-use-candidates-in-buffer
  '((name . "Global Bookmarks")
    (init . anything-c-bm-global-init)
    (candidates-in-buffer)
    (type . file-line))
  "show global bookmarks list.
Global means All bookmarks exist in `bm-repository'.

Needs bm.el.
http://www.nongnu.org/bm/")
;; (anything 'anything-c-source-bm-global-use-candidates-in-buffer)
(defvaralias 'anything-c-source-bm-global 'anything-c-source-bm-global-use-candidates-in-buffer)
;; (anything 'anything-c-source-bm-global)

(defun anything-c-bm-global-init ()
  "Init function for `anything-c-source-bm-global'."
  (when (require 'bm nil t)
    (with-no-warnings
      (let ((files bm-repository)
            (buf (anything-candidate-buffer 'global)))
        (dolist (file files)            ;ブックマークされてるファイルリストから，1つ取り出す
          (dolist (bookmark (cdr (assoc 'bookmarks (cdr file)))) ;1つのファイルに対して複数のブックマークがあるので
            (let ((position (cdr (assoc 'position bookmark))) ;position
                  (annotation (cdr (assoc 'annotation bookmark))) ;annotation
                  (file (car file))                               ;file名を取り出す
                  line
                  str)
              (setq str (with-current-buffer (find-file-noselect file) ;anything用の文字列にformat
                               (goto-char position)
                               (beginning-of-line)
                               (unless annotation
                                   (setq annotation ""))
                               (if (string= "" line)
                                   (setq line  "<EMPTY LINE>")
                                 (setq line (car (split-string (thing-at-point 'line) "[\n\r]"))))
                               (format "%s:%d: [%s]: %s\n" file (line-number-at-pos) annotation line)))
              (with-current-buffer buf (insert str)))))))))

;; anything sources set
(setq anything-sources
	  (list
	   anything-c-source-buffers+
	   anything-c-source-recentf
	   anything-c-source-file-name-history
	   anything-c-source-emacs-commands
	   anything-c-source-buffer-not-found
	   anything-c-source-occur
	   ;anything-c-source-register ;実際使わず
	   anything-c-source-bookmarks
	   ;;anything-c-source-google-suggest
	   ;;anything-c-source-file-cache
	   ;;anything-c-source-man-pages
	   anything-c-source-info-pages
	   ;;anything-c-source-locate ;winで使えず
	   anything-c-source-semantic ;機能してない?
	   ;;anything-c-source-ipa ;bmを使う
	   ;;anything-c-source-bm ;-globalを使う
	   anything-c-source-bm-global
	   ;;anything-c-source-etags-select
	   ;;anything-c-source-calculation-result
	   anything-c-source-w3m-bookmarks
	   anything-c-source-kill-ring
	   ))

(setq anything-etags-enable-tag-file-dir-cache t)
(setq anything-etags-cache-tag-file-dir "~/.emacs.d/etags/")

(eval-after-load "anything"
  '(progn
	 (set-face-bold-p 'anything-header t)
	 (set-face-foreground 'anything-header "white")
	 (set-face-background 'anything-header "DarkSeaGreen4")
	 (set-face-foreground 'anything-isearch-match "white")
	 (set-face-background 'anything-isearch-match "IndianRed")

	 (set-face-bold-p 'anything-dir-heading nil)
	 (set-face-foreground 'anything-dir-heading "DodgerBlue")
	 (set-face-background 'anything-dir-heading nil)

	 (set-face-bold-p 'anything-dir-priv nil)
	 (set-face-foreground 'anything-dir-priv "DodgerBlue")
	 (set-face-background 'anything-dir-priv nil) ))

;; select alphabet
;;(setq anything-enable-shortcuts 'alphabet)

;; 10.10.21(thu)-10:49
(require 'descbinds-anything)
(descbinds-anything-install)

;; 10.11.05(fri)-14:14
(require 'anything-c-moccur)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
(global-set-key (kbd "C-x C-/") 'anything-call-source)

;;(custom-set-variables '(anything-command-map-prefix-key (kbd "C-c C-/")))
;;?? 変わらず

;;(setq anything-command-map-prefix-key "C-c C-/")

;; 11.04.06(wed)-11:39
;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
(setq moccur-split-word t)
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする


;; 11.03.01(tue)-10:30
(require 'anything-esh)

;; 11.04.06(wed)-11:25
;; dired から dir-moccur
;;(add-hook 'dired-mode-hook ;dired
;;          '(lambda ()
;;             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))

;; 11.04.19(tue)-17:47
(require 'anything-org-mode)
(setq org-agenda-files '("c:/home/.emacs.d/org/index.org"))

;; END anythin setup
