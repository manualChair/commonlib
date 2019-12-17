;;;(include 'recurse-binaryOperator "./evaluation/recurse-binOperator")

;;;(recurse-binaryOperator func-symbol)
;;;
;;;func-symbol : function symbol or list
;;;              function apply two argment.
;;;
;;;return : function

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'default "./common/default")

(defun recurse-binaryOperator (func-symbol)
  (if
    (default (eval func-symbol)
             '(progn
               (print "recurse-binaryOperator - no function definition : ")
               (princ func-symbol)
               (exit)
              )
    )
     (eval
       (list
         'lambda
         '(alist)
         (list '(lambda ($_recursiveFunction /) ($_recursiveFunction alist))
               (list 'lambda
                     '(listArg)
                     (list 'if
                           '(< 1 (length listArg))
                           (list (eval func-symbol)
                                 '(car listArg)
                                 '($_recursiveFunction (cdr listArg))
                           )
                           '(car listArg)
                     )
               )
         )
       )
     )
  )
)
