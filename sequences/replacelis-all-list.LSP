;;;(include 'replacelis-all-list "./sequences/replacelis-all-list")

;;;(replacelis-all-list assoc-list alist start end)
;;;
;;;assoc-list : association list
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

;;;_$ (replacelis-all-list '(((0 1) A) ((2 3 4) < >)) '(0 1 2 3 4 0 1 2 3 4) nil nil nil)
;;;(A 12 13 14 5 A 12 13 14 5)
;;;_$ (replacelis-all-list '(((0 1) A) ((2 3 4) 12 13 14)) '(0 1 2 3 4 5 0 1 2 3 4 5) nil 2 10)
;;;(0 1 12 13 14 5 A 2 3 4 5)

(include 'default "./common/default")
(include 'mapc "./conses/mapc")
(include 'subseq-list "./sequences/subseq-list")
(include 'replace-all-list "./sequences/replace-all-list")

(defun replacelis-all-list:sub (alist)
  (mapc (function (lambda (cell)
                    (setq alist (replace-all-list
                                  (cdr cell)
                                  (car cell)
                                  alist
                                  test-func
                                  nil
                                  nil
                                )
                    )
                  )
        )
        (list assoc-list)
  )
  alist
)

(defun replacelis-all-list (assoc-list alist test-func start end)
  (setq start (max 0 (default start '0))
        end   (min (default end '(length alist)) (length alist))
  )
  (append (subseq-list alist 0 start)
          (replacelis-all-list:sub (subseq-list alist start end))
          (subseq-list alist end nil)
  )
)