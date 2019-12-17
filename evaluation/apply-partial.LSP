;;;(include 'apply-partial "./evaluation/apply-partial")

;;;(apply-partial func-symbol partialArgs slots)
;;;
;;;func-symbol : function symbol or list
;;;
;;;partialArgs : list of applied argments
;;;
;;;slots : list of index no-applied argments.
;;;        Start is 1.
;;;
;;;return : function

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'default "./common/default")

(defun apply-partial:sub (/ arrangeArgs)
  (defun arrangeArgs (counter alist slist)
    (if slist
      (if (= counter (car slist))
        (append (list (read (strcat "$_" (itoa counter))))
                (arrangeArgs (1+ counter) alist (cdr slist))
        )
        (if alist
          (append (list (car alist))
                  (arrangeArgs (1+ counter) (cdr alist) slist)
          )
          (exit)
        )
      )
      alist
    )
  )
  (eval
    (list
      'lambda
      (mapcar (function (lambda (slot) (read (strcat "$_" (itoa slot)))))
              slots
      )
      (append
        (list (eval func-symbol))
        (arrangeArgs
          1
          (mapcar (function (lambda (arg) (list 'quote arg))) partialArgs)
          slots
        )
      )
    )
  )
)

(defun apply-partial (func-symbol partialArgs slots)
  (if (default (eval func-symbol)
               '(progn
                 (print "apply-partial - no function definition : ")
                 (princ func-symbol)
                 (exit)
                )
      )
    (apply-partial:sub)
  )
)