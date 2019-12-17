;;;(include 'unword "./strings/unword")

;;;(unword atype list-string pause)
;;;
;;;atype : symbol ('STR 'SLIST 'SYM or 'VARIANT 'SAFEARRAY 'VECTOR)
;;;
;;;list-string :  list of
;;;               string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;pause       :  string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;retrun : string or list etc.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (unword 'STR '("A" "B" "C") ":")
;;;"A:B:C"
;;;_$ (unword 'SLIST '("A" "B" "C") ":")
;;;(65 58 66 58 67)
;;;_$ (unword 'STR nil ":")
;;;""
;;;_$ (unword 'SLIST nil ":")
;;;nil
;;;_$ (unword 'STR '((65) (66) (67)) '(58))
;;;"A:B:C"
;;;_$ (unword 'STR '(A B C) ":")
;;;"A:B:C"
;;;_$ (unword 'SYM '(A B C) ":")
;;;A:B:C
;;;_$ (unword 'VARIANT '("A" "B" "C") ":")
;;;#<variant 8 A:B:C>
;;;_$ (unword 'SAFEARRAY '("A" "B" "C") ":")
;;;#<safearray...>

(include 'member-of-option-p "./common/member-of-option-p")
(include 'coerce "./types/coerce")
(include 'endp "./conses/endp")
(include 'stringp "./strings/stringp")
(include 'concatenate "./sequences/concatenate")
(include 'to-variantp-string "./strings/_to-variantp-string")

(defun unword:sub (slist)
  (if (and (not (endp slist)) (cdr slist))
    (cons (car slist) (cons pause (unword:sub (cdr slist))))
    slist
  )
)

(defun unword (atype list-string pause)
  (if (and (member-of-option-p
             'unword
             'atype
             '(STR SLIST SYM VARIANT SAFEARRAY VECTOR)
           )
           (vl-every 'stringp list-string)
           (stringp pause)
      )
    (if (not (endp list-string))
      (coerce (to-variantp-string
                atype
                (concatenate atype (unword:sub (vl-remove nil list-string)))
              )
              atype
      )
      (coerce "" atype)
    )
    (exit)
  )
)