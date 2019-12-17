;;;(include 'asin "./numbers/asin")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun asin (num) (atan num (sqrt (abs (- 1.0 (* num num))))))
