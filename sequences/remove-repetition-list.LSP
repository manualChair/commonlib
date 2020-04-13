;;;(include 'remove-repetition-list "./sequences/remove-repetition-list")

;;;(remove-repetition-list alist test-func start end from-end)
;;;
;;;alist : list
;;;
;;;test-func : function
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;from-end : atom (T or nil)
;;;
;;;return : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (remove-repetition-list '(0 0 1 1 2 2 1 2) '= nil nil nil)
;;;(0 1 2 1 2)
;;;_$ (remove-repetition-list '(0 0 1 1 2 2 1 2) '= 1 5 nil)
;;;(0 0 1 2 2 1 2)

(include 'default "./common/default")
(include 'functionp "./flow/functionp")
(include 'endp "./conses/endp")
(include 'subseq-list "./sequences/subseq-list")

(defun remove-repetition-list:sub (alist)
  (if (not (endp alist))
    (if (not (null (cdr alist)))
      (if (apply test-func (list (car alist) (cadr alist)))
        (remove-repetition-list:sub (cdr alist))
        (cons (car alist) (remove-repetition-list:sub (cdr alist)))
      )
      alist
    )
  )
)

(defun remove-repetition-list (alist test-func start end from-end)
  (setq start (max 0 (default start '0))
        end   (min (default end '(length alist)) (length alist))
  )
  (if (functionp (eval (setq test-func (default test-func ''equal))))
    (append (subseq-list alist 0 start)
            (if from-end
              (reverse (remove-repetition-list:sub
                         (reverse (subseq-list alist start end))
                       )
              )
              (remove-repetition-list:sub (subseq-list alist start end))
            )
            (subseq-list alist end nil)
    )
    (exit)
  )
)
