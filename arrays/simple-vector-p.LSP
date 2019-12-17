;;;(include 'simple-vector-p "./arrays/simple-vector-p")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'arrayp "./arrays/arrayp")

(defun simple-vector-p (item)
  (and (arrayp item) (= (vlax-safearray-get-dim item) 1))
)
