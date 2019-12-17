;;;(include 'matrix:Inverse "./linear_algebra/matrix_Inverse-Cofactor")

;;;==================================================
;;;
;;;This module include below functions
;;;
;;;==================================================
;;;(matrix:Inverse-Cofactor amatrix)
;;;(matrix:Inverse amatrix)
;;;--------------------------------------------------
;;;_$ (matrix:Inverse-Cofactor '((1 2) (1 3)))
;;;((3.0 -2.0) (-1.0 1.0))
;;;_$ (matrix:Inverse-Cofactor '((2 0 1) (1 2 2) (4 0 1)))
;;;((-0.5 0.0 0.5) (-1.75 0.5 0.75) (2.0 0.0 -1.0))
;;;==================================================

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'range "./conses/range")
(include 'vector "./linear_algebra/vector")
(include 'matrix "./linear_algebra/matrix")
(include 'determinant "./linear_algebra/determinant")

;;	Cofactor matrix

(defun matrix:CofactorMatrix (amatrix / ilist)
  (setq ilist (range 0 (length amatrix) 1))
  (matrix:Transpose
    (mapcar
      (function
        (lambda (i)
          (mapcar '(apply-partial 'Cofactor (list amatrix i) '(3)) ilist)
        )
      )
      ilist
    )
  )
)

;;	Inverse matrix (Cofactor)

(defun matrix:Inverse-Cofactor (amatrix / det)
  (if (not (equal 0.0 (setq det (determinant amatrix)) *tolerance*))
    (mapcar (function (lambda (row) (vector:div row det)))
            (matrix:CofactorMatrix amatrix)
    )
  )
)

(setq matrix:Inverse matrix:Inverse-Cofactor)