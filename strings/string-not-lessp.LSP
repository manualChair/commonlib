;;;(include 'string-not-lessp "./strings/string-not-lessp") ;_ >=

;;;(string-not-lessp string1 string2 start1 end1 start2 end2)
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

;;;_$ (string-not-lessp "abc0" "ABC1" nil nil nil nil)
;;;nil
;;;_$ (string-not-lessp "abc1" "ABC1" nil nil nil nil)
;;;T
;;;_$ (string-not-lessp "abc2" "ABC1" nil nil nil nil)
;;;T
;;;_$ (string-not-lessp "abc1-1" "ABC1" nil nil nil nil)
;;;T

(include 'string-lessp "./strings/string-lessp") ;_ <

(defun string-not-lessp (string1 string2 start1 end1 start2 end2)
  (not (string-lessp string1 string2 start1 end1 start2 end2))
)