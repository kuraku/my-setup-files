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

;; Emacs�ɃR�}���h�̈ʒu��F�������Ďg����悤�ɂ���
;;(dolist (dir (list
;;              "/sbin"
;;              "/bin"
;;              "/usr/sbin"
;;              "/usr/bin"
;;              "/usr/local/bin"
;;              ;; ruby�̏ꏊ�𒼐ڎw��
;;              ;;(expand-file-name "~/.rbenv/versions/1.9.2-p320/bin")
;;              ;; ��������
;;              ;; (expand-file-name "~/.rbenv/shims")
;;              ))
;;  (when (and (file-exists-p dir) (not (member dir exec-path)))
;;    (setenv "PATH" (concat dir ":" (getenv "PATH")))
;;    (setq exec-path (append (list dir) exec-path))))

(require 'evernote-mode)
;; �V�K�m�[�g�쐬�B�^�O�A�^�C�g���Ȃǂ����
(global-set-key (kbd "C-c e c") 'evernote-create-note)
;; �^�O��I�����ăm�[�g���J��
(global-set-key (kbd "C-c e o") 'evernote-open-note)
;; �������[�h����͂��āANote:�ƕ\�����ꂽ��Tab�ňꗗ���\�������
(global-set-key (kbd "C-c e s") 'evernote-search-notes)
;; evernote-create-search�ŕۑ����ꂽ�������[�h�Ō���
(global-set-key (kbd "C-c e S") 'evernote-do-saved-search)
;; ���݂̃o�b�t�@��Evernote�ɋL�^
(global-set-key (kbd "C-c e w") 'evernote-write-note)
;; �I��͈͂�Evernote�ɋL�^
(global-set-key (kbd "C-c e p") 'evernote-post-region)
;; Evernote�{���p�u���E�U���N��
(global-set-key (kbd "C-c e b") 'evernote-browser)
;; �����̃m�[�g�ɕҏW��������
(global-set-key (kbd "C-c e e") 'evernote-change-edit-mode)


;; ���[�U�[�����͂��ȗ��ł���B���g�̃A�J�E���g����ݒ�
(setq evernote-username "kuraku")
;; ���񒷂��p�X���[�h�͖ʓ|�Ȃ̂ŁA�ŏ��ɃC���X�g�[������gpg�ŊǗ�
;(setq evernote-password-cache t)
;; gpg�t�@�C���̕ۑ���Ɩ��O��ύX
;(setq enh-password-cache-file "~/.emacs.d/evernote-mode.gpg")

;;
;;(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; optional

;;developer tokens
(setq evernote-developer-token "S=s5:U=9f2ec:E=152afe29199:C=14b58316498:P=1cd:A=en-devtoken:V=2:H=03d9957502d5741ea09cce897dd9ea54")
;;NoteStore URL: https://www.evernote.com/shard/s5/notestore
;;Expires: 04 February 2016, 21:23
