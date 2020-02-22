;;;(include 'format "./printer/format")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (format nil "NUMBER is ~A, and you are ~A." '(1 "WINNER"))
;;;"NUMBER is 1, and you are WINNER."
;;;_$ (format nil "NUMBER is ~A, and Your score is ~8,2F." '(1 10.023))
;;;"NUMBER is 1, and Your score is    10.02."

(include 'default "./common/default")
(include 'when "./flow/when")
(include 'stringp-list "./strings/_stringp-list")
(include 'write-string "./streams/write-string")

;;

(defun format:pop-token (/ token)
  (setq token       (nth token-index token-list)
        token-index (1+ token-index)
  )
  token
)

;;

(defun format:number-rest-value (/ number)
  (if (minusp (setq number (- (length value-list) value-index)))
    0
    number
  )
)

(defun format:pop-value (/ item)
  (if value-list
    (progn (setq item        (nth value-index value-list)
                 value-index (1+ value-index)
           )
           item
    )
  )
)

(defun format:skip-value (step)
  (if (minusp (setq value-index (+ value-index step)))
    (setq value-index 0)
  )
)

(defun format:set-value-index (index)
  (setq value-index (default index '0))
)

;;

(defun format:break (modifier a b c)
  (setq a (eval a)
        b (eval b)
        c (eval C)
  )
  (if
    (or (and a b c (<= a b c))
        (and a b (null c) (= a b))
        (and a (null b) (null c) (= a 0))
        (and (null a) (null b) (null c) (zerop (format:number-rest-value)))
    )
     (set $break-symbol 'BREAK)
  )
  ""
)

;;;_$ (format nil "~A~^:~A~^:~A~^:~A" '(123 456 789))
;;;"123:456:789"
;;;_$ (format nil "~A~^:~A~^:~A~^:~A" '(123 456 789 abc))
;;;"123:456:789:ABC"

;;

(defun format:main
       (token-list $break-symbol cursor / token-index token result)
  (setq token-index 0)
  (if token-list
    (apply 'strcat
           (progn (while (and (not (eval $break-symbol))
                              (setq token (eval (format:pop-token)))
                         )
                    (setq cursor (+ cursor (strlen token))
                          result (cons token result)
                    )
                  )
                  (reverse result)
           )
    )
    ""
  )
)

;;

(include 'format:formatString "./printer/_format-formatString")

(defun format
       (output formatString value-list / value-index format-top-level-break astring)
  (setq value-index 0
        astring     (format:main
                      (format:formatString (stringp-list formatString))
                      'format-top-level-break
                      0
                    )
  )
  (when output '(write-string astring output nil nil))
  astring
)
