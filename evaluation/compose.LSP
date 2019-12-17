;;;(include 'compose "./evaluation/compose")

;;;(compose arg-func1 arg-func2)
;;;
;;;arg-func1 : function symbol or list
;;;            function apply single argment.
;;;
;;;arg-func2 : function symbol or list
;;;            function apply single argment.
;;;
;;;return : function

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun compose (arg-func1 arg-func2 / func1 func2)
  (setq func1 (eval arg-func1)
        func2 (eval arg-func2)
  )
  (if (and func1 func2)
    (eval (list 'lambda '($_item) (list func2 (list func1 '$_item))))
    (if func1
      func1
      func2
    )
  )
)
