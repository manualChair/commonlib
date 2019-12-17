;;;(include 'tanh "./numbers/tanh")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'sinh "./numbers/sinh")
(include 'cosh "./numbers/cosh")

(defun tanh (x)
  (/ (sinh x) (cosh x))
)