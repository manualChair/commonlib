;;;(include 'adjoin "./conses/adjoin")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (adjoin 'b '(a b c) nil)
;;;(A B C)
;;;_$ (adjoin 'z '(a b c) nil)
;;;(Z A B C)

(include 'functionp "./flow/functionp")

(defun adjoin (newItem alist test-func)
  (if (functionp (eval (setq test-func (default test-func ''eq))))
    (if (vl-member-if
          (function (lambda (item) (apply test-func (list newItem item))))
          alist
        )
      alist
      (cons newItem alist)
    )
    (exit)
  )
)