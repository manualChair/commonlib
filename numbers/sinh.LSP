;;;(include 'sinh "./numbers/sinh")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun sinh (x)
  (/ (- (exp x) (exp (- x))) 2.0)
)
