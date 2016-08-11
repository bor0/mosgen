#lang racket
(provide build-mosaic)
(require "math.rkt")
(require (only-in 2htdp/image
                  image->color-list crop rotate image-width image-height))

(define (calculate-mosaic-distance image square-size avg-rgbs x y)
  (define the-avg-rgb
    (avg-rgb
     (image->color-list (crop
                         (* x square-size)
                         (* y square-size)
                         square-size
                         square-size
                         image))))
  (calculate-least-distance the-avg-rgb avg-rgbs))

(define (build-mosaic image square-size avg-rgbs)
  (define horiz-bound (ceiling (/ (image-width image) square-size)))
  (define vert-bound (ceiling (/ (image-height image) square-size)))
  (define mosaic
    (for/list ([i vert-bound])
      (for/list ([j horiz-bound])
        (list i j (calculate-mosaic-distance image square-size avg-rgbs j i)))))
  
  (cons square-size mosaic))
