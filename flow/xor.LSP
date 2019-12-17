;;;(include 'xor "./flow/xor")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun xor (expr1 expr2)
  (or (and (not expr1) expr2)
      (and expr1 (not expr2))
  )
)