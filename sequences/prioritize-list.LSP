;;;(include 'prioritize-list "./sequences/prioritize-list")

;;;(prioritize-list alist index advance)
;;;
;;;alist : list
;;;
;;;index advance : integer
;;;
;;;return : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (prioritize-list '(0 1 2) 1 1)
;;;(0 2 1)
;;;_$ (prioritize-list '(0 1 2) 1 -1)
;;;(1 0 2)
;;;_$ (prioritize-list '(0 1 2) 1 0)
;;;(0 1 2)

(include 'scope "./common/scope")
(include 'integerp "./numbers/integerp")

(defun prioritize-list:normal ()
  (if (= current index)
    (prioritize-list:sub (cdr alist) (1+ current))
    (cons (car alist) (prioritize-list:sub (cdr alist) (1+ current)))
  )
)

(defun prioritize-list:insert-normal ()
  (cons adata (prioritize-list:normal))
)

(defun prioritize-list:insert-reverse ()
  (if (= current index)
    (cons adata (prioritize-list:sub (cdr alist) (1+ current)))
    (cons (car alist)
          (cons adata (prioritize-list:sub (cdr alist) (1+ current)))
    )
  )
)

(defun prioritize-list:sub (alist current)
  (if (or (<= current insert) (<= current index))
    (if (= current insert)
      (insert-func)
      (prioritize-list:normal)
    )
    alist
  )
)

(defun prioritize-list (alist index advance / adata insert insert-func)
  (if (and (integerp index) (integerp advance))
    (if (zerop advance)
      alist
      (progn (setq adata       (nth index alist)
                   insert      (scope (+ index advance) 0 (1- (length alist)))
                   insert-func (if (minusp advance)
                                 prioritize-list:insert-normal
                                 prioritize-list:insert-reverse
                               )
             )
             (prioritize-list:sub alist 0)
      )
    )
    (exit)
  )
)