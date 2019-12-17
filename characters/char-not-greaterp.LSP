;;;(include 'char-not-greaterp "./characters/char-not-greaterp") ;_ <=

;;;(char-not-greaterp char1 char2)
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
(include 'char-greaterp "./characters/char-greaterp") ;_ >

(defun char-not-greaterp (char1 char2)
  (not (char-greaterp char1 char2))
)