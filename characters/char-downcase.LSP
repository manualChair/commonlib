;;;(include 'char-downcase "./characters/char-downcase")

;;;(char-downcase ascii-code)
;;;
;;;ascii-code : integer or structure of multibyte character
;;;
;;;retrun : If ascii-code is uppercase alphabet, retrurn the
;;;         corresponding lowercase character.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'characterp "./characters/characterp")
(include 'upper-case-p "./characters/upper-case-p")

(defun char-downcase (ascii-code)
  (if (characterp ascii-code)
    (if (upper-case-p ascii-code)
      (+ ascii-code (- (ascii "a") (ascii "A")))
      ascii-code
    )
  )
)