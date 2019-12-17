;;;(include 'subseq-list "./sequences/subseq-list")

;;;(subseq-list alist start end)
;;;  subseq of only list version
;;;
;;;alist : list
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;return : list
;;;         sub-sequence of preseq that begin index start
;;;         and end index (1- end).

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (subseq '(0 1 2 3 4 5 6) 1 4)
;;;(1 2 3)
;;;_$ (subseq '(0 1 2 3 4 5 6) 2 nil)
;;;(2 3 4 5 6)
;;;_$ (subseq '(0 1 2 3 4 5 6) nil 3)
;;;(0 1 2)
;;;_$ (subseq '(0 1 2 3 4 5 6) nil nil)
;;;(0 1 2 3 4 5 6)

(include 'default "./common/default")
(include 'integerp "./numbers/integerp")

(defun subseq:sub (target counter)
  (if (< counter end)
    (if (<= start counter)
      (cons (car target) (subseq:sub (cdr target) (1+ counter)))
      (subseq:sub (cdr target) (1+ counter))
    )
  )
)

(defun subseq-list (alist start end)
  (setq start (max 0 (default start '0))
        end   (min (default end '(length alist)) (length alist))
  )
  (if (and (integerp start) (integerp end))
    (subseq:sub alist 0)
    (exit)
  )
)


