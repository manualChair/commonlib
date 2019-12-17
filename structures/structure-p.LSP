;;;(include 'structure-p "./structures/structure-p")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun structure-p (item / temp)
  (and (vl-consp item)
       (= (type (car item)) 'SYM)
       (vl-consp (setq temp (eval (car item))))
       (= (car temp) 'structure)
  )
)
