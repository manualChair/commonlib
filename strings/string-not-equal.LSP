;;;(include 'string-not-equal "./strings/string-not-equal")

;;;(string-not-equal string1 string2 start1 end1 start2 end2)
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

;;;_$ (string-not-equal "abc" "ABC" nil nil nil nil)
;;;nil
;;;_$ (string-not-equal "������" "������" nil nil nil nil)
;;;nil

(include 'string-equal "./strings/string-equal")

(defun string-not-equal (string1 string2 start1 end1 start2 end2)
  (not (string-equal string1 string2 start1 end1 start2 end2))
)