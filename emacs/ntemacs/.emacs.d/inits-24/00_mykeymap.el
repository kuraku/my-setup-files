;; -*- emacs-list -*-
;; @@ MyKeymap
;; Time-stamp: <2014-02-13 17:38 akira.masuda>

;; @ My key perfix
;; Keymap C-TAB (or C-x ESC)
;; 08.01.16(wed)-11:36
(defvar my-key-map (make-sparse-keymap)
  "keymap for masuda commands of C-tab.")
(global-set-key (kbd "C-x x") my-key-map)
(global-set-key (kbd "C-<tab>") my-key-map)
(global-set-key (kbd "M-;") my-key-map)
;;(global-set-key (kbd "C-x ESC") ;my-key-map)
;;				'(lambda () (interactive)(message "My prefix key is \"C-<tab>\".")))

;; 2014-02-13 thu 17:38
(global-set-key (kbd "C-]") my-key-map)

(global-set-key (kbd "C-q") my-key-map)
(global-set-key "\C-q\C-q" 'quoted-insert)       ; emacs-origin C-q
