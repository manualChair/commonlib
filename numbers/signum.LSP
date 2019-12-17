;;;(include 'signum "./numbers/signum")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (signum 2.5)
;;;1.0
;;;_$ (signum 0.0)
;;;0.0
;;;_$ (signum -2.5)
;;;-1.0
;;;_$ (signum 2)
;;;1

(include 'coerce "./types/coerce")
(include 'type-of "./types/type-of")

(defun signum (number)
  (if (numberp number)
    (coerce (cond ((< 0 number) 1)
                  ((< number 0) -1)
                  (T 0)
            )
            (type-of number)
    )
    (exit)
  )
)