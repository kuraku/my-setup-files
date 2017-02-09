;; -*- emacs-list -*-
;; @@ Twittering-mode
;; Time-stamp: <2015-01-29 16:53 akira.masuda>

;; @ twittering
(require 'twittering-mode)
;(setq twittering-auth-method 'xauth)
(setq twittering-username "kuraku")
;(require 'hex-util)
;(setq twittering-password (decode-hex-string "7368657238384c6f636b"))
(setq twittering-icon-mode t)           ; Show icons
(setq twittering-scroll-mode t)			; Scroll
(setq twittering-timer-interval 600)   ; Update your timeline each 300 seconds (5 minutes)

(setq twittering-convert-fix-size 34) ;; def 48

;; realnameも表示する
;;(setq twittering-status-format
;;	  "%i %S(%s),  %@:\n%FILL[  ]{%T // from %f%L%r%R}\n ")
;(setq twittering-status-format "%i %s %@:\n %t // from %f%L")
;;(setq twittering-status-format "%i %S(%s)%p,  %@:\n%FILL{  %T // from %f%L%r%R}\n ")
;;(setq twittering-status-format "%i %p%s (%S),  %@:\n%FILL[  ]{%T // from %f%L%r%R}\n ")
(setq twittering-status-format "%i %p%s(%S),  %@:\n%FILL{  %T // from %f%L%r%R}\n ")


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
					("W" . twittering-update-status-interactive)))))
;; start twmode
(define-key my-key-map "T" 'twit)
;; global key 'x' for Twitter post
(define-key my-key-map "x" 'twittering-update-status-interactive)
;;(define-key my-key-map "p" 'twittering-update-status-interactive)
(global-set-key [f12] 'twittering-update-status-interactive)

;; いくつかのTLをまとめて名前をつけることができる
(setq twittering-timeline-spec-alias
	  `(("related-to" .
		 ,(lambda (username)
			(if username
				(format ":search/to:%s OR from:%s OR @%s/"
						username username username)
			  ":home")))
		))
;; 起動時に以下のリストを読みこむ
(setq twittering-initial-timeline-spec-string
	  '(":mentions"
		"$related-to(kuraku)"
		;; "$related-to(mascarpone28)"
		;; "mascarpone28"
		"kuraku/マスカル"
		"kuraku/friends1"
		"kuraku/meet"
		"kuraku/news"
		"kuraku/iphone"
		"kuraku/radio"
		"kuraku/favorite1"
		"kuraku/personality"
		"kuraku/posren"
		;;"kuraku/otoguro"
		"kuraku/habits7"
		;; "kuraku/kayoko"
		":search/#kirakira -an.to -aorita_girl/"
		":search/#tama954/"
		":search/#piston2438/"
		":direct_messages"
		;; ":direct_messages_sent"
		":home"))

(defun ma:twittering-help ()
  (interactive)
  (message 
   (concat "mymap-x:Post W:Post RET/R:reply T:QT C-uT:RT D:Direct C-cD:Del F:Favorite"
		   " L:List V:TL v:UserView")))
(define-key twittering-mode-map "?" 'ma:twittering-help)

;; ハッシュタグ入力
(setq hashtag-alist
	  '(("piston2438") ("kirakira") ("tinsaya") ("twmode") ("iphonejp") ("posren") ("gohan")))

(defun ma:insert-hashtag ()
  (interactive)
  (let*
	  ((tag (completing-read "Hash Tag: #" hashtag-alist nil nil)))
	(if (string= "" tag)
		(setq twittering-current-hashtag nil)
	  (progn
		(insert (format " #%s " tag))
		(setq twittering-current-hashtag tag)))))

;; Keybind
(define-key twittering-edit-mode-map "\C-ch" 'ma:insert-hashtag)
(define-key twittering-edit-mode-map "\C-c\C-t" 'twittering-set-current-hashtag)

;; URL短縮サービスをj.mpに
;; YOUR_USER_IDとYOUR_API_KEYを自分のものに置き換えてください
;; from http://u.hoso.net/2010/03/twittering-mode-url-jmp-bitly.html
(add-to-list 'twittering-tinyurl-services-map
			 '(jmp . "http://api.j.mp/shorten?version=2.0.1&login=kuraku&apiKey=R_0798e77228a2df06af034dcb6fa0daa7&format=text&longUrl="))
(setq twittering-tinyurl-service 'jmp)

;(setq twittering-allow-insecure-server-cert t)

(setq twittering-oauth-access-token-alist 
      '(("oauth_token" . "6119832-etV5FMNLLOxJXEQVgDMzcwAaIunIXdK14rA9yYOcYJ")
		("oauth_token_secret" . "ADOZMNyJvwJ1fO3l18uNmVUxE1QTB3Kgu61T49vwA0")
		("user_id" . "6119832")
		("screen_name" . "kuraku")))

;; END twittering-mode setup
