;;;(include 'char-upcase "./characters/char-upcase")

;;;(char-upcase ascii-code)
;;;
;;;ascii-code : integer or structure of multibyte character
;;;
;;;retrun : If ascii-code is lowercase alphabet, retrurn the
;;;         corresponding uppercase character.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'characterp "./characters/characterp")
(include 'lower-case-p "./characters/lower-case-p")

(defun char-upcase (ascii-code)
  (if (characterp ascii-code)
    (if (lower-case-p ascii-code)
      (- ascii-code (- (ascii "a") (ascii "A")))
      ascii-code
    )
  )
)