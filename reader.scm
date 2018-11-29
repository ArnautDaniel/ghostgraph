(use-modules (ice-9 rdelim))
(include "doggo.scm")
(include "graphviz.scm")

(define working-file "/home/silver/rw-code/apue.2e/db/db.c")
(define hash-size 1000)

(define (read-file dst)
  (let ((file (open-file dst "r")))
    (let looper ((hashtbl (make-hash-table 1000))
		 (i 1))
      (let ((cur-line (read-line file)))
	(if (eof-object? cur-line)
	    hashtbl
	    (begin (hash-set! hashtbl i cur-line)
		   (looper hashtbl (+ i 1))))))))
		     
(define (make-simple-hash-ref hashtbl)
  (let ((hashtbl hashtbl))
    (lambda (x)
      (if (equal? x 'return)
	  hashtbl
	  (hash-ref hashtbl x)))))

(define (return-hash-ref dst)
  (make-simple-hash-ref (read-file dst)))

;;;Get set language here
;;; test-ref is the program code read into a hash-table
(define test-ref (return-hash-ref working-file))
;;; test matcher is a closure containing the doggo translation between
;;; some language and itself
(define test-matcher (return-doggo-matcher c-defs))

;;;For any easily found variables without using a full fledged parser
(define (find-vars hash-reffer doggo-matcher semantic-expr)
  (let ((hashtbl (hash-reffer 'return))
	(semantic-expr (doggo-matcher semantic-expr)))
     (filter (lambda (x) (equal? (not x) #f))
	     (hash-map->list
	      (lambda (key value)
		(if (string-contains value semantic-expr)
		    (list key value)
		    #f))
	      hashtbl))))

  ;;;merge these two
(define (general-find hash-reffer item)
  (let ((hashtbl (hash-reffer 'return)))
    (filter (lambda (x) (equal? (not x) #f))
	    (hash-map->list
	     (lambda (key value)
	       (if (string-contains  value item)
		   (list key value)
		   #f))
	     hashtbl))))

(define (write-simple-digraph origin)
  (let ((output (open-output-file "/home/silver/projects/ghostgraph/test.dot")))
    (display "digraph { rankdir=LT " output)
    (display (globals-to-digraph  (find-vars test-ref test-matcher 'constant-t)) output)
    (display (imports-to-digraph (find-vars test-ref test-matcher 'import) origin) output)
    (display " } " output)
    (flush-all-ports)
    (close-port output)))

