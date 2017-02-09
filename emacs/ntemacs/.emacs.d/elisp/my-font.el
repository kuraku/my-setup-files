(defun my-set-assoc-data (list key value)
 ;; リストに既に同じキーがあれば上書き、無ければ新規追加
 (let ((item (assoc key (symbol-value list))))
   (if item
(setcdr item value)
     (add-to-list list (cons key value)))))

(defun my-set-font (ascii-font jis-font size mul)
 ;; フォント設定
 ;; ascii フォント、和文フォント、サイズ、倍率の順に指定する。
 (create-fontset-from-ascii-font
  (concat "-*-" ascii-font "-normal-r-normal-normal-"
   (int-to-string size) "-*-*-*-*-*-iso8859-1")
  nil
  (concat ascii-font (int-to-string size)))
    
 (let* ((encoded (encode-coding-string jis-font 'emacs-mule))
 (family (concat encoded "*"))
 (fontset (concat "fontset-" ascii-font (int-to-string size))))

   (set-fontset-font fontset 'japanese-jisx0208
       (cons family "jisx0208-sjis"))
   (set-fontset-font fontset 'katakana-jisx0201
       (cons family "jisx0201-katakana"))
  
   (my-set-assoc-data 'face-font-rescale-alist (concat ".*" encoded ".*") mul)
   (my-set-assoc-data 'default-frame-alist 'font fontset)
   (set-frame-font fontset)))

;; 倍率は全角と半角の比率を調整する。サイズによって最適値は異なる。
;(my-set-font "M+2VM+IPAG circle" "M+2VM+IPAG circle" 11 1.1)
;(my-set-font "Consolas" "メイリオ" 12 1.2)
;(my-set-font "Courier New" "ＭＳ ゴシック" 12 1.2)
(my-set-font "ＭＳ ゴシック" "ＭＳ ゴシック" 12 1.0)