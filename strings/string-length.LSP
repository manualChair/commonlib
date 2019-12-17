;;;(include 'string-length "./strings/string-length")

;;;(string-length astring)
;;;
;;;astring : string, symbol
;;;
;;;return : integer

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (string-length "01234")
;;;5
;;;_$ (string-length 'ABCDE)
;;;5

(include 'stringp-list "./strings/_stringp-list")

(defun string-length (astring)
  (length (stringp-list astring))
)