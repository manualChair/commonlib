;;;(include 'string "./strings/string")

;;;(string item)
;;;
;;;item : string, list, symbol, variant(string or safe-array), safe-array
;;;
;;;return : string
;;;         if item is string, this return itself.
;;;         if item is list, this return string converted from list.
;;;         if item is symbol, this return string of symbol-name.
;;;         if item is safe-array, this return same string as list.
;;;         if item is variant, this return same string as string or list.
;;;         In other case, return nil.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'coerce "./types/coerce")
(include 'stringp "./strings/stringp")

(defun string (item)
  (if (stringp item)
    (coerce item 'STR)
    (exit)
  )
)
