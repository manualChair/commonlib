;;;(include 'string-left-trim "./strings/string-left-trim")

;;;(string-left-trim atype char-bag astring)
;;;
;;;atype : symbol ('STR 'SLIST 'SYM or 'VARIANT 'SAFEARRAY 'VECTOR)
;;;
;;;char-bag : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;astring  : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;return : string or list etc.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (string-left-trim 'STR " ." " . . . HELLO . . .")
;;;"HELLO . . ."
;;;_$ (string-left-trim 'LIST " ." " . . . HELLO . . .")
;;;(72 69 76 76 79 32 46 32 46 32 46)
;;;_$ (string-left-trim 'VARIANT " ." " . . . HELLO . . .")
;;;#<variant 8 HELLO . . .>
;;;_$ (string-left-trim 'SAFEARRAY " ." " . . . HELLO . . .")
;;;#<safearray...>

(include 'member-of-option-p "./common/member-of-option-p")
(include 'coerce "./types/coerce")
(include 'stringp-list "./strings/_stringp-list")
(include 'to-variantp-string "./strings/_to-variantp-string")
(include 'string-trim:sub "./strings/_string-trim")

(defun string-left-trim (atype char-bag astring / sequence trim-chars)
  (if (member-of-option-p
        'string-left-trim
        'atype
        '(STR SLIST SYM VARIANT SAFEARRAY VECTOR)
      )
    (progn
      (setq sequence   (stringp-list astring)
            trim-chars (stringp-list char-bag)
      )
      (coerce (to-variantp-string atype (string-trim:sub sequence)) atype)
    )
    (exit)
  )
)