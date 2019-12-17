;;;(include 'plusp "./numbers/plusp")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun plusp (x)
  (if (numberp x)
    (< 0 x)
    (exit)
  )
)