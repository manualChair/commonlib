;;;(include 'atanh "./numbers/atanh")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun atanh (y) (/ (log (/ (+ 1.0 y) (- 1.0 y))) 2.0))
