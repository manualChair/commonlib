;;;(include 'set-difference "./conses/set-difference")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (set-difference '(a b c d e) '(b e) nil)
;;;(A C D)

(include 'functionp "./flow/functionp")

(defun set-difference (minuend subtrahend test-func)
  (if (functionp (eval (setq test-func (default test-func ''eq))))
    (vl-remove-if
      (function
        (lambda (item)
          (vl-member-if
            (function
              (lambda (sub-item) (apply test-func (list item sub-item)))
            )
            subtrahend
          )
        )
      )
      minuend
    )
    (exit)
  )
)