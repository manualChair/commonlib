;;;(include 'chain "./conses/chain")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (chain '(A B C D) nil)
;;;((A B) (B C) (C D))
;;;_$ (chain '(A B C D) T)
;;;((A B) (B C) (C D) (D A))

(defun chain:sub (alist)
  (if (and (not (null alist)) (cdr alist))
    (cons (list (car alist) (cadr alist)) (chain:sub (cdr alist)))
    (if closed
      (list (list (car alist) start))
    )
  )
)

(defun chain (alist closed / start)
  (setq start (car alist))
  (chain:sub alist)
)