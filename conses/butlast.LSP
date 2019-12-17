;;;(include 'butlast "./conses/butlast")

;;;(butlast alist n)
;;;
;;;alist : list
;;;
;;;n : integer (default 1)
;;;
;;;return : alist without last n elements.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (butlast '(0 1 2 3 4 5) 3)
;;;(0 1 2)
;;;_$ (butlast '(0 1 2 3 4 5) nil)
;;;(0 1 2 3 4)

(include 'default "./common/default")
(include 'integerp "./numbers/integerp")
(include 'nthcdr "./conses/nthcdr")

(defun butlast (alist n)
  (if (or (null n) (and (integerp n) (not (minusp n))))
    (progn (setq n (default n '1)) (reverse (nthcdr n (reverse alist))))
    (exit)
  )
)