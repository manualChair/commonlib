;;;(include 'subst-if "./conses/subst-if")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (subst-if nil '(lambda (x) (and (numberp x) (zerop (rem x 2)))) '(0 1 2 3 4 5 6))
;;;(nil 1 nil 3 nil 5 nil)
;;;_$ (subst-if nil '(lambda (x) (and (numberp x) (zerop (rem x 2)))) '(0 1 (2 3) 4 (5 6)))
;;;(nil 1 (nil 3) nil (5 nil))

(include 'endp "./conses/endp")

(defun subst-if:sub ($_item)
  (cond ((atom $_item)
         (if (apply $_predicate (list $_item))
           $_new-item
           $_item
         )
        )
        ((apply $_predicate (list $_item))
         $_new-item
        )
        (T (cons (subst-if:sub (car $_item)) (subst-if:sub (cdr $_item))))
  )
)

(defun subst-if ($_new-item $_predicate $_tree-list)
  (subst-if:sub $_tree-list)
)
