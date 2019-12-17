;;;(include 'char-not-lessp "./characters/char-not-lessp") ;_ >=

;;;(char-not-lessp char1 char2)
;;;
;;;char1 : integer
;;;
;;;char2 : integer
;;;
;;;return : T or nil (ignore case)

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'characterp "./characters/characterp")
(include 'char-lessp "./characters/char-lessp") ;_ <

(defun char-not-lessp (char1 char2)
  (not (char-lessp char1 char2))
)