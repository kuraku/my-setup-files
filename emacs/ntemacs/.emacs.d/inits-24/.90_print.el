;; -*- emacs-list -*-
;; @@ Print
;; Time-stamp: <2013-04-19 16:47:16 akira.masuda>

;; sakura.exe �𗧂��グ��
(setq print-region-function
	  (lambda (start end
					 &optional lpr-prog
					 delete-text buf display
					 &rest rest)
		(let* ((procname (make-temp-name "w32-print-"))
			   (tempfile
				(subst-char-in-string
				 ?/ ?\\
				 (expand-file-name procname temporary-file-directory)))
			   (coding-system-for-write 'sjis-dos))
		  (write-region start end tempfile)
		  (set-process-sentinel
		   (start-process procname nil "C:/Program Files/sakura/sakura.exe" tempfile)
		   ;;(start-process procname nil "notepad.exe" tempfile)
		   (lambda (process event)
			 (let ((tempfile
					(expand-file-name (process-name process)
									  temporary-file-directory)))
			   (when (file-exists-p tempfile)
				 (delete-file tempfile))))))))
;;;;;; /sakura

;;(require 'ps-bdf) ;; ����͕s�v?
(require 'cl)
(defun listsubdir (basedir)
  (remove-if (lambda (x) (not (file-directory-p x)))
             (directory-files basedir t "^[^.]"))) ;; ���[�e���e�B�[

(setq bdf-directory-list
      (listsubdir "c:/home/.emacs.d/intlfonts-1.2.1")) ;; ���v����


;; 13.04.18(thu)-18:08
;; ���s����
(setq ps-print-color-p t
      ps-lpr-command "C:/gs/gs9.02/bin/gswin32c.exe" ;; ���v����
      ps-multibyte-buffer 'bdf-font-except-latin
;;      ps-multibyte-buffer 'non-latin-printer
      ps-lpr-switches '("-sDEVICE=mswinpr2" "-dNOPAUSE" "-dBATCH")
      printer-name nil
      ps-printer-name nil
      ps-printer-name-option nil
      )

;;; ps-print �s�Ԃ��󂩂Ȃ��̂���_�B
;;; ���j���[�� File->Postccript Print Buffer �Ȃǂ������B
(if (>= emacs-major-version 21)
    (progn
      (require 'ps-mule)
	  (defalias 'ps-mule-header-string-charsets 'ignore)))
;(setq ps-multibyte-buffer 'bdf-font) ; �⏕�����Ȃǂ�����ł���
(setq ps-multibyte-buffer 'bdf-font-except-latin) ; ����Blatin������courier�ň��
;; paper-type: `a4' `a3' `letter' `legal' `letter-small' `tabloid'
;; `ledger' `statement' `executive' `a4small' `b4' `b5'
(setq ps-paper-type 'a4) ; ����Ă������ق�������B
(setq ps-font-size 10) ; larger than default �������܂�������
;(setq ps-font-size 11) ; larger than default �ʏ�̌����ɍœK
;(setq ps-print-header t) ; header ���� (default)
;(setq ps-print-header nil) ; header �Ȃ�
;; landscape(50lines): t; portrait(70lines): nil (default)
;(setq ps-landscape-mode t)
;(setq ps-number-of-columns 2)


;;(setenv "GS_LIB" "c:/gs/gs9.02/lib;c:/gs/gs9.02/fonts")
;;(setq ps-lpr-command "c:/gs/gs9.02/bin/gswin32c.exe")
;;(setq ps-lpr-switches '("-q" "-dNOPAUSE" "-dBATCH" "-sDEVICE=mswinpr2"))
;;(setq ps-printer-name t)
