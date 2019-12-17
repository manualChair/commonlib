;;;(include 'char-equal "./characters/char-equal")

;;;(char-equal char1 char2)
;;;
;;;char1 : integer or structure of multibyte character
;;;
;;;char2 : integer or structure of multibyte character
;;;
;;;return : T or nil (ignore case)

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'characterp "./characters/characterp")
(include 'integerp "./numbers/integerp")
(include 'char-upcase "./characters/char-upcase")

(defun char-equal (char1 char2)
  (if (and (characterp char1) (characterp char2))
    (if (and (integerp char1) (integerp char2))
      (= (char-upcase char1) (char-upcase char2))
      (equal char1 char2)
    )
    (exit)
  )
)