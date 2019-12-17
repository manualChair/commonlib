;;;(include 'upper-case-p "./characters/upper-case-p")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'integerp "./numbers/integerp")
(include 'scope-p "./common/scope-p")

(defun upper-case-p (ascii-code)
  (and (integerp ascii-code)
       (scope-p ascii-code 65 ;|(ascii "A")|; 90 ;|(ascii "Z")|;)
  )
)