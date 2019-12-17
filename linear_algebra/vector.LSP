;;;(include 'vector "./linear_algebra/vector")

;;;==================================================
;;;
;;;This module include below functions
;;;
;;;==================================================
;;;(vector dimension element value)
;;;--------------------------------------------------
;;;_$ (vector 5 1 3.0)
;;;(0.0 3.0 0.0 0.0 0.0)
;;;==================================================
;;;(vector:zerop vector)
;;;--------------------------------------------------
;;;_$ (vector:zerop '(1 0 0))
;;;nil
;;;_$ (vector:zerop '(0 0 0))
;;;T
;;;==================================================
;;;(vector:equal vector1 vector2)
;;;--------------------------------------------------
;;;_$ (vector:equal '(1 2 3) '(10 20 30))
;;;nil
;;;_$ (vector:equal '(10 20 30) '(10 20 30))
;;;T
;;;==================================================
;;;(vector:Add vector1 vector2)
;;;--------------------------------------------------
;;;_$ (vector:Add '(1 2 3) '(10 20 30))
;;;(11.0 22.0 33.0)
;;;==================================================
;;;(vector:Sub vector1 vector2)
;;;--------------------------------------------------
;;;_$ (vector:Sub '(1 2 3) '(10 20 30))
;;;(-9.0 -18.0 -27.0)
;;;==================================================
;;;(vector:Add-r vlist)
;;;--------------------------------------------------
;;;_$ (vector:Add-r (list '(1 2 3) '(10 20 30) '(100 200 300)))
;;;(111.0 222.0 333.0)
;;;==================================================
;;;(vector:Invert vector1)
;;;--------------------------------------------------
;;;_$ (vector:Invert '(1 1 0))
;;;(-1.0 -1.0 0.0)
;;;==================================================
;;;(vector:Scale vector1 a)
;;;--------------------------------------------------
;;;_$ (vector:Scale '(1 2 3) 10)
;;;(10.0 20.0 30.0)
;;;==================================================
;;;(vector:div vector1 a)
;;;--------------------------------------------------
;;;_$ (vector:div '(1 2 3) 10)
;;;(0.1 0.2 0.3)
;;;==================================================
;;;(vector:inverse vector1)
;;;--------------------------------------------------
;;;_$ (vector:inverse '(0 1 2))
;;;(0.0 1.0 0.5)
;;;==================================================
;;;(vector:InnerProduct vector1 vector2)
;;;--------------------------------------------------
;;;_$ (vector:InnerProduct '(1 1 0) '(0 1 1))
;;;1.0
;;;==================================================
;;;(vector:Size vector1)
;;;--------------------------------------------------
;;;_$ (vector:Size '(1 1 0))
;;;1.41421
;;;==================================================
;;;(vector:distance point1 point2)
;;;--------------------------------------------------
;;;_$ (vector:distance '(0 0 0) '(1 1 0))
;;;1.41421
;;;==================================================
;;;(vector:Unit vector)
;;;--------------------------------------------------
;;;_$ (vector:Unit '(1 1 0))
;;;(0.707107 0.707107 0.0)
;;;==================================================
;;;(vector:Angle v1 v2)
;;;--------------------------------------------------
;;;_$ (vector:Angle '(1 0 0) '(0 1 0))
;;;1.5708
;;;==================================================
;;;(vector:compound v1 v2 ratio)
;;;--------------------------------------------------
;;;_$ (vector:compound '(1 0 0) '(0 1 0) 0.4)
;;;(0.6 0.4 0.0)
;;;==================================================

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'recurse-binaryOperator "./evaluation/recurse-binOperator")
(include '*tolerance* "./common/tolerance")
(include 'compound "./numbers/compound")

(defun vector:arccos (value)
  (atan (sqrt (abs (- 1.0 (* value value)))) value)
)

(defun vector:create (counter)
  (if (< counter dimension)
    (cons (if (= element counter)
            (float value)
            0.0
          )
          (vector:create (1+ counter))
    )
  )
)

(defun vector (dimension element value) (vector:create 0))

(defun vector:zerop (vector1)
  (vl-every (function (lambda (element) (equal 0.0 element *tolerance*)))
            vector1
  )
)

(defun vector:equal (vector1 vector2) (equal vector1 vector2 *tolerance*))

(defun vector:Add:operation () (mapcar $func vector1 vector2))

(defun vector:Add (vector1 vector2 / $func)
  (setq $func '+)
  (vector:Add:operation)
)

;;;(setq v+ acet-geom-vector-add)

(defun vector:Sub (vector1 vector2 / $func)
  (setq $func '-)
  (vector:Add:operation)
)

(defun vector:Invert (vector1) (mapcar '- vector1))

(setq vector:Add-r (recurse-binaryOperator 'vector:Add))

(defun vector:Scale:operation ()
  (mapcar (function (lambda (e) ((eval $func) (float e) a))) vector1)
)

(defun vector:Scale (vector1 a / $func)
  (setq $func '*)
  (vector:Scale:operation)
)

;;;(setq v* acet-geom-vector-scale)

(defun vector:div (vector1 a / $func)
  (setq $func '/)
  (vector:Scale:operation)
)

(defun vector:inverse (vector1)
  (mapcar (function (lambda (e)
                      (if (equal 0.0 e *tolerance*)
                        0.0
                        (/ 1.0 e)
                      )
                    )
          )
          vector1
  )
)

(defun vector:InnerProduct (vector1 vector2)
  (apply '+ (mapcar '* vector1 vector2))
)

(defun vector:Size (vector1 /)
  (if (not (vector:zerop vector1))
    (sqrt (vector:InnerProduct vector1 vector1))
    0.0
  )
)

(defun vector:Distance (point1 point2)
  (vector:Size (vector:Sub point2 point1))
)

(defun vector:Unit (vector1 / size)
  (if (not (equal 0.0 (setq size (vector:Size vector1)) *tolerance*))
    (vector:div vector1 size)
  )
)

(defun vector:Angle (vector1 vector2 / l1 l2)
  (vector:arccos
    (/ (vector:InnerProduct vector1 vector2)
       (vector:Size vector1)
       (vector:Size vector2)
    )
  )
)

(defun vector:compound (vector1 vector2 ratio)
  (mapcar (function
            (lambda (element1 element2) (compound element1 element2 ratio))
          )
          vector1
          vector2
  )
)


