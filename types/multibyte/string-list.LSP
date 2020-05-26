;;;(include 'string->list "./types/multibyte/string-list")

;;;(string->list string)
;;;
;;;string : string
;;;
;;;return : list of integer or structure of multibyte charactor

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include '*LISPSYS* "./common/LISPSYS")
(include 'plusp "./numbers/plusp")
(include 'nthcdr "./conses/nthcdr")
(include '*multi-byte-char:function*
         "./types/multibyte/multi-byte-char-func"
)

(defun encode-multibytecharactor:sub (clist tlist / func-s)
  (if tlist
    (progn
      (setq func-s (cdr (assoc (car tlist) *multi-byte-char:function*)))
      (if (apply (multi-byte-function-predicate func-s) (list clist))
        (apply (multi-byte-function-encode func-s) (list clist))
        (encode-multibytecharactor:sub clist (cdr tlist))
      )
    )
    (cons (car clist) 1)
  )
)

(defun encode-multibytecharactor (clist)
  (encode-multibytecharactor:sub
    clist
    *multi-byte-char:types*
  )
)

(defun string->list:sub (clist)
  (if clist
    (progn (setq char-info (encode-multibytecharactor clist))
           (cons (car char-info)
                 (string->list:sub (nthcdr (cdr char-info) clist))
           )
    )
  )
)

(setq string->list
       (if (plusp *LISPSYS*)
         vl-string->list
         (lambda (astring)
           (if astring
             (string->list:sub (vl-string->list astring))
           )
         )
       )
)