;;;(include 'floor "./numbers/floor")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (floor 100 nil)
;;;100
;;;_$ (floor 1.6 nil)
;;;1
;;;_$ (floor -1.6 nil)
;;;-2
;;;_$ (floor 100 2)
;;;50
;;;_$ (floor 1.6 2)
;;;0
;;;_$ (floor -1.6 2)
;;;-1

(include 'default "./common/default")

(defun floor (number divisor / quotient trunc)
  (setq quotient (/ number (float (default divisor 1))))
  (if (= (setq trunc (fix quotient)) quotient)
    trunc
    (- trunc
       (if (minusp quotient)
         1
         0
       )
    )
  )
)
