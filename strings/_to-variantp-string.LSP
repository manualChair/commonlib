;;;(include 'to-variantp-string "./strings/_to-variantp-string")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'coerce "./types/coerce")

(defun to-variantp-string (atype alist)
  (if (= atype 'VARIANT)
    (coerce alist 'STR)
    alist
  )
)