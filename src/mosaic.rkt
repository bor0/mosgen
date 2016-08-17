#lang racket
(provide build-mosaic (struct-out mosaic) (struct-out mosaic-coord))
(require (only-in "math.rkt"
                  avg-rgb calculate-least-distance))
(require (only-in 2htdp/image
                  image->color-list crop rotate image-width image-height))

(define-struct mosaic (size data) #:transparent)
(define-struct mosaic-coord (i j file))

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
        (make-mosaic-coord i j (calculate-mosaic-distance image square-size avg-rgbs j i)))))
  
  (make-mosaic square-size mosaic))
