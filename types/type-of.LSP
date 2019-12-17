;;;(include 'type-of "./types/type-of")

;;;(type-of item)
;;;
;;;item : atom or list
;;;
;;;return : Data-type symbol of item

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'structure-p "./structures/structure-p")

(defun type-of (item / atype)
  (setq atype (type item))
  (cond ((= atype 'LIST)
         (if (structure-p item)
           (car item)
           atype
         )
        )
        (T atype)
  )
)
