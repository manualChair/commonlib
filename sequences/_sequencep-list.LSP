;;;(include 'sequencep-list "./sequences/_sequencep-list")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'sequencep "./sequences/_sequencep")
(include 'coerce "./types/coerce")

(defun sequencep-list (item / itype)
  (if (setq itype (sequencep item))
    (cond
      ((or (= itype 'STR)
           (= itype 'SYM)
           (and (= itype 'VARIANT)
                (= (vlax-variant-type item) vlax-vbString)
           )
       )
       (coerce item 'SLIST)
      )
      ((or (= itype '(QUOTE nil)) (= itype 'LIST)) item)
      ((or
         (and (= itype 'VARIANT) (> (vlax-variant-type item) vlax-vbArray))
         (= itype 'SAFEARRAY)
       )
       (coerce item 'LIST)
      )
    )
    (exit)
  )
)