;;;(include 'mod "./numbers/mod")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (mod 5 3) ;_ (3 * 1) + [ 2 ]
;;;2
;;;_$ (mod -5 3) ;_ (3 * 2) + [ 1 ]
;;;1
;;;_$ (rem -5 3) ;_ (3 * 1) + [ -2 ]
;;;-2

(include 'floor "./numbers/floor")

(defun mod (number1 number2)
  (- number1 (* (floor (/ (float number1) number2) nil) number2))
)
