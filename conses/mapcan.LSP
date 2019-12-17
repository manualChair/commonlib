;;;(include 'mapcan "./conses/mapcan")

;;;(mapcan func list-alist)
;;;
;;;func : list of function symbol or list
;;;
;;;list-alist : list of list. ex. '((A B C) (1 2 3))
;;;
;;;retrun : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (mapcan 'list '((A B C) (1 2 3)))
;;;(A 1 B 2 C 3)

(defun mapcan (func list-alist)
  (apply 'append (apply 'mapcar (cons func list-alist)))
)