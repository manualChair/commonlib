;;;(include 'remove-duplicates-list "./sequences/remove-duplicates-list")

;;;(remove-duplicates-list alist test-func start end from-end)
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

;;;_$ (remove-duplicates-list '(0 1 2 3 4 3 4 2 4 1 4 0) nil nil nil nil)
;;;(3 2 1 4 0)
;;;_$ (remove-duplicates-list '(0 1 2 3 4 3 4 2 4 1 4 0) nil nil nil T)
;;;(0 1 2 3 4)

(include 'default "./common/default")
(include 'functionp "./flow/functionp")
(include 'endp "./conses/endp")
(include 'subseq-list "./sequences/subseq-list")

(defun remove-duplicates-list:sub (alist)
  (if (not (endp alist))
    (if (vl-member-if
          (function (lambda (test-item)
                      (apply test-func (list (car alist) test-item))
                    )
          )
          (cdr alist)
        )
      (remove-duplicates-list:sub (cdr alist))
      (cons (car alist) (remove-duplicates-list:sub (cdr alist)))
    )
  )
)

(defun remove-duplicates-list (alist test-func start end from-end)
  (setq start (max 0 (default start '0))
        end   (min (default end '(length alist)) (length alist))
  )
  (if (functionp (eval (setq test-func (default test-func ''equal))))
    (append (subseq-list alist 0 start)
            (if from-end
              (reverse
                (remove-duplicates-list:sub (reverse (subseq-list alist start end)))
              )
              (remove-duplicates-list:sub (subseq-list alist start end))
            )
            (subseq-list alist end nil)
    )
    (exit)
  )
)