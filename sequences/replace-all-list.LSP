;;;(include 'replace-all-list "./sequences/replace-all-list")

;;;(replace-all-list new-sub-list sub-list alist test-func start end)
;;;
;;;new-sub-list : list
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
;;;return : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (replace-all-list '(A B C) '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil nil nil)
;;;(0 1 2 A B C 0 1 2 A B C)
;;;_$ (replace-all-list '(A B C) '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil 5 nil)
;;;(0 1 2 3 4 0 1 2 A B C)

(include 'default "./common/default")
(include 'search-list "./sequences/search-list")
(include 'subseq-list "./sequences/subseq-list")

(defun replace-all-list:sub (alist / index)
  (if
    (not
      (null (setq index (search-list sub-list alist test-func nil nil nil))
      )
    )
     (append (subseq-list alist 0 index)
             new-sub-list
             (replace-all-list:sub (subseq-list alist (+ index skip) nil))
     )
     alist
  )
)

(defun replace-all-list
       (new-sub-list sub-list alist test-func start end / skip)
  (setq skip  (length sub-list)
        start (max 0 (default start '0))
        end   (min (default end '(length alist)) (length alist))
  )
  (append (subseq-list alist 0 start)
          (replace-all-list:sub (subseq-list alist start end))
          (subseq-list alist end nil)
  )
)