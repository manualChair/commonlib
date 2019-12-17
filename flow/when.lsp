;;;(include 'when "./flow/when")

;;;(when value expression)
;;;
;;;value : atom or list
;;;
;;;expression : expression
;;;
;;;return : If value is not nil, this return (eval expression).
;;;         In other cases, This return nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun when (value expression)
  (if value
    (eval expression)
  )
)