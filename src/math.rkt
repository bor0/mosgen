#lang racket
(provide avg-rgb calculate-all-distances calculate-least-distance)
(require 2htdp/image)

(define (avg-rgb color-list)
  (let ((length-color-list (length color-list)))
    (map (lambda (x) (/ x length-color-list))
         (foldl (lambda (current-color result)
                  (list (+ (color-red current-color) (first result))
                        (+ (color-green current-color) (second result))
                        (+ (color-blue current-color) (third result))))
                '(0.0 0.0 0.0)
                color-list))))

(define (square x) (* x x))

(define (euclidean-distance first-color second-color)
  (define (euclidean-distance-iter sum first-color second-color)
    (cond
      ((eq? first-color '()) (sqrt sum))
      (else (euclidean-distance-iter
             (+ sum (square (- (car first-color) (car second-color))))
             (cdr first-color)
             (cdr second-color)))))
  (euclidean-distance-iter 0 first-color second-color))

(define (calculate-all-distances color-list colors-list)
  (map (lambda (x)
         (cons (car x) (euclidean-distance color-list (cdr x)))) colors-list))

(define (calculate-least-distance all-distances)
  (car (sort all-distances (lambda (x y) (< (cdr x) (cdr y))))))
