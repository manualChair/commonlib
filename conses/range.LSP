;;;(include 'range "./conses/range")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (range 10 3 -2)
;;;(10 8 6 4)
;;;_$ (range nil 3 nil)
;;;(0 1 2)
;;;_$ (range nil -3 nil)
;;;nil
;;;_$ (range 3 10 nil)
;;;(3 4 5 6 7 8 9)
;;;_$ (range 10 3 nil)
;;;nil
;;;_$ (range -3 3 nil)
;;;(-3 -2 -1 0 1 2)
;;;_$ (range 3 -3 nil)
;;;nil
;;;_$ (range 3 10 2)
;;;(3 5 7 9)
;;;_$ (range 10 3 2)
;;;nil
;;;_$ (range 10 3 -2)
;;;(10 8 6 4)
;;;_$ (range 3 10 -2)
;;;nil

(include 'default "./common/default")

(defun renge:sub (index)
  (if (apply judgefunc (list index end))
    (cons index (renge:sub (+ index step)))
  )
)

(defun range (start end step / judgefunc)
  (if (and (or (null start) (numberp start))
           (numberp end)
           (or (null step) (and (numberp step) (not (zerop step))))
      )
    (progn (setq start     (default start '0)
                 step      (default step '1)
                 judgefunc (if (< end start)
                             (if (minusp step)
                               '>
                             )
                             (if (not (minusp step))
                               '<
                             )
                           )
           )
           (if judgefunc
             (renge:sub start)
           )
    )
    (exit)
  )
)
