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
;;;quotation   :  string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;retrun : string or list etc.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (unword 'STR '("A" "B" "C") ":" nil)
;;;"A:B:C"
;;;_$ (unword 'SLIST '("A" "B" "C") ":" nil)
;;;(65 58 66 58 67)
;;;_$ (unword 'SLIST nil ":" nil)
;;;nil
;;;_$ (unword 'STR nil ":" nil)
;;;""
;;;_$ (unword 'STR '((65) (66) (67)) '(58) nil)
;;;"A:B:C"
;;;_$ (unword 'STR '("A" "B:2:3" "C") ":" "\"")
;;;"A:\"B:2:3\":C"
;;;_$ (unword 'VARIANT '("A" "B" "C") ":" nil)
;;;#<variant 8 A:B:C>

(include 'member-of-option-p "./common/member-of-option-p")
(include 'coerce "./types/coerce")
(include 'characterp "./characters/characterp")
(include 'char-equal "./characters/char-equal")
(include 'stringp "./strings/stringp")
(include 'to-variantp-string "./strings/_to-variantp-string")
(include 'search "./sequences/search")
(include 'concatenate "./sequences/concatenate")
(include 'affix "./sequences/affix")

(defun unword:quote (sequence)
  (if (and quotation (search pause sequence 'char-equal nil nil nil))
    (affix sequence quotation 'BOTH)
    sequence
  )
)

(defun unword:sub (slist)
  (if (and slist (cdr slist))
    (cons (unword:quote (car slist)) (cons pause (unword:sub (cdr slist))))
    (list (apply 'unword:quote slist))
  )
)

(defun unword (atype list-string pause quotation)
  (if (and (member-of-option-p
             'unword
             'atype
             '(STR SLIST SYM VARIANT SAFEARRAY VECTOR)
           )
           (vl-every 'stringp list-string)
           (stringp pause)
           (stringp quotation)
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