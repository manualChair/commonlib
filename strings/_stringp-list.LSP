;;;(include 'stringp-list "./strings/_stringp-list")

;;;(stringp-list item)
;;;
;;;item : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;return : list meaning string

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'coerce "./types/coerce")
(include 'stringp "./strings/stringp")

(defun stringp-list (item)
  (if (stringp item)
    (if (not (null item))
      (coerce item 'SLIST)
    )
    (exit)
  )
)