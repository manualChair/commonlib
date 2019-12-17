;;;(include 'fill-list "./sequences/fill-list")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (fill-list '(0 1 2 3 4 5 6) '* 1 4)
;;;(0 * * * 4 5 6)
;;;_$ (fill-list '(0 1 2 3 4 5 6) '* 2 nil)
;;;(0 1 * * * * *)
;;;_$ (fill-list '(0 1 2 3 4 5 6) '* nil 3)
;;;(* * * 3 4 5 6)
;;;_$ (fill-list '(0 1 2 3 4 5 6) '* nil nil)
;;;(* * * * * * *)

(include 'default "./common/default")

(defun fill-list:sub (alist counter)
  (if (< counter end)
    (cons (if (<= start counter)
            item
            (car alist)
          )
          (fill-list:sub (cdr alist) (1+ counter))
    )
    alist
  )
)

(defun fill-list (alist item start end)
  (setq start (max 0 (default start 0))
        end   (min (default end '(length alist)) (length alist))
  )
  (fill-list:sub alist 0)
)