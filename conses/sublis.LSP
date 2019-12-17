;;;(include 'sublis "./conses/sublis")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (sublis '((old . new) (1 . #)) '(old 1 knowledge in (old 1 milk can)) nil)
;;;(NEW # KNOWLEDGE IN (NEW # MILK CAN))

(include 'subst-tree "./conses/subst-tree")

(defun sublis (assoc-list tree-list test-func / cell)
  (foreach cell assoc-list
    (setq tree-list (subst-tree (cdr cell) (car cell) tree-list test-func))
  )
  tree-list
)