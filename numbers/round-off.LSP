;;;(include 'round-off "./numbers/round-off")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (round-off 1234.5678 0)
;;;1235.0
;;;_$ (round-off -1234.5678 0)
;;;-1235.0
;;;_$ (round-off -1234.5678 2)
;;;-1234.57
;;;_$ (round-off -1234.5678 -2)
;;;-1200.0

(include 'signum "./numbers/signum")
(include 'integerp "./numbers/integerp")

(defun round-off:main (/ shift)
  (setq shift (expt 10.0 (fix digit)))
  (/ (fix (+ (* number shift) (* (signum number) 0.5))) shift)
)

(defun round-off (number digit)
  (if (and (numberp number) (integerp digit))
    (round-off:main)
    (exit)
  )
)