;; package for emacs24

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)


; ;; MELPA��ǉ�
; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;  
; ;; MELPA-stable��ǉ�
; (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;  
; ;; Marmalade��ǉ�
; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;  
; ;; Org��ǉ�
; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
 
;; ������
(package-initialize)
