;; package for emacs24

(require 'package)
 
;; MELPA‚ğ’Ç‰Á
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
 
;; MELPA-stable‚ğ’Ç‰Á
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
 
;; Marmalade‚ğ’Ç‰Á
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
 
;; Org‚ğ’Ç‰Á
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
 
;; ‰Šú‰»
(package-initialize)