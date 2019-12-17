;;;(include 'string-downcase "./strings/string-downcase")

;;;(string-downcase atype astring start end)
;;;
;;;atype : symbol ('STR 'SLIST 'SYM or 'VARIANT 'SAFEARRAY 'VECTOR)
;;;
;;;astring : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;return : string or list etc.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (string-downcase 'STR "HEY! YOU ARE COOL." nil nil)
;;;"hey! you are cool."
;;;_$ (string-downcase 'STR "HEY! YOU ARE COOL." 6 nil)
;;;"HEY! You are cool."
;;;_$ (string-downcase 'STR "HEY! YOU ARE COOL." 6 10)
;;;"HEY! You aRE COOL."
;;;_$ (string-downcase 'SLIST "HEY! YOU ARE COOL." nil nil)
;;;(104 101 121 33 32 121 111 117 32 97 114 101 32 99 111 111 108 46)
;;;_$ (string-downcase 'VARIANT "HEY! YOU ARE COOL." nil nil)
;;;#<variant 8 hey! you are cool.>
;;;_$ (string-downcase 'SAFEARRAY "HEY! YOU ARE COOL." nil nil)
;;;#<safearray...>

(include 'default "./common/default")
(include 'member-of-option-p "./common/member-of-option-p")
(include 'coerce "./types/coerce")
(include 'char-downcase "./characters/char-downcase")
(include 'stringp-list "./strings/_stringp-list")
(include 'to-variantp-string "./strings/_to-variantp-string")
(include 'subseq-list "./sequences/subseq-list")

(defun string-downcase (atype astring start end / sequence)
  (if (member-of-option-p
        'string-downcase
        'atype
        '(STR SLIST SYM VARIANT SAFEARRAY VECTOR)
      )
    (progn
      (setq sequence (stringp-list astring)
            start    (max 0 (default start '0))
            end      (min (default end '(length sequence)) (length sequence))
      )
      (coerce
        (to-variantp-string
          atype
          (append (subseq-list sequence 0 start)
                  (mapcar 'char-downcase (subseq-list sequence start end))
                  (subseq-list sequence end nil)
          )
        )
        atype
      )
    )
    (exit)
  )
)