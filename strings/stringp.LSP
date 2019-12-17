;;;(include 'stringp "./strings/stringp")

;;;(stringp item)
;;;
;;;stringp : atom or list
;;;
;;;return : T or nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'type-of "./types/type-of")
(include 'characterp "./characters/characterp")

(defun stringp (item / itype)
  (setq itype (type-of item))
  (or
    (= itype 'STR)
    (= itype 'SYM)
    (= itype 'NIL)
    (and (= itype 'LIST) (vl-every 'characterp item))
    (and
      (= itype 'VARIANT)
      (or (= (vlax-variant-type item) vlax-vbString)
          (and
            (or (= (vlax-variant-type item) (+ vlax-vbArray vlax-vbInteger))
                (= (vlax-variant-type item) (+ vlax-vbArray vlax-vbLong))
            )
            (vl-every 'characterp (coerce item 'SLIST))
          )
      )
    )
    (and (= itype 'SAFEARRAY)
         (and (or (= (vlax-safearray-type item) vlax-vbInteger)
                  (= (vlax-safearray-type item) vlax-vbLong)
              )
              (vl-every 'characterp (coerce item 'SLIST))
         )
    )
  )
)
