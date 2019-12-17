;;;(include 'structure->assoclist "./structures/structure-assoclist")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'structure-p "./structures/structure-p")

(defun structure->assoclist (structure)
  (if (structure-p structure)
    (mapcar 'cons (eval (car structure)) structure)
    (exit)
  )
)
