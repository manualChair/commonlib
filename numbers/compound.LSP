;;;(include 'compound "./numbers/compound")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (compound 0 10 0) 
;;;0.0
;;;_$ (compound 0 10 1) 
;;;10.0
;;;_$ (compound 0 10 0.2) 
;;;2.0

(defun compound (number1 number2 ratio)
  (+ (* number1 (- 1.0 ratio)) (* number2 (float ratio)))
)
