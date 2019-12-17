;;;(include '3DVector "./linear_algebra/3DVector")

;;;==================================================
;;;
;;; This module include below functions
;;;
;;;==================================================
;;;(3DVector x y z)
;;;--------------------------------------------------
;;;_$ (3DVector 1 2 3)
;;;(1.0 2.0 3.0)
;;;==================================================
;;;(3DVector:ref vector axis)
;;;--------------------------------------------------
;;;_$ (3DVector:ref (3DVector 1.0 2.0 3.0) 'Y) 
;;;2.0
;;;_$ (3DVector:ref (3DVector 1.0 2.0 3.0) 'Z) 
;;;3.0
;;;==================================================
;;;(3DVector:~ref vector axis)
;;;--------------------------------------------------
;;;_$ (3DVector:~ref (3DVector 1.0 2.0 3.0) 'X)
;;;(2.0 3.0)
;;;_$ (3DVector:~ref (3DVector 1.0 2.0 3.0) 'Y)
;;;(1.0 3.0)
;;;==================================================
;;;(3DVector:set-ref vector axis value)
;;;--------------------------------------------------
;;;_$ (3DVector:set-ref (3DVector 1.0 2.0 3.0) 'X 10.0)
;;;(10.0 2.0 3.0)
;;;==================================================
;;;(3DVector:CrossProduct vector1 vector2)
;;;--------------------------------------------------
;;;_$ (3DVector:CrossProduct (3DVector 1 0 0) (3DVector 0 1 0))
;;;(0.0 0.0 1.0)
;;;==================================================

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun 3DVector (x y z) (list (float x) (float y) (float z)))

(setq *000* (3DVector 0.0 0.0 0.0)
      *111* (3DVector 1.0 1.0 1.0)
      *100* (3DVector 1.0 0.0 0.0)
      *010* (3DVector 0.0 1.0 0.0)
      *001* (3DVector 0.0 0.0 1.0)
      *110* (3DVector 1.0 1.0 0.0)
      *011* (3DVector 0.0 1.0 1.0)
      *101* (3DVector 1.0 0.0 1.0)
)

(defun 3DVector:ref (vector axis)
  (cond ((= axis 'X) (car vector))
        ((= axis 'Y) (cadr vector))
        ((= axis 'Z) (caddr vector))
  )
)

(defun 3DVector:~ref (vector axis)
  (cond ((= axis 'X) (list (cadr vector) (caddr vector)))
        ((= axis 'Y) (list (car vector) (caddr vector)))
        ((= axis 'Z) (list (car vector) (cadr vector)))
  )
)

(defun 3DVector:set-ref (vector axis value)
  (cond ((= axis 'X) (list value (cadr vector) (caddr vector)))
        ((= axis 'Y) (list (car vector) value (caddr vector)))
        ((= axis 'Z) (list (car vector) (cadr vector) value))
  )
)

(defun 3DVector:CrossProduct (vector1 vector2)
  (if (not (equal:float vector1 vector2))
    (list
      (- (* (cadr vector1) (caddr vector2))
         (* (caddr vector1) (cadr vector2))
      )
      (- (* (caddr vector1) (car vector2))
         (* (car vector1) (caddr vector2))
      )
      (- (* (car vector1) (cadr vector2)) (* (cadr vector1) (car vector2)))
    )
    (exit)
  )
)
