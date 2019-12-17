;;;(include 'digit-char-p "./characters/digit-char-p")

;;;(digit-char-p ascii-code radix)
;;;
;;;ascii-code : integer
;;;
;;;radix : integer (2~36) or if nil 10
;;;
;;;retrun : integer or nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (digit-char-p (ascii "9") nil)
;;;9
;;;_$ (digit-char-p (ascii "a") nil)
;;;nil
;;;_$ (digit-char-p (ascii "a") 16)
;;;10
;;;_$ (digit-char-p (ascii "f") 16)
;;;15
;;;_$ (digit-char-p (ascii "g") 16)
;;;nil
;;;_$ (digit-char-p (ascii "z") 36)
;;;35

(include 'default "./common/default")
(include 'scope-p "./common/scope-p")
(include 'integerp "./numbers/integerp")
(include 'char-upcase "./characters/char-upcase")

(defun digit-char-p:main (/ code value)
  (setq radix (default radix '10))
  (if (scope-p radix 2 36)
    (progn
      (setq code (char-upcase ascii-code))
      (cond ((scope-p code (ascii "0") (+ (ascii "0") (min (1- radix) 9)))
             (- code (ascii "0"))
            )
            ((and (< 10 radix)
                  (scope-p code (ascii "A") (+ (ascii "A") (- radix 11)))
             )
             (- (+ code 10) (ascii "A"))
            )
      )
    )
    (exit)
  )
)

(defun digit-char-p (ascii-code radix)
  (if (and (integerp ascii-code)
           (or (null radix) (integerp radix))
      )
    (digit-char-p:main)
  )
)