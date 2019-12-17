;;;(include 'truncate "./numbers/truncate")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (truncate 100 nil)
;;;100
;;;_$ (truncate 1.6 nil)
;;;1
;;;_$ (truncate -1.6 nil)
;;;-1
;;;_$ (truncate 100 2)
;;;50
;;;_$ (truncate 1.6 2)
;;;0
;;;_$ (truncate -1.6 2)
;;;0

(include 'default "./common/default")

(defun truncate (number divisor / quotient trunc)
  (fix (/ number (float (default divisor 1))))
)
