;;;(include 'acosh "./numbers/acosh")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun acosh (y)
  (log (+ y (sqrt (- (expt y 2.0) 1.0))))
)