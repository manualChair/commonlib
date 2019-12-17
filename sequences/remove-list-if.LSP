;;;(include 'remove-list-if "./sequences/remove-list-if")

;;;(remove-list-if $_predicate $_alist $_start $_end $_count $_from-end)
;;;
;;;$_predicate : $_predicate function
;;;              function apply single argment.
;;;
;;;$_alist : list
;;;
;;;$_start : integer or nil
;;;
;;;$_end : integer or nil
;;;
;;;$_count : integer
;;;
;;;$_from-end : atom (T or nil)
;;;
;;;return : list or string

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (remove-list-if (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil nil nil)
;;;(B C B C B)
;;;_$ (remove-list-if (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil 2 nil)
;;;(B C B C A B)
;;;_$ (remove-list-if (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil 2 T)
;;;(A B C B C B)
;;;_$ (remove-list-if (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil 6 2 T)
;;;(B C B C A B)

(include 'default "./common/default")
(include 'endp "./conses/endp")
(include 'subseq-list "./sequences/subseq-list")

(defun remove-list-if:sub ($_alist)
  (if (not (endp $_alist))
    (if (< $count $_upper-limit)
      (if (apply $_predicate (list (car $_alist)))
        (progn (setq $count (1+ $count))
               (remove-list-if:sub (cdr $_alist))
        )
        (cons (car $_alist) (remove-list-if:sub (cdr $_alist)))
      )
      $_alist
    )
  )
)

(defun remove-list-if ($_predicate  $_alist
                           $_start      $_end        $_count
                           $_from-end   /            $_upper-limit
                           $count       $_result
                          )
  (setq $_start       (max 0 (default $_start '0))
        $_end         (min (default $_end '(length $_alist)) (length $_alist))
        $_upper-limit (default $_count '(length $_alist))
        $count        0
        $_result      (remove-list-if:sub
                        (if $_from-end
                          (reverse (subseq-list $_alist $_start $_end))
                          (subseq-list $_alist $_start $_end)
                        )
                      )
  )
  (append (subseq-list $_alist 0 $_start)
          (if $_from-end
            (reverse $_result)
            $_result
          )
          (subseq-list $_alist $_end nil)
  )
)

