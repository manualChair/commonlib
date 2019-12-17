;;;(include 'lower-case-p "./characters/lower-case-p")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'integerp "./numbers/integerp")
(include 'scope-p "./common/scope-p")

(defun lower-case-p (ascii-code)
  (and (integerp ascii-code)
       (scope-p ascii-code 97 ;|(ascii "a")|; 122 ;|(ascii "z")|;)
  )
)