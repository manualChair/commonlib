;;;(include 'set-ALValue "./conses/set-ALValue")

;;;(set-ALValue assoc-list key value)
;;;
;;;assoc-list : list
;;;
;;;key : atom or list
;;;
;;;value : atom or list
;;;
;;;return : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (set-ALValue '((PRICE . 100) (TYPE . APPLE)) 'PRICE 108)
;;;((PRICE . 108) (TYPE . APPLE))

(include 'acons "./conses/acons")

(defun set-ALValue (assoc-list key value / cell)
  (if (setq cell (assoc key assoc-list))
    (subst (cons key value) cell assoc-list)
    (acons key value assoc-list)
  )
)
