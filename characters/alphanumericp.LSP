;;;(include 'alphanumericp "./characters/alphanumericp")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'integerp "./numbers/integerp")
(include 'alpha-char-p "./characters/alpha-char-p")
(include 'scope-p "./common/scope-p")

(defun alphanumericp (ascii-code)
  (or (alpha-char-p ascii-code)
      (and (integerp ascii-code)
           (scope-p ascii-code 48 ;|(ascii "0")|; 57 ;|(ascii "9")|;)
      )
  )
)