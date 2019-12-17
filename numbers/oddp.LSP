;;;(include 'oddp "./numbers/oddp")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (oddp 1)
;;;T
;;;_$ (oddp 2)
;;;nil
;;;_$ (oddp -1)
;;;T

(include 'integerp "./numbers/integerp")

(defun oddp (integer)
  (if (integerp integer)
    (not (zerop (logand integer 1)))
    (exit)
  )
)