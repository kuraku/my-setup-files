;; -*- emacs-lisp -*-
;; @@ ETAGS
;; Time-stamp: <2013-01-15 16:22:36 akira.masuda>
;;
;; M-. に find-tag が割り当てられている.
;;   前置引数を変えると, 前方に検索したり, 後方に検索したりできる.
;; M-. tag <RET>
;;   `tag' で指定した関数定義を探す.
;; C-u M-. (M-0 M-.)
;;   前回検索したタグの次の候補を探す.
;; C-u - M-. (M-- M-.)
;;   前回検索したタグの前の候補を探す.
;; C-M-. pattern <RET>
;;   正規表現でタグを探す.
;;   次のタグを探すときは, find-tag と同様 "C-u M-." を使う.
;; M-*
;;   最後に find-tag を起動した位置に戻る.
;;
;; TAGSファイル切替:M-x visit-tags-table．
;; 検索:M-x tags-search
;; 関数一覧:M-x list-tags

;;(visit-tags-table "~/.emacs.d/etags/TAGS")

(setq etags-dir "~/.emacs.d/etags/")
(setq etags-cmd-dir "~/bin/")

;; 有効に読み込むファイル
(setq tags-table-list
	  '("~/.emacs.d/etags/elisp_TAGS"
		"~/.emacs.d/etags/posren_TAGS"
		;;"~/.emacs.d/etags/gol_TAGS")
	  ))

;; ;; 10.07.15(thu)-18:19 自動で更新
;; (defadvice find-tag (before c-tag-file activate)
;;   "Automatically create tags file."
;;   (let ((tag-file "c:/home/.emacs.d/etags/TAGS")))
;;     (unless (file-exists-p tag-file)
;;       (shell-command "c:/emacs-23/bin/etags.exe *.pl *.pm -o c:/home/.emacs.d/etags/TAGS 2>/dev/null"))
;;     (visit-tags-table tag-file)))

;; 10.07.15(thu)-18:56
;; add TAGS file
;;(defun ma:add-etags-file ()
;;  "add etags file"
;;  (interactive)
;;  (shell-command "etags.exe -a *.pl *.pm -o c:/home/.emacs.d/etags/TAGS"))

;; 10.11.30(tue)-12:20
;; @ ぽすれんシステムの ETAGを作る
;; (defun ma:posren-tags ()
;;   "create TAGS file for posren"
;;   (interactive)
;;   (let* ((buf "*posren-tags*")
;; 		 (msg (format-time-string "----- create etag (%m/%d %H:%M:%S) -----\n" (current-time)))
;; 		 (cmd "c:/home/bin/posren_etags.bat"))
;; 	(with-current-buffer (get-buffer-create buf)
;; 	  (setq buffer-read-only nil)
;; 	  (display-buffer (current-buffer))
;; 	  (end-of-buffer)
;; 	  (insert msg)
;; 	  (start-process "get-tags" buf cmd)
;; 	  (setq buffer-read-only t))))

;; 10.11.30(tue)-12:20
;; @ ぽすれんシステムの ETAGを作る
(defun ma:create-etags (cmd-name)
  "create TAGS file for posren"
  (let* ((buf "*posren-tags*")
		 (cmd (concat etags-cmd-dir cmd-name))
		 (msg (format "%s ----- create etag (%s)-----\n" cmd-name
					  (format-time-string "%m/%d %H:%M:%S" (current-time)))))
	(with-current-buffer (get-buffer-create buf)
	  (setq buffer-read-only nil)
	  (display-buffer (current-buffer))
	  (end-of-buffer)
	  (insert msg)
	  (start-process "get-tags" buf cmd)
	  (setq buffer-read-only t))))

;; 11.04.15(fri)
;; create etags/elisp_TAGS
(defun ma:create-elisp-etags ()
  (interactive)
  (ma:create-etags "elisp_etags.bat"))

;; 11.04.15(fri)-11:53
;; create etags/posren_TAGS
(defun ma:create-posren-etags ()
  (interactive)
  (ma:create-etags "posren_etags_42svn.bat"))
;;  (ma:create-etags "posren_etags_37cvs.bat"))
;;  (ma:create-etags "posren_etags_36cvs-2.bat"))
;;  (ma:create-etags "posren_etags_36cvs.bat"))
;;  (ma:create-etags "posren_etags.bat"))

;; 11.04.15(fri)-11:53
;; create etags/posren_TAGS
(defun ma:create-posren-local-etags ()
  (interactive)
  (ma:create-etags "posren_etags_local.bat"))

;; 11.04.15(fri)-11:53
;; create etags/gol_TAGS
(defun ma:create-gol-etags ()
  (interactive)
  (ma:create-etags "posren_gol_new.bat"))
