;;;(include 'make-list "./conses/make-list")

;;;(make-size size initial-element)
;;;
;;;size : integer
;;;
;;;initial-element : atom or list
;;;
;;;retuen : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (make-list 0 0.0)
;;;nil
;;;_$ (make-list 1 0.0)
;;;(0.0)
;;;_$ (make-list 5 0.0)
;;;(0.0 0.0 0.0 0.0 0.0)

(include 'integerp "./numbers/integerp")
(include 'plusp "./numbers/plusp")

(defun make-list (size initial-element)
  (if (and (integerp size) (not (minusp size)))
    (if (< 0 size)
      (cons initial-element (make-list (1- size) initial-element))
    )
    (exit)
  )
)
