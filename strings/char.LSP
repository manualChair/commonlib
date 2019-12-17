;;;(include 'char "./strings/char")

;;;(char astring n)
;;;
;;;astring : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;n : integer
;;;
;;;return : The nth character of string. Zero-indexed.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'stringp-list "./strings/_stringp-list")

(defun char:sub (alist)
  (if (and (not (minusp n)) (< n (length alist)))
    (nth n alist)
    (exit)
  )
)

(defun char (astring n) (char:sub (stringp-list astring)))