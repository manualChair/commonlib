;;;(include 'last-cons "./conses/last-cons")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (last-cons '(a b c d) 1)
;;;(D)
;;;_$ (last-cons '(a b c d) 2)
;;;(C D)
;;;_$ (last-cons '(a b c d) 0)
;;;nil
;;;_$ (last-cons '(a b c d . e) 1)
;;;(D . E)
;;;_$ (last-cons '(a b c d . e) 2)
;;;(C D . E)
;;;_$ (last-cons '(a b c d . e) 0)
;;;E

(include 'default "./common/default")
(include 'integerp "./numbers/integerp")

(defun last-cons:sub (alist / temp)
  (if (vl-consp alist)
    (progn (setq temp (last-cons:sub (cdr alist)))
           (if (< count n)
             (progn (setq count (1+ count)) (cons (car alist) temp))
             temp
           )
    )
    (progn (setq count 0) alist)
  )
)

(defun last-cons (alist n / count)
  (setq n (default n '1))
  (if (and (integerp n) (not (minusp n)))
    (last-cons:sub alist)
    (exit)
  )
)