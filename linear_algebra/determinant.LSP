;;;(include 'determinant "./linear_algebra/determinant")

;;;==================================================
;;;
;;; This module include below functions
;;;
;;;==================================================
;;;(determinant amatrix)
;;;--------------------------------------------------
;;;_$ (determinant '((2)))
;;;2
;;;_$ (determinant '((-4 1) (3 -2)))
;;;5
;;;_$ (determinant '((-4 1 -1) (3 -2 -2) (3 -3 5)))
;;;46
;;;_$ (determinant '((2 -3 5 0) (0 0 1 6) (0 3 2 -1) (0 0 -4 7)))
;;;-186
;;;_$ (determinant '((-4 3 -5 4) (2 2 3 8) (9 8 1 -2) (-5 -1 -8 2)))
;;;2356
;;;_$ (determinant '((-4 3 -5 4 1) (2 2 3 8 7) (9 8 1 -2 6) (-5 -1 -8 2 4) (6 8 5 2 -1)))
;;;-2678
;;;_$ (determinant '((1 1 3 3 4) (2 3 -1 3 2) (4 3 1 1 3) (-2 -2 2 1 -1) (1 2 -3 4 -4)))
;;;-41
;;;_$ (determinant '((1 1 3 3 4 5) (2 3 -1 3 2 4) (4 3 1 1 3 -3) (-2 -2 2 1 -1 2) (1 2 -3 4 -4 1) (2 -3 -4 -5 -1 4)))
;;;-481
;;;==================================================
;;;(cofactor amatrix i j)
;;;--------------------------------------------------
;;;_$ (cofactor '((1 2 3) (4 5 6) (7 8 9)) 1 2)
;;;6
;;;_$ (cofactor '((3 4 1 2) (7 5 6 7) (8 6 7 5) (1 3 2 2)) 1 2)
;;;17
;;;_$ (cofactor '((2 -3 5 0) (0 0 1 6) (0 3 2 -1) (0 0 -4 7)) 2 1)
;;;-62
;;;==================================================

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'defstruct "./structures/defstruct")
(include 'range "./conses/range")
(include 'thin-out-list "./sequences/thin-out-list")

(defstruct 'determinant:elem '((i . nil) (j . nil)))

(defun determinant:cofactor (i j)
  (* (expt -1 (+ i j))
     (determinant:main
       (make-determinant:elem
         (thin-out-list elem-i i (1+ i))
         (thin-out-list elem-j j (1+ j))
       )
     )
  )
)

(defun cofactor (amatrix i j / elem size elem-i elem-j)
  (setq elem   (lambda (i j) (nth (nth j elem-j) (nth (nth i elem-i) amatrix)))
        size   (length amatrix)
        elem-i (range 0 size 1)
        elem-j elem-i
  )
  (determinant:cofactor i j)
)

(defun determinant:sub ()
  (apply '+
         (mapcar
           (function (lambda (j) (* (elem 0 j) (determinant:cofactor 0 j))))
           (range 0 (length elem-j) 1)
         )
  )
)

(defun determinant:main (elem-s / elem-i elem-j size)
  (setq elem-i (determinant:elem-i elem-s)
        elem-j (determinant:elem-j elem-s)
        size   (length elem-i)
  )
  (cond
    ((= 1 size) (elem 0 0))
    ((= 2 size) (- (* (elem 0 0) (elem 1 1)) (* (elem 1 0) (elem 0 1))))
    ((= 3 size)
     (- (+ (* (elem 0 0) (elem 1 1) (elem 2 2))
           (* (elem 0 1) (elem 1 2) (elem 2 0))
           (* (elem 0 2) (elem 1 0) (elem 2 1))
        )
        (+ (* (elem 0 2) (elem 1 1) (elem 2 0))
           (* (elem 0 1) (elem 1 0) (elem 2 2))
           (* (elem 0 0) (elem 1 2) (elem 2 1))
        )
     )
    )
    (T (determinant:sub))
  )
)

(defun determinant (amatrix / elem size)
  (setq elem (lambda (i j) (nth (nth j elem-j) (nth (nth i elem-i) amatrix)))
        size (length amatrix)
  )
  (determinant:main
    (make-determinant:elem (range 0 size 1) (range 0 size 1))
  )
)
