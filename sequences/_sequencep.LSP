;;;(include 'sequencep "./sequences/_sequencep")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'type-of "./types/type-of")

(defun sequencep (item)
  (setq itype (type-of item))
  (cond ((or (= itype 'STR)
             (= itype 'SYM)
             (= itype 'LIST)
             (and (= itype 'VARIANT)
                  (or (= (vlax-variant-type item) vlax-vbString)
                      (> (vlax-variant-type item) vlax-vbArray)
                  )
             )
             (= itype 'SAFEARRAY)
         )
         itype
        )
        ((= itype 'NIL) '(quote nil))
  )
)