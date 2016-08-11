#lang racket
(require (only-in 2htdp/image
                  bitmap/file image->color-list))
(require (only-in "src/math.rkt"
                  avg-rgb))
(require (only-in "src/utils.rkt"
                  args find-files-recursively))

; main
(begin
  (if (< (length (args)) 1)
      (begin
        (display "usage: avg-rgb.rkt <images folder>")
        (newline))
      (begin
        (for ([f (find-files-recursively (car (args)))])
          (print (cons (path->string f) (avg-rgb (image->color-list (bitmap/file f)))))
          (newline)))))
