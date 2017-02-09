;; -*- emacs-list -*-
;; @@ Print
;; Time-stamp: <2014-03-06 18:20 akira.masuda>

;;; ps-print �s�Ԃ��󂩂Ȃ��̂���_�B
;;; ���j���[�� File->Postccript Print Buffer �Ȃǂ������B
;;(require 'ps-mule)
(defalias 'ps-mule-header-string-charsets 'ignore)

(require 'ps-bdf) ;; ����͕s�v?
(require 'cl)
(defun listsubdir (basedir)
  (remove-if (lambda (x) (not (file-directory-p x)))
             (directory-files basedir t "^[^.]"))) ;;

(setq bdf-directory-list
      (listsubdir "c:/home/.emacs.d/intlfonts-1.2.1")) ;;

;; 13.04.18(thu)-18:08
(setq ps-print-color-p t
      ps-lpr-command "C:/gs/gs9.02/bin/gswin32c.exe"
      ps-multibyte-buffer 'bdf-font-except-latin ; (�������Ȃ� courier�łł���)
;;      ps-multibyte-buffer 'non-latin-printer ; (���{��o�P��)
;;	  ps-multibyte-buffer 'bdf-font ; �⏕�����Ȃǂ�����ł��� (�L�^�Ȃ��Ȃ���)
      ps-lpr-switches '("-sDEVICE=mswinpr2" "-dNOPAUSE" "-dBATCH")
      printer-name nil
      ps-printer-name nil
      ps-printer-name-option nil
	  ps-paper-type 'a4 ; ����Ă������ق�������B
	  ps-font-size 7  ; larger than default �������܂������� def:8.5
	  ps-print-header t ; header ���� (default)
	  ps-line-number t  ; �s�ԍ�
	  ps-landscape-mode t ;�p���͉��u��
	  ps-number-of-columns 2
      )


;(setq ps-multibyte-buffer 'bdf-font) ; �⏕�����Ȃǂ�����ł���
;(setq ps-multibyte-buffer 'bdf-font-except-latin) ; ����Blatin������courier�ň��
;; paper-type: `a4' `a3' `letter' `legal' `letter-small' `tabloid'
;; `ledger' `statement' `executive' `a4small' `b4' `b5'
;;(setq ps-paper-type 'a4) ; ����Ă������ق�������B
;;(setq ps-font-size 10) ; larger than default �������܂�������
;(setq ps-font-size 11) ; larger than default �ʏ�̌����ɍœK
;;(setq ps-print-header t) ; header ���� (default)
;(setq ps-print-header nil) ; header �Ȃ�
;; landscape(50lines): t; portrait(70lines): nil (default)
;(setq ps-landscape-mode t)
;(setq ps-number-of-columns 2)


;;(setenv "GS_LIB" "c:/gs/gs9.02/lib;c:/gs/gs9.02/fonts")
;;(setq ps-lpr-command "c:/gs/gs9.02/bin/gswin32c.exe")
;;(setq ps-lpr-switches '("-q" "-dNOPAUSE" "-dBATCH" "-sDEVICE=mswinpr2"))
;;(setq ps-printer-name t)

;; Background text
;;  (STRING X Y FONT FONTSIZE GRAY ROTATION PAGES...)
(setq ps-print-background-text
		  '(
			;;("SECOM Information System." 0 0 nil 70 0.85)
			;;("Network Technology Group." 0 0 nil 70 0.85)
			;;("DesignEXchange Co.,Ltd" 50 90 nil 70 0.85)
			;;("masuda@dex.ne.jp" 150 80 nil 70 0.85)
			("Posren Co.,Ltd." 50 90 nil 70 0.75)
			("CONFIDENTIAL" 150 80 nil 70 0.75)
			;;("masuda@posren.com" 150 80 nil 70 0.75)
			;;
			;; ("preliminary")
			;; ("special"
			;; "LeftMargin" "BottomMargin PrintHeight add" ; X and Y position
			;; (upper left corner)
			;; nil nil nil
			;; "PrintHeight neg PrintPageWidth atan" ; angle
			;; 5 (11 . 17))                ; page list
			))

;;; @ ps-print set
;(load "my-ps-print")
;(load-file "~/elisp/my-ps-print.el")

;;; @ Horizontal layout
;;  ------------------------------------------
;;  |    |      |    |      |    |      |    |
;;  | lm | text | ic | text | ic | text | rm |
;;  |    |      |    |      |    |      |    |
;;  ------------------------------------------
(setq ps-left-margin (/ (* 72  1.8) 2.54) ; (/ (* 72  2.0) 2.54) 2 cm
			ps-right-margin (/ (* 72  1.8) 2.54) ; 2 cm
			ps-inter-column (/ (* 72  1.5) 2.54)) ; 2 cm

;;; @ Vertical layout
;; |--------|
;; | tm     |
;; |--------|
;; | header |
;; |--------|
;; | ho     |
;; |--------|
;; | text   |
;; |--------|
;; | bm     |
;; |--------|
(setq ps-bottom-margin (/ (* 72  1.5) 2.54) ; 1.5 cm
			ps-top-margin    (/ (* 72  1.5) 2.54) ; 1.5 cm
			ps-header-offset (/ (* 72  0.7) 2.54) ; 1.0 cm
			ps-header-line-pad 0.15)

;; 99.02.18(Thu)-11:46:13
(setq mypaper-alist
		  '(("a4") ("a3") ("letter") ("legal") ("letter-small") ("tabloid")
			("ledger") ("statement") ("executive") ("a4small") ("b4") ("b5")))
(setq myfont-alist
		  '(("Courier") ("Helvetica") ("Times") ("Palatino") ("Helvetica-Narrow")
			("NewCenturySchlbk") ("AvantGarde-Book") ("AvantGarde-Demi")
			("Bookman-Demi") ("Bookman-Light") ("Symbol") ("Zapf-Dingbats")
			("Zapf-Chancery-MediumItalic")))

(defun ma:ps-print-optional-buffer (region)
  (interactive "Pr")
  (let*
	  ((ps-paper-type
		(intern (completing-read "�p���w��: " mypaper-alist nil t "a4")))
	   (ps-landscape-mode
		(if (equal (read-string "�c[1]/��[2]: " "1") "2") t nil))
	   (ps-number-of-columns
		(string-to-number (read-string "�J������: "
									   (if ps-landscape-mode "2" "1"))))
	   (ps-font-family
		(intern (completing-read "�t�H���g: " myfont-alist nil t "Courier")))
	   (ps-font-size
		(string-to-number (read-string "�t�H���g�T�C�Y: "
									   (if ps-landscape-mode "7.5" "9")))))
	(if region (ps-print-region (region-beginning) (region-end))
	  (ps-print-buffer)) ))

(defun ma:ps-print-optional-region ()
  (interactive)
  (ma:ps-print-optional-buffer t))
