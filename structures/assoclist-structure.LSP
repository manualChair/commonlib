;;;(include 'assoclist->structure "./structures/assoclist-structure")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'ALValue "./conses/ALValue")
(include 'concatenate "./sequences/concatenate")

(defun assoclist->structure (alist / structure-name)
  (if (setq structure-name (ALValue alist 'STRUCTURE))
    (apply
      (concatenate 'SYM (list 'make- structure-name))
      (mapcar (function (lambda (member-name) (ALValue alist member-name)))
              (cdr (vl-symbol-value structure-name))
      )
    )
    (exit)
  )
)