;;;(include 'intersection "./conses/intersection")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (intersection '(a b c) '(b b c) nil)
;;;(B C)

(defun intersection (alist1 alist2 test-func)
  (if (functionp (eval (setq test-func (default test-func ''eq))))
    (vl-remove-if-not
      (function
        (lambda (item)
          (vl-member-if
            (function
              (lambda (sub-item) (apply test-func (list item sub-item)))
            )
            alist2
          )
        )
      )
      alist1
    )
    (exit)
  )
)