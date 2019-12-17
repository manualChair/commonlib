;;;(include 'format:iteration:enter "./printer/_format-iteration")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'format:in-parentheses "./printer/_format-in-parentheses")
;;
(include 'integerp "./numbers/integerp")
(include 'subseq-list "./sequences/subseq-list")

(defun format:recursive:sub (token-list value-list / value-index)
  (setq value-index 0)
  (format:main token-list 'recursive-break nil)
)

;;

(defun format:recursive (modifier / recursive-break result)
  (setq
    result (if (not (null (member 'AT modifier)))
             (format:main
               (format:formatString (stringp-list (format:pop-value)))
               'recursive-break
               nil
             )
             (format:recursive:sub
               (format:formatString (stringp-list (format:pop-value)))
               (format:pop-value)
             )
           )
  )
  (if (= recursive-break 'EXIT)
    (set $break-symbol 'EXIT)
  )
  result
)

;;;_$ (format nil "~A : ~? ; ~A" '(| "~A ~A" (10 20) |))
;;;"| : 10 20 ; |"
;;;_$ (format nil "~A : ~@? ; ~A" '(| "~A ~A" (10 20) |))
;;;"| : (10 20) | ; nil"

;;

(defun format:iteration:non-option
       (token-list value-list repeat-count / value-index)
  (setq value-index 0)
  (format:iteration:at token-list repeat-count)
)

(defun format:iteration:at (token-list repeat-count / result)
  (while
    (and (or (and (null repeat-count) (< 0 (format:number-rest-value)))
             (< 0 repeat-count)
         )
         (/= recursive-break 'BREAK)
    )
     (setq result       (cons (format:main token-list 'recursive-break nil) result)
           repeat-count (if repeat-count
                          (1- repeat-count)
                        )
     )
  )
  (apply 'strcat (reverse result))
)

;;

(defun format:iteration:defun-break:sub
       (modifier a b c / format:number-rest-value)
  (setq format:number-rest-value
         (lambda () $number-rest-value)
        a (eval a)
        b (eval b)
        c (eval c)
  )
  (if (or (and a b c (<= a b c))
          (and a b (null c) (= a b))
          (and a (null b) (null c) (= a 0))
          (and (null a) (null b) (null c) (zerop $number-rest-value))
      )
    (set $break-symbol 'EXIT)
  )
)


(defun format:iteration:defun-break
       (*format:break* func args / format:break)
  (setq format:break
         (lambda (modifier a b c)
           (if (not (null (member 'COLON modifier)))
             (format:iteration:defun-break:sub modifier a b c)
             (*format:break* modifier a b c)
           )
           ""
         )
  )
  (apply func args)
)

(defun format:iteration:colon
       (token-list value-list repeat-count / value-index)
  (setq value-index 0)
  (format:iteration:colon+at token-list repeat-count (length value-list))
)

(defun format:iteration:colon+at
       (token-list repeat-count $number-rest-value / result)
  (format:iteration:defun-break
    format:break
    (function
      (lambda ()
        (while
          (and
            (or (and (null repeat-count) (< 0 (format:number-rest-value)))
                (< 0 repeat-count)
            )
            (/= recursive-break 'EXIT)
          )
           (setq recursive-break    nil
                 $number-rest-value (1- $number-rest-value)
                 result             (cons
                                      (format:recursive:sub token-list (format:pop-value))
                                      result
                                    )
                 repeat-count       (if repeat-count
                                      (1- repeat-count)
                                    )
           )
        )
        (apply 'strcat (reverse result))
        ;;
      )
    )
    nil
  )
)

;;

(defun format:iteration:exit (modifier) "")

(defun format:iteration:enter (modifier         repeat-count
                               /                exit-modifier
                               sub-token-list   recursive-break
                               result
                              )
  (setq format:iteration:exit
         (lambda (modifier) (setq exit-modifier modifier))
        sub-token-list
         (if (null (setq sub-token-list
                          (apply 'append
                                 (format:in-parentheses
                                   'iteration
                                 )
                          )
                   )
             )
           (format:formatString
             (stringp-list (format:pop-value))
           )
           sub-token-list
         )
        repeat-count
         (progn (setq repeat-count (eval repeat-count))
                (if (integerp repeat-count)
                  (if (not (minusp repeat-count))
                    repeat-count
                    0
                  )
                  (if (not (null (member 'COLON exit-modifier)))
                    1
                  )
                )
         )
        result (cond ((and (not (null (member 'COLON modifier)))
                           (not (null (member 'AT modifier)))
                      )
                      (format:iteration:colon+at
                        sub-token-list
                        repeat-count
                        (format:number-rest-value)
                      )
                     )
                     ((not (null (member 'COLON modifier)))
                      (format:iteration:colon
                        sub-token-list
                        (format:pop-value)
                        repeat-count
                      )
                     )
                     ((not (null (member 'AT modifier)))
                      (format:iteration:at sub-token-list repeat-count)
                     )
                     (T
                      (format:iteration:non-option
                        sub-token-list
                        (format:pop-value)
                        repeat-count
                      )
                     )
               )
  )
  result
)

;;;_$ (format nil "~{~A,~}" '((1 2 3 4 5 6)))
;;;"1,2,3,4,5,6,"
;;;_$ (format nil "~{~A~^,~}" '((1 2 3 4 5 6)))
;;;"1,2,3,4,5,6"
;;;_$ (format nil "~{~A~:^,~}" '((1 2 3 4 5 6)))
;;;"1,2,3,4,5,6"

;;;_$ (format nil "~:{~A ~A ,(~A) |~}" '(((1 2 +) (3 4) (5 6 *))))
;;;"1 2 ,(+) |3 4 ,(nil) |5 6 ,(*) |"
;;;_$ (format nil "~:{~A ~A ~^,(~A) ~^|~}" '(((1 2 +) (3 4) (5 6 *))))
;;;"1 2 ,(+) 3 4 5 6 ,(*) "
;;;_$ (format nil "~:{~A ~A ~^,(~A) ~:^|~}" '(((1 2 +) (3 4) (5 6 *))))
;;;"1 2 ,(+) |3 4 5 6 ,(*) "

;;;_$ (format nil "~@{~A,~}" '(1 2 3 4 5 6))
;;;"1,2,3,4,5,6,"
;;;_$ (format nil "~@{~A~^,~}" '(1 2 3 4 5 6))
;;;"1,2,3,4,5,6"
;;;_$ (format nil "~@{~A~:^,~}" '(1 2 3 4 5 6))
;;;"1,2,3,4,5,6"

;;;_$ (format nil "~:@{~A ~A ,(~A) |~}" '((1 2 +) (3 4) (5 6 *)))
;;;"1 2 ,(+) |3 4 ,(nil) |5 6 ,(*) |"
;;;_$ (format nil "~:@{~A ~A ~^,(~A) ~^|~}" '((1 2 +) (3 4) (5 6 *)))
;;;"1 2 ,(+) 3 4 5 6 ,(*) "
;;;_$ (format nil "~:@{~A ~A ~^,(~A) ~:^|~}" '((1 2 +) (3 4) (5 6 *)))
;;;"1 2 ,(+) |3 4 5 6 ,(*) "

;;;_$ (format nil "~2{~A ~}" '((1 2 3 4 5 6)))
;;;"1 2 "
;;;_$ (format nil "~2:{~A ~A ~}" '(((1 2) (3 4) (5 6))))
;;;"1 2 3 4 "
;;;_$ (format nil "~2@{~A ~}" '(1 2 3 4 5 6))
;;;"1 2 "
;;;_$ (format nil "~2:@{~A ~A ~}" '((1 2) (3 4) (5 6)))
;;;"1 2 3 4 "

;;;_$ (format nil "~{~A ~}" nil)
;;;""
;;;_$ (format nil "~{~A ~:}" nil)
;;;"nil "
;;;_$ (format nil "~0{~A ~:}" nil)
;;;""

;;;_$ (format nil "~{~}" '("~A " (1 2 3 4 5)))
;;;"1 2 3 4 5 "
;;;_$ (format nil "~:{~}" '("~A ~A " ((1 2) (3 4) (5 6))))
;;;"1 2 3 4 5 6 "

