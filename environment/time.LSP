;;;(include 'time "./environment/time")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'format "./printer/format")

(setq *time-output*
       (lambda (seconds)
         (format T
                 "\nComputation time : ~D  seconds."
                 (list seconds)
         )
       )
)

(defun time (func args / date result)
  (setq date   (getvar "DATE")
        result (apply func args)
  )
  (apply '*time-output* (list (* 86400.0 (- (getvar "DATE") date))))
  result
)
