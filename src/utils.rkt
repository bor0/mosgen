#lang racket
(require "mosaic.rkt")
(provide args find-files-recursively to-html read-avg-rgb-vals)

; TODO: Remove this eval and think of a better structure
(define-namespace-anchor anc)
(define ns (namespace-anchor->namespace anc))

(define my-eval
  (let ((ns (make-base-namespace)))
    (parameterize ((current-namespace ns))
      (namespace-require 'racket/bool))
    (lambda (expr) (eval expr ns))))
; eval

(define (args) (vector->list (current-command-line-arguments)))

(define (find-files-recursively directory)
  (for/list ([f (in-directory directory)] #:when (regexp-match? "\\.gif$" f))
    f))

(define (to-html the-mosaic)
  (define square-size (number->string (mosaic-size the-mosaic)))
  (define (to-html-row row)
    (cond ((eq? row '()) "<br>\n")
          (else (string-append
                 (format "<img src='~a' width='~a' height='~a'>" (mosaic-coord-file (car row)) square-size square-size)
                 (to-html-row (cdr row))))))
  (foldr string-append "" (map to-html-row (mosaic-data the-mosaic))))

(define (read-avg-rgb-vals file)
  (map
   (lambda (x) (my-eval (read (open-input-string x))))
   (file->lines file)))
