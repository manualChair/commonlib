;;;(include 'organizeGroup "./conses/organizeGroup")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (organizeGroup '(0 1 2 3 4 5 6 7 8 9) 3 nil)
;;;((0 1 2) (3 4 5) (6 7 8))
;;;_$ (organizeGroup '(0 1 2 3 4 5 6 7 8 9) 3 T)
;;;((0 1 2) (3 4 5) (6 7 8) (9))

(defun organizeGroup:main (alist / stock)
  (if (and (not (null alist)) (<= capacity (length alist)))
    (progn (repeat capacity
             (setq stock (cons (car alist) stock)
                   alist (cdr alist)
             )
           )
           (cons (reverse stock) (organizeGroup:main alist))
    )
    (if remnant (list alist))
  )
)

(defun organizeGroup (alist capacity remnant) (organizeGroup:main alist))
