;;;(include 'transformation-matrix "./linear_algebra/transformation-matrix")

;;;==================================================
;;;
;;;This module include below functions
;;;
;;;==================================================
;;;(translation-matrix origin)
;;;--------------------------------------------------
;;;_$ (translation-matrix '(10.0 20.0 30.0))
;;;((1.0 0.0 0.0 10.0) (0.0 1.0 0.0 20.0) (0.0 0.0 1.0 30.0) (0.0 0.0 0.0 1.0))
;;;==================================================
;;;(scale-matrix scale)
;;;--------------------------------------------------
;;;_$ (scale-matrix '(1.0 2.0 3.0))
;;;((1.0 0.0 0.0 0.0) (0.0 2.0 0.0 0.0) (0.0 0.0 3.0 0.0) (0.0 0.0 0.0 1.0))
;;;==================================================
;;;(rotate-matrix:X-axis radian)
;;;--------------------------------------------------
;;;_$ (rotate-matrix:X-axis (/ PI 4))
;;;((1.0 0.0 0.0 0.0) (0.0 0.707107 -0.707107 0.0) (0.0 0.707107 0.707107 0.0) (0.0 0.0 0.0 1.0))
;;;==================================================
;;;(rotate-matrix:Y-axis radian)
;;;--------------------------------------------------
;;;_$ (rotate-matrix:Y-axis (/ PI 4))
;;;((0.707107 0.0 0.707107 0.0) (0.0 1.0 0.0 0.0) (-0.707107 0.0 0.707107 0.0) (0.0 0.0 0.0 1.0))
;;;==================================================
;;;(rotate-matrix:Z-axis radian)
;;;--------------------------------------------------
;;;_$ (rotate-matrix:Z-axis (/ PI 4))
;;;((0.707107 -0.707107 0.0 0.0) (0.707107 0.707107 0.0 0.0) (0.0 0.0 1.0 0.0) (0.0 0.0 0.0 1.0))
;;;==================================================
;;;(transformation-matrix origin rotation scale)
;;;--------------------------------------------------
;;;_$ (transformation-matrix '(10.0 20.0 30.0) (list (/ PI 3) (/ PI 4) (/ PI 6)) '(1.0 2.0 3.0))
;;;((0.612372 -0.707107 2.12132 10.0) (0.78033 0.253653 -1.83712 20.0) (0.126826 1.85355 1.06066 30.0) (0.0 0.0 0.0 1.0))
;;;==================================================
;;;(transformation-matrix:element amatrix e)
;;;--------------------------------------------------
;;;_$ (transformation-matrix:element *m-e* 'X)
;;;(1.0 0.0 0.0)
;;;_$ (transformation-matrix:element *m-e* 'Y)
;;;(0.0 1.0 0.0)
;;;_$ (transformation-matrix:element *m-e* 'O)
;;;(0.0 0.0 0.0)
;;;==================================================
;;;(make-transformation-matrix origin x-axis y-axis)
;;;--------------------------------------------------
;;;_$ (make-transformation-matrix '(0.0 0.0 0.0) '(0.0 1.0 0.0) '(-1.0 0.0 0.0))
;;;((0.0 -1.0 0.0 0.0) (1.0 0.0 0.0 0.0) (0.0 0.0 1.0 0.0) (0.0 0.0 0.0 1.0))
;;;==================================================

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'subseq "./sequences/subseq")
(include 'vector "./linear_algebra/vector")
(include 'matrix "./linear_algebra/matrix")

(setq *m-e* (matrix:Identity 4))

(defun translation-matrix (origin /)
  (list (list 1.0 0.0 0.0 (float (nth 0 origin)))
        (list 0.0 1.0 0.0 (float (nth 1 origin)))
        (list 0.0 0.0 1.0 (float (nth 2 origin)))
        '(0.0 0.0 0.0 1.0)
  )
)

(defun scale-matrix (scale /)
  (if (vl-every 'zerop scale)
    nil
    (list (list (float (nth 0 scale)) 0.0 0.0 0.0)
          (list 0.0 (float (nth 1 scale)) 0.0 0.0)
          (list 0.0 0.0 (float (nth 2 scale)) 0.0)
          (list 0.0 0.0 0.0 1.0)
    )
  )
)

(defun rotate-matrix:X-axis (radian /)
  (list '(1.0 0.0 0.0 0.0)
        (list 0.0 (cos radian) (- (sin radian)) 0.0)
        (list 0.0 (sin radian) (cos radian) 0.0)
        '(0.0 0.0 0.0 1.0)
  )
)

(defun rotate-matrix:Y-axis (radian /)
  (list (list (cos radian) 0.0 (sin radian) 0.0)
        '(0.0 1.0 0.0 0.0)
        (list (- (sin radian)) 0.0 (cos radian) 0.0)
        '(0.0 0.0 0.0 1.0)
  )
)

(defun rotate-matrix:Z-axis (radian /)
  (list (list (cos radian) (- (sin radian)) 0.0 0.0)
        (list (sin radian) (cos radian) 0.0 0.0)
        '(0.0 0.0 1.0 0.0)
        '(0.0 0.0 0.0 1.0)
  )
)

;;

(setq *transformation-matrix:rotationOrder*
       'xyz
      *transformation-matrix:rotationOrderList*
       '(XYZ XZY YXZ YZX ZXY ZYX)
      *transformation-matrix:rotationFunctions*
       (mapcar
         (function
           (lambda (index)
             (nth
               index
               '((rotate-matrix:X-axis
                  .
                  0
                 )
                 (rotate-matrix:Y-axis
                  .
                  1
                 )
                 (rotate-matrix:Z-axis
                  .
                  2
                 )
                )
             )
           )
         )
         (nth
           (vl-position
             *transformation-matrix:rotationOrder*
             *transformation-matrix:rotationOrderList*
           )
           '((0 1 2)
             (0 2 1)
             (1 0 2)
             (1 2 0)
             (2 0 1)
             (2 1 0)
            )
         )
       )
)

(defun transformation-matrix:rotation:sub (flist / funcInfo value)
  (if flist
    (progn
      (setq funcInfo (car flist))
      (if
        (equal 0.0 (setq value (nth (cdr funcInfo) rotation)) *tolerance*)
         (transformation-matrix:rotation:sub (cdr flist))
         (cons ((eval (car funcInfo)) value)
               (transformation-matrix:rotation:sub (cdr flist))
         )
      )
    )
  )
)

(defun transformation-matrix:rotation (rotation)
  (matrix:Product-r
    (transformation-matrix:rotation:sub
      *transformation-matrix:rotationFunctions*
    )
  )
)

(defun transformation-matrix (origin rotation scale)
  (matrix:Product-r
    (append (if (not (vector:zerop origin))
              (list (translation-matrix origin))
            )
            (if (not (vector:zerop rotation))
              (list (transformation-matrix:rotation rotation))
            )
            (list (scale-matrix scale))
    )
  )
)

;;

(defun transformation-matrix:element (amatrix e /)
  (subseq (matrix:column
            amatrix
            (vl-position
              (if (= (type e) 'STR)
                (read e)
                e
              )
              '(X Y Z O)
            )
          )
          0
          3
  )
)

;;

(defun make-transformation-matrix
       (origin x-axis y-axis / x-axis-u y-axis-u)
  (setq x-axis-u (vector:unit x-axis)
        y-axis-u (vector:unit y-axis)
  )
  (append (matrix:Transpose
            (list x-axis-u
                  y-axis-u
                  (3DVector:CrossProduct x-axis-u y-axis-u)
                  origin
            )
          )
          '((0.0 0.0 0.0 1.0))
  )
)