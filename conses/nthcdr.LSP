;;;(include 'nthcdr "./conses/nthcdr")

;;;(nthcdr n alist)
;;;
;;;n : integer (default 1)
;;;
;;;alist : list
;;;
;;;return : equivalent to calling cdr n times.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (nthcdr 2 '(0 1 2 3 4 5))
;;;(2 3 4 5)

(include 'integerp "./numbers/integerp")
(include 'endp "./conses/endp")

(defun nthcdr:sub (n alist)
  (if (and (< 0 n) (not (endp alist)))
    (nthcdr:sub (1- n) (cdr alist))
    alist
  )
)

(defun nthcdr (n alist)
  (if (and (integerp n) (not (minusp n)) (listp alist))
    (nthcdr:sub n alist)
    (exit)
  )
)