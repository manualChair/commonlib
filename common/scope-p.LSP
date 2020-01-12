;;;(include 'scope-p "./common/scope-p")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include '<:float "./common/float_comparison")

(defun scope-p (num scope-min scope-max)
  (and (or (null scope-min) (<=:float scope-min num))
       (or (null scope-max) (<=:float num scope-max))
  )
)
