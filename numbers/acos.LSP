;;;(include 'acos "./numbers/acos")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun acos (value) (atan (sqrt (abs (- 1.0 (* value value)))) value))
