;;;(include 'string-not-greaterp "./strings/string-not-greaterp") ;_ <=

;;;(string-not-greaterp string1 string2 start1 end1 start2 end2)
;;;
;;;string1 : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;string2 : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;start1 end1 start2 end2 : integer
;;;
;;;return : T or nil (ignore case)

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (string-not-greaterp "abc0" "ABC1" nil nil nil nil)
;;;T
;;;_$ (string-not-greaterp "abc1" "ABC1" nil nil nil nil)
;;;T
;;;_$ (string-not-greaterp "abc2" "ABC1" nil nil nil nil)
;;;nil
;;;_$ (string-not-greaterp "abc1" "ABC1-1" nil nil nil nil)
;;;T

(include 'string-greaterp "./strings/string-greaterp") ;_ >

(defun string-not-greaterp (string1 string2 start1 end1 start2 end2)
  (not (string-greaterp string1 string2 start1 end1 start2 end2))
)