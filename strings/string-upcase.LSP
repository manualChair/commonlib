;;;(include 'string-upcase "./strings/string-upcase")

;;;(string-upcase atype astring start end)
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

;;;_$ (string-upcase 'STR "hey! you are cool." nil nil)
;;;"HEY! YOU ARE COOL."
;;;_$ (string-upcase 'STR "hey! you are cool." 6 nil)
;;;"hey! yOU ARE COOL."
;;;_$ (string-upcase 'STR "hey! you are cool." 6 10)
;;;"hey! yOU Are cool."
;;;_$ (string-upcase 'SLIST "hey! you are cool." nil nil)
;;;(72 69 89 33 32 89 79 85 32 65 82 69 32 67 79 79 76 46)
;;;_$ (string-upcase 'VARIANT "hey! you are cool." nil nil)
;;;#<variant 8 HEY! YOU ARE COOL.>
;;;_$ (string-upcase 'SAFEARRAY "hey! you are cool." nil nil)
;;;#<safearray...>

(include 'default "./common/default")
(include 'member-of-option-p "./common/member-of-option-p")
(include 'coerce "./types/coerce")
(include 'char-upcase "./characters/char-upcase")
(include 'stringp-list "./strings/_stringp-list")
(include 'to-variantp-string "./strings/_to-variantp-string")
(include 'subseq-list "./sequences/subseq-list")

(defun string-upcase (atype astring start end / sequence)
  (if (member-of-option-p
        'string-upcase
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
                  (mapcar 'char-upcase (subseq-list sequence start end))
                  (subseq-list sequence end nil)
          )
        )
        atype
      )
    )
    (exit)
  )
)