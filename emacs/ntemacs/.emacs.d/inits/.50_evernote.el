;; -*- emacs-list -*-
;; @@ Evernote
;; Time-stamp: <2015-02-05 14:32 akira.masuda>

;;(require 'evernote-mode)
;;(global-set-key "\C-cec" 'evernote-create-note)
;;(global-set-key "\C-ceo" 'evernote-open-note)
;;(global-set-key "\C-ces" 'evernote-search-notes)
;;(global-set-key "\C-ceS" 'evernote-do-saved-search)
;;(global-set-key "\C-cew" 'evernote-write-note)

;;(setq evernote-ruby-command "/usr/bin/ruby")

;; Emacsにコマンドの位置を認識させて使えるようにする
;;(dolist (dir (list
;;              "/sbin"
;;              "/bin"
;;              "/usr/sbin"
;;              "/usr/bin"
;;              "/usr/local/bin"
;;              ;; rubyの場所を直接指定
;;              ;;(expand-file-name "~/.rbenv/versions/1.9.2-p320/bin")
;;              ;; もしくは
;;              ;; (expand-file-name "~/.rbenv/shims")
;;              ))
;;  (when (and (file-exists-p dir) (not (member dir exec-path)))
;;    (setenv "PATH" (concat dir ":" (getenv "PATH")))
;;    (setq exec-path (append (list dir) exec-path))))

(require 'evernote-mode)
;; 新規ノート作成。タグ、タイトルなどを入力
(global-set-key (kbd "C-c e c") 'evernote-create-note)
;; タグを選択してノートを開く
(global-set-key (kbd "C-c e o") 'evernote-open-note)
;; 検索ワードを入力して、Note:と表示されたらTabで一覧が表示される
(global-set-key (kbd "C-c e s") 'evernote-search-notes)
;; evernote-create-searchで保存された検索ワードで検索
(global-set-key (kbd "C-c e S") 'evernote-do-saved-search)
;; 現在のバッファをEvernoteに記録
(global-set-key (kbd "C-c e w") 'evernote-write-note)
;; 選択範囲をEvernoteに記録
(global-set-key (kbd "C-c e p") 'evernote-post-region)
;; Evernote閲覧用ブラウザを起動
(global-set-key (kbd "C-c e b") 'evernote-browser)
;; 既存のノートに編集を加える
(global-set-key (kbd "C-c e e") 'evernote-change-edit-mode)


;; ユーザー名入力を省略できる。自身のアカウント名を設定
(setq evernote-username "kuraku")
;; 毎回長いパスワードは面倒なので、最初にインストールしたgpgで管理
;(setq evernote-password-cache t)
;; gpgファイルの保存先と名前を変更
;(setq enh-password-cache-file "~/.emacs.d/evernote-mode.gpg")

;;
;;(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; optional

;;developer tokens
(setq evernote-developer-token "S=s5:U=9f2ec:E=152afe29199:C=14b58316498:P=1cd:A=en-devtoken:V=2:H=03d9957502d5741ea09cce897dd9ea54")
;;NoteStore URL: https://www.evernote.com/shard/s5/notestore
;;Expires: 04 February 2016, 21:23
