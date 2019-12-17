;;;(include 'parse-integer "./numbers/parse-integer")

;;;(parse-integer astring start end radix junk-allowed)
;;;
;;;astring : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;radix : integer (2~36) or if nil 10
;;;
;;;junk-allowed : T or nil
;;;
;;;return : integer

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (parse-integer "100yen" nil nil nil T)
;;;100
;;;_$ (parse-integer "100yen" nil nil nil nil)
;;;; error: quit / exit abort
;;;_$ (parse-integer "100yen" nil 3 nil nil)
;;;100
;;;_$ (parse-integer "ffff" nil nil 16 nil)
;;;65535
;;;_$ (parse-integer "abcd" nil nil nil T)
;;;nil

(include 'stringp-list "./strings/_stringp-list")
(include 'parse-integer-list "./numbers/parse-integer-list")

(defun parse-integer (astring start end radix junk-allowed)
  (parse-integer-list (stringp-list astring) start end radix junk-allowed)
)
