;;;(include 'char-not-equal "./characters/char-not-equal")

;;;(char-not-equal char1 char2)
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

(include 'char-equal "./characters/char-equal")

(defun char-not-equal (char1 char2)
  (not (char-equal char1 char2))
)