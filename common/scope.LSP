;;;(include 'scope "./common/scope")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include '<:float "./common/float_comparison")

(defun scope (num scope-min scope-max)
  (cond ((and scope-min (<:float num scope-min)) scope-min)
        ((and scope-max (<:float scope-max num)) scope-max)
        (T num)
  )
)
