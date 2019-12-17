;;;(include 'format:justification:enter "./printer/_format-justification")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'format:in-parentheses "./printer/_format-in-parentheses")
;;
(include 'typep "./types/typep")
(include 'plusp "./numbers/plusp")
(include 'signum "./numbers/signum")
(include 'ControlCode-p "./characters/ControlCode-p")
(include 'create-stack "./conses/stack")
(include 'count-list-if "./sequences/count-list-if")
(include 'remove-if "./sequences/remove-if")

(defun format:justification:padding-length-list
       (total-pad count / pad-length adjustment)
  (if (not (zerop count))
    (progn (setq pad-length (max (/ total-pad count) minimum)
                 adjustment (if
                              (plusp
                                (setq adjustment (- total-pad (* pad-length count)))
                              )
                               adjustment
                               0
                            )
           )
           (append (make-list (- count adjustment) pad-length)
                   (make-list adjustment (1+ pad-length))
           )
    )
  )
)

(defun format:justification:main (total-pad / pad-stack result)
  (setq pad-stack (create-stack
                    (format:justification:padding-length-list
                      total-pad
                      separetor-count
                    )
                  )
        result    (mapcar (function (lambda (token)
                                      (cond ((typep token 'STR) token)
                                            ((= token 'SEPARETOR)
                                             (make-string (pop pad-stack) pad-code)
                                            )
                                      )
                                    )
                          )
                          token-list
                  )
  )
  (release-handle pad-stack)
  result
)

(defun format:justification (token-list        /
                             total-str-length  separetor-count
                             missing-length    total-pad
                            )
  (setq total-str-length (apply '+
                                (mapcar
                                  (function (lambda (token)
                                              (if (typep token 'STR)
                                                (strlen (remove-if 'ControlCode-p
                                                                   token
                                                                   nil nil
                                                                   nil nil)
                                                )
                                                0
                                              )
                                            )
                                  )
                                  token-list
                                )
                         )
        separetor-count  (count-list-if
                           (function (lambda (token) (= token 'SEPARETOR)))
                           token-list
                           nil
                           nil
                         )
        missing-length   (- (+ total-str-length (* separetor-count minimum))
                            width
                         )
        width            (if (plusp missing-length)
                           (+ width
                              (* (+ (/ missing-length increment)
                                    (signum (rem missing-length increment))
                                 )
                                 increment
                              )
                           )
                           width
                         )
        total-pad        (- width total-str-length)
  )
  (format:justification:main total-pad)
)

(defun format:justification:defun-separator ()
  (lambda (modifier num-of-rest-char length-of-line)
    (setq result (cons (if (and (null $max-length)
                                (not (null (member 'COLON modifier)))
                           )
                         (progn (setq $max-length
                                       (- (default (eval length-of-line) '80)
                                          cursor
                                          (default (eval num-of-rest-char) '0)
                                       )
                                )
                                'ADDITIONAL
                         )
                         'SEPARETOR
                       )
                       result
                 )
    )
  )
)


(defun format:justification:set-header:sub (token-list)
  (if (not (endp token-list))
    (if (= (car token-list) 'ADDITIONAL)
      (progn (setq $additional-text
                    (format:main
                      (cadr token-list)
                      'justification-break
                      nil
                    )
             )
             nil
      )
      (cons (car token-list)
            (format:justification:set-header:sub (cdr token-list))
      )
    )
  )
)


(defun format:justification:set-header (token-list)
  (reverse (format:justification:set-header:sub (reverse token-list)))
)

(defun format:justification:in-parentheses (/ format:separator)
  (setq format:separator (format:justification:defun-separator))
  (format:in-parentheses 'justification)
)

(defun format:justification:clean-up (token-list)
  (if (not (endp token-list))
    (if (and (= (car token-list) 'SEPARETOR)
             (or (null (cdr token-list)) (= (cadr token-list) 'SEPARETOR))
        )
      (format:justification:clean-up (cdr token-list))
      (cons (car token-list)
            (format:justification:clean-up (cdr token-list))
      )
    )
  )
)

(defun format:justification:eval (token-list / result)
  (setq
    result (vl-remove-if
             (function (lambda (item) (or (null item) (= item ""))))
             (mapcar
               (function
                 (lambda (token-list)
                   (if (not justification-break)
                     (if (vl-symbolp token-list)
                       token-list
                       (format:main token-list 'justification-break nil)
                     )
                   )
                 )
               )
               token-list
             )
           )
  )
  (if (= justification-break 'EXIT)
    (set $break-symbol 'EXIT)
  )
  result
)

(defun format:justification:exit (modifier) "")

(defun format:justification:enter (modifier        width
                                   increment       minimum
                                   pad-code        /
                                   segments        justification-break
                                   $additional-text
                                   $max-length     $length-of-line
                                   result
                                  )
  (setq width     (max (default (eval width) '0) 0)
        increment (max (default (eval increment) '1) 1)
        minimum   (max (default (eval minimum) '0) 0)
        pad-code  (default (eval pad-code) '32 ;| (ascii " ") |;)
        segments  (format:justification:clean-up
                    (format:justification:eval
                      (format:justification:set-header
                        (format:justification:in-parentheses)
                      )
                    )
                  )
                  ;;
  )
  (if (not (null (member 'COLON modifier)))
    (setq segments (cons 'SEPARETOR segments))
  )
  (if (or (not (null (member 'AT modifier)))
          (null (member 'SEPARETOR segments))
      )
    (setq segments (append segments '(SEPARETOR)))
  )
  (if (and (setq result (apply 'strcat (format:justification segments)))
           (or (null $additional-text) (<= (strlen result) $max-length))
      )
    result
    (strcat $additional-text result)
  )
)


;;;_$ (format nil "~25<~A~;~A~;~A~>" '(123 456 789))
;;;"123        456        789"
;;;_$ (format nil "~25:<~A~;~A~;~A~>" '(123 456 789))
;;;"     123     456      789"
;;;_$ (format nil "~25@<~A~;~A~;~A~>" '(123 456 789))
;;;"123     456     789      "
;;;_$ (format nil "~25:@<~A~;~A~;~A~>" '(123 456 789))
;;;"    123    456    789    "

;;;_$ (format nil "~25,,,'#:@<~A~;~A~;~A~>" '(123 456 789))
;;;"####123####456####789####"

;;;_$ (format nil "~25:@<~A~^~;~A~^~;~A~>" '(123 456 789))
;;;"    123    456    789    "
;;;_$ (format nil "~25:@<~A~^~;~A~^~;~A~>" '(123 456))
;;;"      123      456       "
;;;_$ (format nil "~25:@<~A~^~;~A~^~;~A~>" '(123))
;;;"           123           "

;;;_$ (format nil "~A~8:<\n~,13:;~A~>" '(12345 ABCD))
;;;"12345    ABCD"
;;;_$ (format nil "~A~9:<\n~,13:;~A~>" '(12345 ABCD))
;;;"12345\n     ABCD"
;;;_$ (format nil "~8<\n~5,13:;~A~>12345" '(ABCD))
;;;"ABCD    12345"
;;;_$ (format nil "~9<\n~5,13:;~A~>12345" '(ABCD))
;;;"\nABCD     12345"

;;;_$ (format nil "~10:@<~A~;~A~>" '(12345 ABCDE))
;;;"12345ABCDE"
;;;_$ (format nil "~10:@<~A~;~A~>" '(123456 ABCDEF))
;;;"123456ABCDEF"
;;;_$ (format nil "~10,,1:@<~A~;~A~>" '(123456 ABCDEF))
;;;" 123456 ABCDEF "
;;;_$ (format nil "~10,6:@<~A~;~A~>" '(123456 ABCDEF))
;;;" 123456 ABCDEF  "
