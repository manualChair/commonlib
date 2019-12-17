;;;(include 'word "./strings/word")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (word 'STR "A:B:C:D" ":" "" nil nil nil)
;;;("A" "B" "C" "D")
;;;_$ (word 'STR "A:B:C:D" ":" "" T nil nil)
;;;("A" ":" "B" ":" "C" ":" "D")
;;;_$ (word 'STR "A:B-C/D" ":-/" "" nil nil nil)
;;;("A" "B" "C" "D")
;;;_$ (word 'STR "A:B-C/D" "-" "" T T nil)
;;;("A:B" "-" "C/D")
;;;_$ (word 'STR "A:B-C:b-c:D" "B-C" "" T T T)
;;;("A:" "B-C" ":" "b-c" ":D")
;;;_$ (word 'STR "A:B-C:b-c:D" "B-C" "" T T nil)
;;;("A:" "B-C" ":b-c:D")
;;;_$ (word 'STR "\"WATCH QUOTE!\" : This is 'quote option' usage" " " "'\"" nil nil nil)
;;;("\"WATCH QUOTE!\"" ":" "This" "is" "'quote option'" "usage")
;;;_$ (word 'STR "\"-> SEE QUOTE\"->This is 'quote-option' usage" "->" "'\"" nil T nil)
;;;("\"-> SEE QUOTE\"" "This is 'quote-option' usage")

(include 'member-of-option-p "./common/member-of-option-p")
(include 'coerce "./types/coerce")
(include 'endp "./conses/endp")
(include 'char-upcase "./characters/char-upcase")
(include 'stringp-list "./strings/_stringp-list")
(include 'to-variantp-string "./strings/_to-variantp-string")
(include 'subseq-list "./sequences/subseq-list")

;;;
;;;RECURSE VERSION
;;;

(defun word:sub:push-char ()
  (if (member (car clist) qlist)
    (setq quoteDeps (if (< 0 quoteDeps)
                      (1- quoteDeps)
                      (1+ quoteDeps)
                    )
    )
  )
  (setq buffer (cons (car clist) buffer))
)

(defun word:sub:string-break-mode (clist)
  (if (not (endp clist))
    (cond
      ((and (equal (mapcar 'word:case (subseq-list clist 0 (length blist)))
                   blist
            )
            (= quoteDeps 0)
       )
       (setq wlist
              (cons
                (coerce (to-variantp-string atype (reverse buffer)) atype)
                wlist
              )
             buffer nil
       )
       (if output-break
         (setq wlist (cons (coerce (to-variantp-string
                                     atype
                                     (subseq-list clist 0 (length blist))
                                   )
                                   atype
                           )
                           wlist
                     )
         )
       )
       (word:sub:string-break-mode (subseq-list clist (length blist) nil))
      )
      (T (word:sub:push-char) (word:sub:string-break-mode (cdr clist)))
    )
  )
)


(defun word:sub (clist)
  (if (not (endp clist))
    (cond ((and (member (word:case (car clist)) blist) (= quoteDeps 0))
           (setq wlist
                  (cons
                    (coerce (to-variantp-string atype (reverse buffer)) atype)
                    wlist
                  )
                 buffer nil
           )
           (if output-break
             (setq wlist
                    (cons (coerce (to-variantp-string atype (list (car clist)))
                                  atype
                          )
                          wlist
                    )
             )
           )
           (word:sub (cdr clist))
          )
          (T (word:sub:push-char) (word:sub (cdr clist)))
    )
  )
)


(defun word:case (ascii-code)
  (if ignore-case
    (char-upcase ascii-code)
    ascii-code
  )
)

(defun word (atype        astring      break        quotation
             output-break string-break-mode         ignore-case
             /            blist        qlist        sequence
             wlist        buffer       quoteDeps
            )
  (if (and (member-of-option-p
             'word
             'atype
             '(STR SLIST SYM VARIANT SAFEARRAY VECTOR)
           )
           (setq qlist (if quotation
                         (stringp-list quotation)
                       )
                 blist (if break
                         (mapcar 'word:case (stringp-list break))
                       )
           )
           (setq sequence (stringp-list astring))
      )
    (progn (setq quoteDeps 0)
           (if string-break-mode
             (word:sub:string-break-mode sequence)
             (word:sub sequence)
           )
           (if buffer
             (setq
               wlist (cons (coerce (to-variantp-string atype (reverse buffer))
                                   atype
                           )
                           wlist
                     )
             )
           )
           (reverse wlist)
    )
    (list astring)
  )
)
