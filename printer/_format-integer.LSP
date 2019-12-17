;;;(include 'format:integer "./printer/_format-integer")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'format:integer->slist "./printer/_format-integer-slist")
(include 'format:integer:grouping "./printer/_format-integer-grouping")
(include 'registry:getGrouping "./printer/_format-wondows-registry")
;;
(include 'default "./common/default")
(include 'coerce "./types/coerce")
(include 'compose "./evaluation/compose")
(include 'apply-partial "./evaluation/apply-partial")
(include 'padding-list "./sequences/padding-list")
(include 'reduce "./sequences/reduce")
(include 'round-off "./numbers/round-off")

;;

(defun format:integer:padding (alist)
  (if (< (length alist) width)
    (padding-list alist 'LEFT width nil pad-code)
    alist
  )
)

(defun format:integer
       (modifier radix width pad-code comma-code comma-interval)
  (setq radix          (default (eval radix) '10)
        width          (max (default (eval width) '0) 0)
        pad-code       (default (eval pad-code) '32 ;| (ascii " ") |;)
        comma-code     (default (eval comma-code) '(registry:getThousand) ;| (ascii ",") |;)
        comma-interval (max (default (eval comma-interval) '(registry:getGrouping)) 1)
  )
  (coerce ((reduce 'compose
                   (list (if (not (null (member 'COLON modifier)))
                           '(apply-partial
                             'format:integer:grouping
                             (list comma-code comma-interval)
                             '(1)
                            )
                         )
                         'format:integer:padding
                   )
           )
            (format:integer->slist
              (fix (round-off (format:pop-value) 0))
              radix
              nil
              nil
              (not (null (member 'AT modifier)))
            )
          )
          'STR
  )
)

(defun format:integer-10
       (modifier width pad-code comma-code comma-interval)
  (format:integer modifier 10 width pad-code comma-code comma-interval)
)

(defun format:integer-2
       (modifier width pad-code comma-code comma-interval)
  (format:integer modifier 2 width pad-code comma-code comma-interval)
)

(defun format:integer-8
       (modifier width pad-code comma-code comma-interval)
  (format:integer modifier 8 width pad-code comma-code comma-interval)
)

(defun format:integer-16
       (modifier width pad-code comma-code comma-interval)
  (format:integer modifier 16 width pad-code comma-code comma-interval)
)

;;;_$ (format nil "~D ~D" '(1234 -1234.56))
;;;"1234 -1235"
;;;_$ (format nil "~@D ~@D" '(1234 -1234.56))
;;;"+1234 -1235"
;;;_$ (format nil "~@:D ~@:D" '(1234 -1234.56))
;;;"+1,234 -1,235"

;;;_$ (format nil "~6D" '(1234))
;;;"  1234"
;;;_$ (format nil "~6@D" '(1234))
;;;" +1234"
;;;_$ (format nil "~6,'#D" '(1234))
;;;"##1234"
;;;_$ (format nil "~6,'#,';:D" '(1234))
;;;"#1;234"
;;;_$ (format nil "~6,'#,';,2:D" '(1234))
;;;"#12;34"

;;;_$ (format nil "~8,,':,2:D ~8,,':,2:B ~8,,':,2:O ~8,,':,2:X" '(16 16 16 16))
;;;"      16  1:00:00       20       10"

;;;_$ (format nil "~10,6,,':,2:R" '(255))
;;;"  2:55"
;;;_$ (format nil "~2,6,,':,2:R" '(255))
;;;"11:11:11:11"
;;;_$ (format nil "~8,6,,':,2:R" '(255))
;;;"  3:77"
;;;_$ (format nil "~16,6,,':,2:R" '(255))
;;;"    FF"
;;;_$ (format nil "~32,6,,':,2:R" '(255))
;;;"    7V"
