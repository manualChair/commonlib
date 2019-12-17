;;;(include 'ControlCode-p "./characters/ControlCode-p")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'integerp "./numbers/integerp")

(defun ControlCode-p (ascii-code)
  (and (integerp ascii-code)
       (or (<= 0 ascii-code 31 ;|NUL~UC|;) (= ascii-code 127 ;|DEL|;))
  )
)