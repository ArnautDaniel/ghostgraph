(define doggo-defs '(and or if cond equal while for define record lambda truth false greater-t lesser-t constant-t goto set import))

(define c-defs '("&&" "||" "if" "switch" "==" "while" "for" "=" "struct" "" (lambda (x) (not (= x 0))) (lambda (x) (= x 0))
		 ">" "<" "#define" "goto" "=" "#include"))

(define scheme-defs '(and or if cond equal "" map define define-record (lambda (x) (not (= x 0))) (lambda (x) (= x 0)) > < "" "" set! import))

(define (zip-doggo lst lat)
  (let looper ((acc '())
	       (lst0 lst)
	       (lat0 lat))
    (cond
     ((or (null? lst0) (null? lat0))
      acc)
     (else
      (looper (cons (list (car lst0) (car lat0)) acc)
	      (cdr lst0) (cdr lat0))))))

(define (doggo-funcall fun . args)
  (apply fun args))

(define (doggo-match elem lst)
  (assoc elem lst))

(define (return-doggo-matcher lang)
  (let ((lang (zip-doggo doggo-defs lang)))
    (lambda (elem)
      (let ((res (doggo-match elem lang)))
	(if res
	    (cadr res)
	    #f)))))

