(require 'tramp)
(setq tramp-rsh-end-of-line "\r")
(add-to-list
 'tramp-methods
 '("myplink"
   (tramp-connection-function tramp-open-connection-rsh)
   (tramp-login-program "C:\\home\\bin\\plink.exe")
   (tramp-copy-program nil)
   (tramp-remote-sh "/bin/sh")
   (tramp-login-args
	("-ssh"))))
(setq tramp-default-method "myplink")