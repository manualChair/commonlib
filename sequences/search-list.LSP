;;;(include 'search-list "./sequences/search-list")

;;;(search-list sub-list alist test-func start start end from-end)
;;;
;;;sub-list : list
;;;
;;;alist : list
;;;
;;;test-func : test function symbol (default equal)
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;from-end : atom (T or nil)
;;;
;;;return : integer of index(zero-indexed) or nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (search-list '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil nil nil nil)
;;;3
;;;_$ (search-list '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil nil nil T)
;;;8
;;;_$ (search-list '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil 5 nil nil)
;;;8
;;;_$ (search-list '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil nil 5 T)
;;;3

(include 'default "./common/default")
(include 'functionp "./flow/functionp")
(include 'endp "./conses/endp")
(include 'subseq-list "./sequences/subseq-list")

(defun search:check-rest (sub-target target)
  (if (and (not (endp sub-target)) (not (endp target)))
    (if (apply test-func (list (car sub-target) (car target)))
      (search:check-rest (cdr sub-target) (cdr target))
    )
    (if (null sub-target)
      T
    )
  )
)

(defun search:find (target index)
  (if target
    (if (and (apply test-func (list (car pattern) (car target)))
             (search:check-rest (cdr pattern) (cdr target))
        )
      index
      (search:find (cdr target) (1+ index))
    )
  )
)

(defun search-list
       (sub-list alist test-func start end from-end / index pattern)
  (setq start   (max 0 (default start '0))
        end     (min (default end '(length alist)) (length alist))
        pattern (if from-end
                  (reverse sub-list)
                  sub-list
                )
  )
  (if (functionp (eval (setq test-func (default test-func ''equal))))
    (if (setq index (search:find
                      (if from-end
                        (reverse (subseq-list alist start end))
                        (subseq-list alist start end)
                      )
                      0
                    )
        )
      (if from-end
        (- end index (length sub-list))
        (+ start index)
      )
    )
  )
)
