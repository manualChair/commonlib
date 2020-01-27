;;;(include 'substitute-list-if "./sequences/substitute-list-if")

;;;(substitute-list-if new-item predicate alist start end count from-end)
;;;  substitute-if of only list version
;;;
;;;new-item : atom or list or string
;;;
;;;predicate : predicate function
;;;            function apply single argment.
;;;
;;;alist : list
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;count : integer or nil
;;;
;;;from-end : atom (T or nil)
;;;
;;;return : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (substitute-list-if 1 (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil nil nil)
;;;(1 B C 1 B C 1 B)
;;;_$ (substitute-list-if 1 (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil 2 nil)
;;;(1 B C 1 B C A B)
;;;_$ (substitute-list-if 1 (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil 2 T)
;;;(A B C 1 B C 1 B)
;;;_$ (substitute-list-if 1 (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil 6 2 T)
;;;(1 B C 1 B C A B)

(include 'default "./common/default")
(include 'subseq-list "./sequences/subseq-list")

(defun substitute-list-if ($_new-item   $_predicate  $_alist
                           $_start      $_end        $_count
                           $_from-end   /            $_upper-limit
                           $count       $_result
                          )
  (setq $_start       (max 0 (default $_start '0))
        $_end         (default $_end '(length $_alist))
        $_upper-limit (default $_count '(length $_alist))
        $count        0
        $_result      (mapcar
                        (function (lambda (item)
                                    (if (and (< $count $_upper-limit)
                                             (apply $_predicate (list item))
                                        )
                                      (progn (setq $count (1+ $count)) $_new-item)
                                      item
                                    )
                                  )
                        )
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

