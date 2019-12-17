;;;(include 'string-capitalize "./strings/string-capitalize")

;;;(string-capitalize atype astring start end)
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

;;;_$ (string-capitalize 'STR "this is a pen.do you have pinaple?i have apple,pen!wow" nil nil)
;;;"This Is A Pen.Do You Have Pinaple?I Have Apple,Pen!Wow"
;;;_$ (string-capitalize 'STR "this is a pen.do you have pinaple?i have apple,pen!wow" 15 nil)
;;;"this is a pen.do You Have Pinaple?I Have Apple,Pen!Wow"
;;;_$ (string-capitalize 'STR "this is a pen.do you have pinaple?i have apple,pen!wow" 15 30)
;;;"this is a pen.do You Have Pinaple?i have apple,pen!wow"
;;;_$ (string-capitalize 'SLIST "this is a pen." nil nil)
;;;(84 104 105 115 32 73 115 32 65 32 80 101 110 46)
;;;_$ (string-capitalize 'VARIANT "this is a pen." nil nil)
;;;#<variant 8 This Is A Pen.>
;;;_$ (string-capitalize 'SAFEARRAY "this is a pen." nil nil)
;;;#<safearray...>

(include 'member-of-option-p "./common/member-of-option-p")
(include 'coerce "./types/coerce")
(include 'lower-case-p "./characters/lower-case-p")
(include 'upper-case-p "./characters/upper-case-p")
(include 'char-downcase "./characters/char-downcase")
(include 'char-upcase "./characters/char-upcase")
(include 'alphanumericp "./characters/alphanumericp")
(include 'stringp-list "./strings/_stringp-list")
(include 'to-variantp-string "./strings/_to-variantp-string")
(include 'subseq-list "./sequences/subseq-list")

(defun string-capitalize:sub (clist)
  (if clist
    (cond ((= c-case 'UP)
           (if (alphanumericp (car clist))
             (cons (progn (setq c-case 'DOWN) (char-upcase (car clist)))
                   (string-capitalize:sub (cdr clist))
             )
             (cons (car clist) (string-capitalize:sub (cdr clist)))
           )
          )
          ((= c-case 'DOWN)
           (if (upper-case-p (car clist))
             (cons (char-downcase (car clist))
                   (string-capitalize:sub (cdr clist))
             )
             (cons (progn (if (or (= (car clist) (ascii " "))
                                  (= (car clist) (ascii "!"))
                                  (= (car clist) (ascii "?"))
                                  (= (car clist) (ascii "."))
                                  (= (car clist) (ascii ","))
                              )
                            (setq c-case 'UP)
                          )
                          (car clist)
                   )
                   (string-capitalize:sub (cdr clist))
             )
           )
          )
    )
  )
)

(defun string-capitalize (atype astring start end / sequence c-case)
  (if (member-of-option-p
        'string-capitalize
        'atype
        '(STR SLIST SYM VARIANT SAFEARRAY VECTOR)
      )
    (progn
      (setq sequence (stringp-list astring)
            start    (max 0 (default start '0))
            end      (min (default end '(length sequence)) (length sequence))
            c-case   (if (< 0 start)
                       (if (alphanumericp (nth (1- start) sequence))
                         'DOWN
                         'UP
                       )
                       'UP
                     )
      )
      (coerce
        (to-variantp-string
          atype
          (append (subseq-list sequence 0 start)
                  (string-capitalize:sub (subseq-list sequence start end))
                  (subseq-list sequence end nil)
          )
        )
        atype
      )
    )
    (exit)
  )
)