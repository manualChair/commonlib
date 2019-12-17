;;;(include 'digit-char "./characters/digit-char")

;;;(digit-char i radix)
;;;
;;;i : integer
;;;
;;;radix : integer (2~36) or if nil 10
;;;
;;;retrun : integer meaning ascii-code

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (chr (digit-char 9 nil))
;;;"9"
;;;_$ (chr (digit-char 10 nil))
;;;; error: bad argument type: fixnump: nil
;;;_$ (chr (digit-char 10 16))
;;;"A"
;;;_$ (chr (digit-char 15 16))
;;;"F"
;;;_$ (chr (digit-char 35 36))
;;;"Z"

(include 'default "./common/default")
(include 'scope "./common/scope")
(include 'scope-p "./common/scope-p")
(include 'integerp "./numbers/integerp")

(defun digit-char:main ()
  (setq radix (default radix '10))
  (if (scope radix 2 36)
    (cond ((scope-p i 0 (min radix 9)) (+ (ascii "0") i))
          ((scope-p i 10 (1- radix)) (+ (ascii "A") (- i 10)))
    )
    (exit)
  )
)


(defun digit-char (i radix)
  (if (and (integerp i) (or (null radix) (integerp radix)))
    (digit-char:main)
    (exit)
  )
)