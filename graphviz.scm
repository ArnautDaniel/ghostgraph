;;;Some function that takes in a list/of global vars -> list of strings creating a digraph
(use-modules (srfi srfi-1))
(define begin-digraph "digraph { ")
(define end-digraph "}")

(define (to-digraph di-list)
  (fold string-append "" di-list))

(define (globals-to-digraph di-list)
  (let looper ((res "Globals [ shape=\"record\" label=\"Global Vars|")
	       (di-list di-list))
    (if (null? di-list)
	(string-append (substring res 0 (- (string-length res) 1)) "\" ] ")
	(looper
	 (string-append res  (cadar di-list) " - Ln " (number->string (caar di-list)) "|")
	 (cdr di-list)))))

(define (imports-to-digraph di-list origin)
  (let ((ri-list di-list))
  (let looper ((res "")
	       (di-list di-list))
    (if (null?  di-list)
	(imports-to-digraph-connect ri-list res origin)
	(looper
	 (string-append res " " (number->string (caar di-list)) " [ label=\"" (cadar di-list) "\" shape=\"rectangles\" ] ")
	 (cdr di-list))))))

(define (imports-to-digraph-connect di-list res origin)
  (string-append res " "
		 (fold string-append ""
		       (map (lambda (x) (string-append (number->string (car x)) " -> " origin " "))
		      di-list))))
	       
(define entry-function "main")


