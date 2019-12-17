;;;(include 'matrix "./linear_algebra/matrix")

;;;==================================================
;;;
;;; This module include below functions
;;;
;;;==================================================
;;;(matrix v1 [v2 ...] )
;;;--------------------------------------------------
;;;_$ (matrix (vector 4 0 1.0) (vector 4 2 3.0))
;;;((1.0 0.0 0.0 0.0) (0.0 0.0 3.0 0.0))
;;;==================================================
;;;(matrix:equal amatrix1 amatrix2)
;;;--------------------------------------------------
;;;_$ (matrix:equal '((1 2) (3 4)) '((1 2) (0 4)))
;;;nil
;;;==================================================
;;;(matrix:row amatrix m)
;;;--------------------------------------------------
;;;_$ (matrix:row '((1 2) (3 4)) 1)
;;;(3 4)
;;;==================================================
;;;(matrix:column amatrix n)
;;;--------------------------------------------------
;;;_$ (matrix:column '((1 2) (3 4)) 1)
;;;(2 4)
;;;==================================================
;;;(matrix:Transpose amatrix)
;;;--------------------------------------------------
;;;_$ (matrix:Transpose '((1 2) (3 4)))
;;;((1 3) (2 4))
;;;==================================================
;;;(matrix:Add amatrix1 amatrix2)
;;;--------------------------------------------------
;;;_$ (matrix:Add '((1 2) (3 4)) '((10 20) (30 40)))
;;;((11 22) (33 44))
;;;==================================================
;;;(matrix:Sub amatrix1 amatrix2)
;;;--------------------------------------------------
;;;_$ (matrix:Sub '((1 2) (3 4)) '((10 20) (30 40)))
;;;((-9 -18) (-27 -36))
;;;==================================================
;;;(matrix:Add-r mlist)
;;;--------------------------------------------------
;;;_$ (matrix:Add-r '(((1 2) (3 4)) ((10 20) (30 40)) ((100 200) (300 400))))
;;;((111 222) (333 444))
;;;==================================================
;;;(matrix:Invert amatrix)
;;;--------------------------------------------------
;;;_$ (matrix:Invert '((1 2) (3 4)))
;;;((-1 -2) (-3 -4))
;;;==================================================
;;;(matrix:Scale amatrix a)
;;;--------------------------------------------------
;;;_$ (matrix:Scale '((1 2) (3 4)) 2)
;;;((2.0 4.0) (6.0 8.0))
;;;==================================================
;;;(matrix:Identity size)
;;;--------------------------------------------------
;;;_$ (matrix:Identity 3)
;;;((1.0 0.0 0.0) (0.0 1.0 0.0) (0.0 0.0 1.0))
;;;==================================================
;;;(matrix:Product amatrix1 amatrix2)
;;;--------------------------------------------------
;;;_$ (matrix:Product '((1 -1) (-2 3)) '((1 2) (3 4)))
;;;((-2 -2) (7 8))
;;;==================================================
;;;(matrix:Product-r mlist)
;;;--------------------------------------------------
;;;_$ (matrix:Product-r '(((1 -1) (-2 3)) ((1 2) (3 4)) ((1 0) (0 1))))
;;;((-2 -2) (7 8))
;;;==================================================

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'apply-partial "./evaluation/apply-partial")
(include 'recurse-binaryOperator "./evaluation/recurse-binOperator")
(include 'equal:float "./common/float_equal")
(include 'vector "./linear_algebra/vector")
(include 'range "./conses/range")

(setq matrix list)

(defun matrix:equal (amatrix1 amatrix2) (equal:float m1 m2))

(defun matrix:row (amatrix m) (nth m amatrix))

(defun matrix:column (amatrix n)
  (mapcar (function (lambda (row) (nth n row))) amatrix)
)

(defun matrix:Transpose (amatrix)
  (mapcar '(apply-partial 'matrix:column (list amatrix) '(2))
          (range 0 (apply 'min (mapcar 'length amatrix)) 1)
  )
)

(defun matrix:Add (amatrix1 amatrix2)
  (mapcar 'vector:Add amatrix1 amatrix2)
)

(defun matrix:Sub (amatrix1 amatrix2)
  (mapcar 'vector:Sub amatrix1 amatrix2)
)

(defun matrix:Invert (amatrix) (mapcar 'vector:Invert amatrix))

(setq matrix:Add-r (recurse-binaryOperator matrix:Add))

(defun matrix:Scale (amatrix a)
  (mapcar '(apply-partial vector:Scale (list a) '(1)) amatrix)
)

(defun matrix:Identity (size)
  (mapcar '(apply-partial 'vector (list size 1.0) '(2))
          (range 0 size 1)
  )
)

(defun matrix:Product (amatrix1 amatrix2 / tmatrix2)
  (setq tmatrix2 (matrix:Transpose amatrix2))
  (mapcar
    (function
      (lambda (row)
        (mapcar
          (function (lambda (column) (vector:InnerProduct row column)))
          tmatrix2
        )
      )
    )
    amatrix1
  )
)

(setq matrix:Product-r (recurse-binaryOperator 'matrix:Product))

