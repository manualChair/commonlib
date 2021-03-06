;;;(include 'char-lessp "./characters/char-lessp") ;_ <

;;;(char-lessp char1 char2)
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

(include 'integerp "./numbers/integerp")
(include 'characterp "./characters/characterp")
(include 'char-upcase "./characters/char-upcase")
(include 'multi-byte-char:compare
         "./types/multibyte/multi-byte-char-compare"
)

(defun char-lessp (char1 char2)
  (if (and (characterp char1) (characterp char2))
    (cond ((and (integerp char1) (integerp char2))
           (< (char-upcase char1) (char-upcase char2))
          )
          ((integerp char1) T)
          ((integerp char2) nil)
          (T (minusp (multi-byte-char:compare char1 char2))) ;_ <
    )
    (exit)
  )
)