;;;(include 'transform "./linear_algebra/transform")

;;;==================================================
;;;
;;;This module include below functions
;;;
;;;==================================================
;;;(transform amatrix pt displacement)
;;;--------------------------------------------------
;;;_$ (setq m (matrix:Inverse (translation-matrix '(100.0 100.0 100.0))))
;;;((1.0 0.0 0.0 -100.0) (0.0 1.0 0.0 -100.0) (0.0 0.0 1.0 -100.0) (0.0 0.0 0.0 1.0))
;;;_$ (transform m '(100.0 100.0 100.0) nil)
;;;(0.0 0.0 0.0)
;;;_$ (transform m '(100.0 100.0 100.0) T)
;;;(100.0 100.0 100.0)
;;;==================================================

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'subseq "./sequences/subseq")
(include 'vector "./linear_algebra/vector")

(defun transform:displacement (vector)
  (mapcar (function (lambda (row) (vector:InnerProduct row vector)))
          (subseq amatrix 0 (1- (length amatrix)))
  )
)

(defun transform:coordinate:adjust (size)
  (if (< size dimension)
    (cons 0.0 (transform:coordinate:adjust (1+ size)))
    (list 1.0)
  )
)

(defun transform:coordinate (point / dimension a)
  (setq dimension (1- (length (car amatrix)))
        a         (append point (transform:coordinate:adjust (length point)))
  )
  (mapcar (function (lambda (row) (vector:InnerProduct row a)))
          (subseq amatrix 0 (1- (length amatrix)))
  )
)

(defun transform (amatrix pt displacement)
  (if (and (vl-consp amatrix) (vl-consp pt))
    (if displacement
      (transform:displacement pt)
      (transform:coordinate pt)
    )
    (exit)
  )
)
