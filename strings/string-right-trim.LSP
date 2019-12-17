;;;(include 'string-right-trim "./strings/string-right-trim")

;;;(string-right-trim atype char-bag astring)
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

;;;_$ (string-right-trim 'STR " ." " . . . HELLO . . .")
;;;" . . . HELLO"
;;;_$ (string-right-trim 'LIST " ." " . . . HELLO . . .")
;;;(32 46 32 46 32 46 32 72 69 76 76 79)
;;;_$ (string-right-trim 'VARIANT " ." " . . . HELLO . . .")
;;;#<variant 8  . . . HELLO>
;;;_$ (string-right-trim 'SAFEARRAY " ." " . . . HELLO . . .")
;;;#<safearray...>

(include 'member-of-option-p "./common/member-of-option-p")
(include 'coerce "./types/coerce")
(include 'stringp-list "./strings/_stringp-list")
(include 'to-variantp-string "./strings/_to-variantp-string")
(include 'string-trim:sub "./strings/_string-trim")

(defun string-right-trim (atype char-bag astring / sequence trim-chars)
  (if (member-of-option-p
        'string-right-trim
        'atype
        '(STR SLIST SYM VARIANT SAFEARRAY VECTOR)
      )
    (progn (setq sequence   (reverse (stringp-list astring))
                 trim-chars (stringp-list char-bag)
           )
           (coerce
             (to-variantp-string atype (reverse (string-trim:sub sequence)))
             atype
           )
    )
    (exit)
  )
)