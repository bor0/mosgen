#lang racket
(provide args to-html read-avg-rgb-vals)

(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

(define my-eval
  (let ((ns (make-base-namespace)))
    (parameterize ((current-namespace ns))
      (namespace-require 'racket/bool))
    (lambda (expr) (eval expr ns))))

(define (args) (vector->list (current-command-line-arguments)))

(define (to-html list)
  (define square-size (number->string (car list)))
  (define (to-html-row row)
    (cond ((eq? row '()) "<br>\n")
          (else (string-append
           "<img src='"
           (third (car row))
           "' width='"
           square-size
           "' height='"
           square-size
           "'>"
           (to-html-row (cdr row))))))
  (foldr string-append "" (map to-html-row (cdr list))))

(define (read-avg-rgb-vals file)
  (map
   (lambda (x) (my-eval (read (open-input-string x))))
   (file->lines file)))
