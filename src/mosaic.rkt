#lang racket
(provide build-mosaic)
(require 2htdp/image)
(require "math.rkt")

(define (calculate-mosaic-distance image square-size avg-rgbs x y)
  (define the-avg-rgb
    (avg-rgb
     (image->color-list (crop
                         (* x square-size)
                         (* y square-size)
                         square-size
                         square-size
                         image))))
  (car (calculate-least-distance (calculate-all-distances the-avg-rgb avg-rgbs))))

(define (build-mosaic image square-size avg-rgbs)
  (set! image (rotate 90 image))

  (define horiz-bound (ceiling (/ (image-width image) square-size)))
  (define vert-bound (ceiling (/ (image-height image) square-size)))
  (define ret '())

  (for ([i horiz-bound])
    (define tmp '())
    (for ([j vert-bound])
      (set! tmp
            (cons (list i j (calculate-mosaic-distance image square-size avg-rgbs i j))
                  tmp)))
    (set! ret (cons tmp ret)))

  (cons square-size (reverse ret)))
