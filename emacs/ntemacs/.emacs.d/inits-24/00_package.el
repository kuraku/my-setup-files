;; package for emacs24

(require 'package)
 
;; MELPA��ǉ�
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
 
;; MELPA-stable��ǉ�
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
 
;; Marmalade��ǉ�
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
 
;; Org��ǉ�
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
 
;; ������
(package-initialize)