;; -*- emacs-list -*-
;; @@ Twittering-mode
;; Time-stamp: <2017-01-06 10:05 akira.masuda>

;; C-c C-f friends TL :friends は :home と同じというか古い
;; C-c C-u 自分のTL
;; C-c C-r 自分あてのreply
;; C-c C-d 自分あてのdirect
;; C-c C-q 検索

;; j, k 前後tweetへ
;; n, p そのユーザのtweetへ
;; H, G 最初、最後へ
;; g リフレッシュ

;; @ Twittering-mode
(require 'twittering-mode)
;(setq twittering-auth-method 'xauth)

;; 2016-10-17 mon 17:01 curlのエラーになるので、いいのか？？
(setq twittering-allow-insecure-server-cert t)
;認証済みaccess tokenをGnuPGで暗号化して保存する
;(setq twittering-use-master-password t)

;; kuraku
(setq twit-user-kuraku
      '(("oauth_token" . "6119832-etV5FMNLLOxJXEQVgDMzcwAaIunIXdK14rA9yYOcYJ")
		("oauth_token_secret" . "ADOZMNyJvwJ1fO3l18uNmVUxE1QTB3Kgu61T49vwA0")
		("user_id" . "6119832")
		("screen_name" . "kuraku")))

;; _littlegray
(setq twit-user-littlegray
	  '(("oauth_token" . "412914463-YQFkCWCEDDd3fRxok7WAx6heAzg3WEAnXyK4LaX3")
		("oauth_token_secret" . "E6g37ZtSnnIiqdFuS05MgXL7nHPxn4V02XJ2iDcw6Q")
		("user_id" . "412914463")
		("screen_name" . "_littlegray")))

;; YoouAsa
(setq twit-user-YoouAsa
	  '(("oauth_token" . "1509191240-bi1dOAVqSAuxoXIxpW5RT7XuEWF2dH8cCVZ2UlQ") 
		("oauth_token_secret" . "xzQ13GqrFh9Xl4fxITmvROjs4NERXNbNKWFNFCyiqNU") 
		("user_id" . "1509191240") 
		("screen_name" . "YoouAsa")))

;; futaba
(setq twit-user-futaba
	  '(("oauth_token" . "949464781-Zu3KPqLglVcYebbUFauWVStYBVtb3T84YLMXMtI") 
		("oauth_token_secret" . "Z04FuNZJh8SBpiHhrmSOTGZ3o7jYjrdMpEUwIti0lhk")
		("user_id" . "949464781") 
		("screen_name" . "futabapink")))

