;; TRAMP

;; 08.06.23(mon)-12:34
;;(setq tramp-shell-prompt-pattern "^.*[#$%>] *")
(require 'tramp)
;(setq tramp-default-method "plink")

;;(setq tramp-default-method "pscp") ;;???
(modify-coding-system-alist 'process "plink" 'euc-japan-unix)
;(modify-coding-system-alist 'process "plink" 'utf-8-unix)

;; 11.03.01(tue)-11:31
(setq-default tramp-debug-buffer t)

;;cd /masuda@dev.posren.com:~/ で入れたけどなんか動かない

(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
			  vc-ignore-dir-regexp
			  tramp-file-name-regexp))

;; proxy zero
;; /ssh:masuda@dev06.posren-new:/home/masuda
;; /sudo:dev06.posren-new:/usr/local/
(add-to-list 'tramp-default-proxies-alist
             '("^dev.*" nil "/plink:masuda@zero.posren.com:"))
             ;;'(nil nil "/plink:masuda@zero.posren.com:"))

;; /plink:masuda@192.168.1.56:
;; /sudo:root@192.168.1.56:
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/plink:masuda@192.168.1.56:"))

;(add-to-list 'tramp-default-proxies-alist '("localhost\\'" "\\`root\\'" nil))