#lang racket
(require 2htdp/image)
(require "src/math.rkt")
(require "src/utils.rkt")

; main
(begin
  (if (< (length (args)) 1)
      (begin
        (display "usage: avg-rgb.rkt <image file>")
        (newline))
      (begin
        (print (cons
                (car (args))
                (avg-rgb (image->color-list (bitmap/file (car (args)))))))
        (newline))))
