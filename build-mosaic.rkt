#lang racket
(require (only-in 2htdp/image
                  bitmap/file))
(require "src/utils.rkt")
(require "src/mosaic.rkt")

; main
(begin
  (if (< (length (args)) 3)
      (begin
        (display "usage: build-mosaic.rkt <image file> <square size> <average RGB values>")
        (newline))
      (begin
        (display (to-html
                  (build-mosaic
                   (bitmap/file (first (args)))
                   (string->number (second (args)))
                   (read-avg-rgb-vals (third (args))))))
        (newline))))
