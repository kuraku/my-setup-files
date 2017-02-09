; -*- lisp-interaction -*-

(defun test ()
  (let ((str1 "foo") (str2 "bar"))
    (loop for s in (list str1 str2) do (message s))))

`("str1","str2")
("str1" "str2")

(list "str1" "str2")
("str1" "str2")

(type-of 42)
integer
(type-of 3.14)
float
(type-of "foo")
string
(type-of '(1 2))
cons
(type-of '[1 2])
vector
(type-of 'foo)
symbol
(type-of ?a)  ; Cの'a'相当。内部的には数値
integer

;;
(setq foo `())
nil
(setq foo (cons "value" foo))   ; リストfooに要素をprepend
("value" "value" "value")

(setq load-path (cons (expand-file-name "~/elisp") load-path))
 
(list "foo" "bar" "baz")  ; 引数を要素に持つリストを生成
=> ("foo" "bar" "baz")

`("foo" "bar" "baz")

(append '("foo" "bar") '("baz"))  ; 連接したリストを生成
=> ("foo" "bar" "baz")
(setq load-path (append load-path (list (expand-file-name "~/elisp"))))

(car (nthcdr 1 '("foo" "bar" "baz")))   ; N番目の要素の取得
=> "bar"

(fset 'my-plus2 '(lambda (n) (+ n 2)))   ; defunと同じ

;list
'("a" "b")
("a" "b")

(cons "a"  '("b" "c"))
("a" "b" "c")

;cons
'("a" . "b")
("a" . "b")


; carに文字列、cdrに数値のコンスセルを指すシンボルfoo
(setq foo '("foo" . 42))
("foo" . 42)
; quoteは全体に効いているので、carとcdrの両方がシンボルfoo
(setq bar '(foo . foo))
(foo . foo)
(symbol-value (car bar))
("foo" . 42)
(symbol-value (cdr bar))
("foo" . 42)
; backquoteの例
(setq bar `(,foo . foo))
(("foo" . 42) . foo)

`,foo
("foo" . 42)

(mapcar '(lambda (n) (setq sum (+ sum n))) lst)


(setq lst '(1 2 3 4))
(1 2 3 4)

(defun get-sum-recur (lst)
  (cond
   ((null lst) 0)
   (t (+ (car lst) (get-sum-recur (cdr lst))))))

(get-sum-recur lst)
10

(let ((sum 0))
    (mapcar '(lambda (n) (setq sum (+ sum n))) lst) sum)
10

(let ((sum 0))
  (dolist (n lst) (setq sum (+ n sum))) sum)
10


(format "abc %s %d" "def" 12)
"abc def 12"

(let (val)
  (dotimes (n 5 val)
    (setq val (cons n val))))
(4 3 2 1 0)

(let (value)      ; otherwise a value is a void variable
  (dotimes (number 3 value)
    (setq value (cons number value))))
(2 1 0)


(dotimes (n 12)
    (print (format "%d月はelipで酒が飲めるぞー！酒が飲める飲めるぞー！酒が飲めるぞー！♪" (1+ n))))




'(1 10)
(1 10)

(let ((a "酒が飲める")(b "ぞー！"))(mapcar (lambda (m) (print (format "%d月はLispで%s%s%s飲める%s%s%s♪" m a b a b a b))) '(1 2 3 4 5 6 7 8 9 10 11 12)))


;;2016-10-17 mon 14:38
(let ((sum 0))
  (while (< sum 10)
	(progn
	  (insert (format "test%03d@gmail.com\n" sum ))
	  (setq sum (+ sum 1))
	  )))

;↓こっちがシンプルか
(dotimes (n 10)
    (print (format "test%03d@gmail.com\n" (1+ n))))

