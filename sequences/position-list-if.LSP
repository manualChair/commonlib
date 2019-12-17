;;;(include 'position-list-if "./sequences/position-list-if")

;;;(position-list-if predicate list start end from-end)
;;;  position-if of only list version
;;;
;;;predicate : predicate function
;;;              function apply single argment.
;;;
;;;list : list
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;from-end : atom (T or nil)
;;;
;;;return : integer of index. zero-indexed. or nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (position-list-if 'oddp '(0 1 2 3 4 5 0 1 2 3 4 5) nil nil nil)
;;;1
;;;_$ (position-list-if 'zerop '(0 1 2 3 4 5 0 1 2 3 4 5) 3 nil nil)
;;;6
;;;_$ (position-list-if 'zerop '(0 1 2 3 4 5 0 1 2 3 4 5) nil nil T)
;;;6

(include 'default "./common/default")
(include 'subseq-list "./sequences/subseq-list")

(defun position:find ($_target $_index)
  (if $_target
    (if (apply $_predicate (list (car $_target)))
      $_index
      (position:find (cdr $_target) (1+ $_index))
    )
  )
)

(defun position-list-if
       ($_predicate $_list $_start $_end $_from-end / $_index)
  (setq $_start (max 0 (default $_start '0))
        $_end   (min (default $_end '(length $_list)) (length $_list))
        $_index (position:find
                  (if $_from-end
                    (reverse (subseq-list $_list $_start $_end))
                    (subseq-list $_list $_start $_end)
                  )
                  0
                )
  )
  (if $_index
    (if $_from-end
      (- $_end $_index 1)
      (+ $_start $_index)
    )
  )
)
