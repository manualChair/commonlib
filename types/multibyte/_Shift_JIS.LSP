;;;(include 'Shift_JIS "./types/multibyte/_Shift_JIS")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'defstruct "./structures/defstruct")

(defstruct 'Shift_JIS '((code . '0)))

(defun encode:Shift_JIS-p (clist)
  (if clist
    (or (and (<= 128 (car clist)) (<= (car clist) 159))
        (and (<= 224 (car clist)) (<= (car clist) 255))
    )
  )
)

(defun encode:Shift_JIS (clist)
  (cons (make-Shift_JIS (+ (lsh (car clist) 8) (cadr clist))) 2)
)

;;

(defun decode:Shift_JIS (Shift_JIS-s)
  (list (lsh (Shift_JIS-code Shift_JIS-s) -8)
        (logand (Shift_JIS-code Shift_JIS-s) 255)
  )
)