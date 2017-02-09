;;
;;


;;(setq user-mail-address "masuda.akria@gmail.com")
(setq user-mail-address "masuda@posren.com")
(setq user-full-name "MASUDA Akira")

;;(setq mail-user-agent 'message-user-agent)
;(setq message-send-mail-function 'message-smtpmail-send-it)

;(setq mail-user-agent 'sendmail-user-agent)
(setq message-send-mail-function 'message-send-mail-with-sendmail)
;; c:/home/.smtp/ssmtp.conf
(setq sendmail-program "c:/home/bin/ssmtp.exe")

;(setq send-mail-function 'smtpmail-send-it)
;(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587)
(setq smtpmail-starttls-credentials
 '(("smtp.gmail.com" 587 "masuda.akira@gmail.com" nil)))
(setq smtpmail-auth-credentials
; '(("smtp.gmail.com" 587 "masuda.akira@gmail.com" "sher88Lock")))
 '(("smtp.gmail.com" 587 "masuda.akira@gmail.com" nil)))

(setq smtpmail-debug-info t)

(setq starttls-program "C:/home/bin/starttls.exe")
(setq starttls-negotiation-by-kill-program t)
(setq starttls-kill-program "C:/home/bin/kill.exe")

(require 'smtpmail)
;(require 'starttls)

(autoload 'starttls-any-program-available "starttls" "starttls" t)