;; @@ Set User
(setq twit-users-alist '(("kuraku") ("littlegray") ("YoouAsa") ("futaba")))
;; twittering-register-account-info をセットせず、
;; 新アカウントをセット→  して起動 (setq screen_name "user")
;; twittering-oauth-access-token-alist の内容を設定ファイルへ記述
(setq def-twit-username "littlegray")
(setq twittering-username def-twit-username)
(twittering-register-account-info
 (symbol-value (intern (concat "twit-user-" twittering-username))))

;(twittering-register-account-info twit-user-kuraku)
;(twittering-register-account-info twit-user-YoouAsa)
;(twittering-register-account-info twit-user-futaba)

;(require 'hex-util)
;(setq twittering-password (decode-hex-string "7368657238384c6f636b"))
(setq twittering-icon-mode nil)        ; Show icons
;;(setq twittering-scroll-mode t)        ; scroll-mode ;;obsolete
;;全てのアイコンを保存するか
;(setq twittering-icon-storage-limit t)

(setq twittering-timer-interval 1800)   ; Update your timeline each <- seconds (30 minutes)
;;(setq twittering-timer-interval 300)   ; Update your timeline each 300 seconds (5 minutes)

;;(setq twittering-convert-fix-size 40) ;; def 48

;;(setq twittering-timeline-header "")
;;(setq twittering-reverse-mode T)
;;(setq twittering-timeline-footer "\n")

;; realnameも表示する
;;(setq twittering-status-format
;;  "%i %S(%s),  %@:\n%FILL[  ]{%T // from %f%L%r%R}\n ")
;;(setq twittering-status-format "%i %s %@:\n %t // from %f%L")
;;(setq twittering-status-format "%i %S(%s)%p,  %@:\n%FILL{  %T // from %f%L%r%R}\n ")
;;(setq twittering-status-format "%i %p%s (%S),  %@:\n%FILL[  ]{%T // from %f%L%r%R}\n ")

;; my format
;(setq twittering-status-format "%i %p%s(%S),  %@:\n%FILL{  %T // from %f%L%r%R}\n ")
;(setq twittering-status-format "> %p%s=%S %@:\n %t // from %f%L")

;;(setq twittering-status-format "%FACE[twittering-face-mine]{》} %p%s=%S %@:\n %t // from %f%L")
(setq twittering-status-format "%FACE[twittering-face-mine]{%C{%H:%M}} %p%s=%S %@:\n %T // from %f%L%r%R")
(defface twittering-face-mine '((t (:foreground "cyan"))) nil)

(add-hook 'twittering-mode-hook
		    (lambda ()
			  (setq twittering-retweet-format " RT @%s: %t")
			  (mapc (lambda (pair)
					  (let ((key (car pair))
							  (func (cdr pair)))
						  (define-key twittering-mode-map
							(read-kbd-macro key) func)))
					  '(("M" . twittering-user-timeline)
						("F" . twittering-favorite)
						("R" . twittering-enter)
						("T" . twittering-retweet)
						("D" . twittering-direct-message)
						("W" . twittering-update-status-interactive)
						("w" . ma:twit-post)
						("u" . ma:twit-post)
						("DEL" . twittering-scroll-down)
						("," . scroll-up-one-line)
						("." . scroll-down-one-line)
						("S" . switch-twit-user) ;; original command
						("s" . ma:twit-search) ;; original command
						))))
;; start twmode
(define-key my-key-map "T" 'twit)
;; global key 'x' for Twitter post
(define-key my-key-map "x" 'ma:twit-post-ltg)

;;(define-key my-key-map "p" 'twittering-update-status-interactive)
(global-set-key [f12] 'twittering-update-status-interactive)

;; いくつかのTLをまとめて名前をつけることができる
(setq twittering-timeline-spec-alias
	  `(("r" . ,(lambda (username) (format "$related-to(%s)" username)))
		("related-to" .
		 (lambda (username)
		   (if username
			   (format ":search/to:%s OR from:%s OR @%s/"
					   username username username)
			 ":home")))
		("related-to-kuraku" . "$related-to(kuraku)")
		("related-to-littlegray" . "$related-to(_littlegray)")
		))
;; 起動時に以下のリストを読みこむ
(setq twittering-initial-timeline-spec-string
	    '(":mentions"
		  ;;"kuraku" "_littlegray"
		  ;;"mascarpone28"
		  "$r(_littlegray)"
		  ;"$r(kuraku)"
		  ;;"$r(mascarpone28)"
		  ;;"24FFX"
		  ;;"GAITAMENOW" ;FXレート
		  ;;
		  ;;"$r(kanouchi)"
		  ;;"$r(piston2438)"
		  ;;"$r(JFXkobayashi)"
		  ;;"kuraku/news"
;;		  "_littlegray/RadioDJ" 
		  "_littlegray/FX-Stock"
		  ;;"_littlegray/unix-linux"
		  ;;"_littlegray/LL"
		  ":search/#tama954 AND -kamatomo_HASH AND -MDSsan/"
		  ":search/(groovelinez OR piston2438 OR #glz) AND -piston2438_bot/"
		  ;;"$r(groovelinez)"
		  ":search/#jwave AND -MDSsan/"
		  ":search/(#ij954 OR #so954 OR #ar954) AND -MDSsan/"
		  ;;":search/#bayfm AND -MDSsan/"
		  ;;":search/ウクレレ/"
		  ;;":search/#musicsalad/"
		  ;;":search/#ijuin/" ;自分で取る C-c C-q
		  ;;":search/raspberrypi/"
		  ;;":search/freebsd/"
		  ;;":search/netbsd/"
		  ;;":search/debian/"
		  ;;":direct_messages"
		  ;;":direct_messages_sent"
		  ;;":retweets_of_me" ;; RTされたもの (なんかだめ
		  ;;":retweeted_to_me" ;; RTしたもの (なんかだめ
		  ":home" ))

(defun ma:twittering-help ()
  (interactive)
  (message 
   (concat "mymap-x:Post W:Post RET/R:reply T:QT C-uT:RT D:Direct C-cD:Del F:Favorite"
		      " L:List V:TL v:UserView")))
(define-key twittering-mode-map "?" 'ma:twittering-help)

;; ハッシュタグ入力
(setq hashtag-alist
	    '(("tama954") ("bayfm") ("jwave") ("glz #groovelinez #piston2438") 
		  ("raspberrypi") ("unix") ("linux")
		  ("piston2438") ("GR813 #jwave") ("ijuin") ("radionikkei")
		  ("twmode") ("iphonejp") ("posren") ("gohan")))

(defun ma:insert-hashtag ()
  (interactive)
  (let*
	  ((tag (completing-read "Hash Tag: #" hashtag-alist nil nil)))
	(save-excursion
	  (if (string= "" tag)
		  (setq twittering-current-hashtag nil)
		(progn
		  (insert (format " #%s" tag))
		  (setq twittering-current-hashtag tag))))))

;; Keybind
(define-key twittering-edit-mode-map "\C-ch" 'ma:insert-hashtag)
(define-key twittering-edit-mode-map "\C-c\C-t" 'twittering-set-current-hashtag)

;; 検索補完
(setq search-alist
	  '(("ウクレレ")
		("raspberrypi") ("freebsd") ("netbsd") ("debian") ("emacs") ("linux") ("unix")
		  ("Msalad OR #musicsalad OR #bayfm AND -MDSsan") 
		  ("groovelinez OR piston2438 OR #glz")
		  ("#tama954 AND -kamatomo_HASH AND -MDSsan")
		  ("#GR813 OR #jwave AND -MDSsan") ("#ijuin")
		  ("#fumou") ("meganebiiki") ("sdf.org") ("#小田急線")
		  ("#usdjpy") ("#eurjpy") ("#eurusd") ("#audjpy") ("#radionikkei")
		  ("#usdjpy OR #kawase") ("#forex AND #kawase")
		  ("#twmode") ("#iphonejp") ("#posren") ("#gohan")))

(defun ma:twit-search ()
  (interactive)
  (let*
	  ((tag (completing-read "My Search :" search-alist nil nil)))
	(if (not (string= "" tag))
		(twittering-search tag))))

;; URL短縮サービスをj.mpに
;; YOUR_USER_IDとYOUR_API_KEYを自分のものに置き換えてください
;; from http://u.hoso.net/2010/03/twittering-mode-url-jmp-bitly.html
;(add-to-list 'twittering-tinyurl-services-map
;			  '(jmp . "http://api.j.mp/shorten?version=2.0.1&login=kuraku&apiKey=R_0798e77228a2df06af034dcb6fa0daa7&format=text&longUrl="))
;(setq twittering-tinyurl-service 'jmp)

;(setq twittering-allow-insecure-server-cert t)

;; 13.06.07(fri)-02:57

;;;; for mode-line
(add-hook 'twittering-mode-hook 'ma:twit-setup-modeline)

(defun ma:current-screen-name ()
  (format "<%s>" (cdr (assoc "screen_name" twittering-oauth-access-token-alist))))

(defun ma:twit-setup-modeline ()
  (add-to-list 'mode-line-buffer-identification '(:eval (ma:current-screen-name)) t))

;; 13.06.11(tue)-07:02
;; @ switch user

;; not use.
;;(defun switch-twit-user-1 ()
;;  (interactive)
;;  (let* ((user (completing-read "Twit User: " twit-users-alist nil nil)))
;;	(if (not (string= "" user))
;;		(twittering-register-account-info (symbol-value (intern (concat "twit-user-" user)))))
;;	(setq twittering-username user) ))

(defalias 'ch-twit-user 'switch-twit-user)
(defalias 'twit-user 'switch-twit-user)

(defun switch-twit-user (&optional u)
  (interactive)
  (setq twittering-username (if u u (completing-read "Twit User: " twit-users-alist nil nil)))
  (twittering-register-account-info 
   (symbol-value (intern (concat "twit-user-" twittering-username)))) )

(define-key twittering-mode-map "C" 'ch-twit-user)

;; to EVERNOTE
(setq evernote-twit-username "kuraku")
(defun direct-to-evernote ()
  (interactive)
  (switch-twit-user evernote-twit-username)
  (twittering-update-status 
   (format "from emacs(%s):\n" twittering-username) nil "myen" 'direct-message nil)
  ;;(switch-twit-user def-twit-username)
  )

(define-key my-key-map "E" 'direct-to-evernote)
(define-key twittering-mode-map "E" 'direct-to-evernote)

; post from account
(defun ma:twit-post (&optional account)
  (interactive)
  (if account
	  (switch-twit-user account)
	(setq account twittering-username))
  (twittering-update-status)
  (message (concat "user:" account)))

(defun ma:twit-post-krk ()
  (interactive) (ma:twit-post "kuraku"))
(defun ma:twit-post-ltg ()
  (interactive) (ma:twit-post "littlegray"))

(define-key twittering-mode-map "K" 'ma:twit-post-krk)
(define-key twittering-mode-map "_" 'ma:twit-post-ltg)
(define-key my-key-map "K" 'ma:twit-post-krk)
(define-key my-key-map "_" 'ma:twit-post-ltg)
(define-key my-key-map "L" 'ma:twit-post-ltg)

;; font-lockをこねくった跡
;;
;;(font-lock-add-keywords 'twittering-mode 
;;						'(("FX\\|little" . 'ffap) ))

;; (add-hook 'twittering-mode-hook 
;; 		  '(lambda ()
;; 			 (font-lock-add-keywords
;; 			  nil
;; 			  '(("_littlegray" (0 'font-lock-constant-face t))
;; 				("FX\\|#jwave"  (0 'font-lock-comment-face t))
;; 				))))

;;(font-lock-add-keywords nil '(("\t"  (0 'font-lock-constant-face t))) t))

;;(defadvice font-lock-mode (before my-font-lock-mode ())
;;  (font-lock-add-keywords
;;   'twittering-mode
;;   '(
;;	 ("littlegray" 0 font-lock-constant-face append)
;;	 ("about" 0 font-lock-comment-face append)
;;	 ("[ \t]+$" 0 font-lock-constant-face append)
;;	 )))
;;(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;;(ad-activate 'font-lock-mode)


;; END twittering-mode setup
