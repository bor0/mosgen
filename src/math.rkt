#lang racket
(provide avg-rgb calculate-least-distance)
(require (only-in 2htdp/image
                  color-red color-green color-blue))

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

(define (calculate-least-distance color-list colors-list)
  (car (foldl
        (lambda (item memo)
          (define distance (euclidean-distance color-list (cdr item)))
          (if
           (< distance (cdr memo))
           (cons (car item) distance)
           memo))
        (cons (car (car colors-list))
              (euclidean-distance color-list (cdr (car colors-list)))) ; assume first element is best
        (cdr colors-list))))
