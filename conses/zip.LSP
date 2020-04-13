;;;(include 'zip "./conses/zip")

;;;(zip list-alist)
;;;
;;;list-alist : list ex. '((A B C) (1 2 3))
;;;
;;;return : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (zip '((1 2 3) (A B C)))
;;;((1 A) (2 B) (3 C))
;;;_$ (zip '((1 2 3) (A B C) ("a" "b" "c")))
;;;((1 A "a") (2 B "b") (3 C "c"))

(defun zip (list-alist) (apply 'mapcar (cons 'list list-alist)))
