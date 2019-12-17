;;;(include 'evenp "./numbers/evenp")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (evenp 1)
;;;nil
;;;_$ (evenp 2)
;;;T
;;;_$ (evenp -1)
;;;nil

(include 'integerp "./numbers/integerp")

(defun evenp (integer)
  (if (integerp integer)
    (zerop (logand integer 1))
    (exit)
  )
)