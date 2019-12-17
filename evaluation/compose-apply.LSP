;;;(include 'compose-apply "./evaluation/compose-apply")

;;;(compose-apply apply-Func1 apply-Func2)
;;;
;;;apply-Func1 : function symbol or list
;;;              function apply func & list of arguments.
;;;
;;;apply-Func2 : symbol of function or list
;;;              function apply func & list of arguments.
;;;
;;;return : function

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'default "./common/default")

(defun compose-apply (apply-Func1 apply-Func2 / func1 func2)
  (setq func1 (eval apply-Func1)
        func2 (eval apply-Func2)
  )
  (if (and func1 func2)
    (eval (list 'lambda
                '($_func $_args)
                (list (eval apply-Func1)
                      (list 'quote (list 'quote (eval apply-Func2)))
                      '(list $_func $_args)
                )
          )
    )
    (if func1
      func1
      func2
    )
  )
)
