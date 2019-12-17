;;;(include 'subst-tree "./conses/subst-tree")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (subst-tree nil 1 '(0 1 1 0 1 1 2) nil)
;;;(0 nil nil 0 nil nil 2)
;;;_$ (subst-tree nil 1 '(0 1 (1 0) 1 (1 2)) nil)
;;;(0 nil (nil 0) nil (nil 2))
;;;_$ (subst-tree '(5 . A) '(5 . B) '((1 . #) (5 . B) (10 . #)) 'equal)
;;;((1 . #) (5 . A) (10 . #))
;;;_$ (subst-tree nil 1 '(0 1 2 A 6) '(lambda (olditem x) (and (numberp x) (< olditem x))))
;;;(0 1 nil A nil)

(include 'functionp "./flow/functionp")
(include 'subst-if "./conses/subst-if")

(defun subst-tree (newitem olditem tree-list test-func)
  (if (functionp (eval (setq test-func (default test-func ''eq))))
    (subst-if
      newitem
      (function
        (lambda (test-item) (apply test-func (list olditem test-item)))
      )
      tree-list
    )
    (exit)
  )
)