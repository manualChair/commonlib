;;;(include 'ceiling "./numbers/ceiling")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (ceiling 100 nil)
;;;100
;;;_$ (ceiling 1.6 nil)
;;;2
;;;_$ (ceiling -1.6 nil)
;;;-1
;;;_$ (ceiling 100 2)
;;;50
;;;_$ (ceiling 1.6 2)
;;;1
;;;_$ (ceiling -1.6 2)
;;;0

(include 'default "./common/default")
(include 'plusp "./numbers/plusp")

(defun ceiling (number divisor / quotient trunc)
  (setq quotient (/ number (float (default divisor 1))))
  (if (= (setq trunc (fix quotient)) quotient)
    trunc
    (+ trunc
       (if (plusp quotient)
         1
         0
       )
    )
  )
)
