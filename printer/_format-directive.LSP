;;;(include '*format-directive* "./printer/_format-directive")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'format:prinx "./printer/_format-prinx")
(include 'format:tilde "./printer/_format-control-code")
(include 'format:integer "./printer/_format-integer")
(include 'format:monetary "./printer/_format-float")
(include 'format:case-conversion:enter "./printer/_format-case-conversion")
(include 'format:justification:enter "./printer/_format-justification")
(include 'format:conditional:enter "./printer/_format-conditional")
(include 'format:iteration:enter "./printer/_format-iteration")
;;
(include 'default "./common/default")
(include 'coerce "./types/coerce")
(include 'make-string "./strings/make-string")
(include 'ceiling "./numbers/ceiling")
(include 'plusp "./numbers/plusp")
(include 'integerp "./numbers/integerp")

;;

(defun format:separator (modifier rest-char-on-line length-of-line) "")

;;

(defun format:go-to (modifier number)
  (if (not (minusp (setq number (default (eval number) '1))))
    (progn (if (not (null (member 'AT modifier)))
             (format:set-value-index number)
             (format:skip-value
               (if (not (null (member 'COLON modifier)))
                 (- number)
                 number
               )
             )
           )
           ""
    )
    (exit)
  )
)

;;;_$ (format nil "~A ~A ~A ~A" '(0 1 2 3 4 5 6))
;;;"0 1 2 3"
;;;_$ (format nil "~A ~A ~2*~A ~A" '(0 1 2 3 4 5 6))
;;;"0 1 4 5"
;;;_$ (format nil "~A ~A ~:1*~A ~A" '(0 1 2 3 4 5 6))
;;;"0 1 1 2"
;;;_$ (format nil "~A ~A ~@5*~A ~A" '(0 1 2 3 4 5 6))
;;;"0 1 5 6"

;;


(defun format:tabulate:at ()
  (make-string
    (+ heading
       (- (* column (ceiling (/ (+ cursor heading) (float column)) nil))
          (+ cursor heading)
       )
    )
    32 ;|(ascii " ")|;
  )
)

(defun format:tabulate:non-option ()
  (if (<= heading cursor)
    (make-string
      (- (+ heading (* column (1+ (/ (- cursor heading) column)))) cursor)
      32 ;|(ascii " ")|;
    )
    (make-string (- heading cursor) 32)
  )
)

(defun format:tabulate (modifier heading column)
  (setq heading (max (default (eval heading) '1) 0)
        column  (max (default (eval column) '1) 1)
  )
  (if (not (null (member 'AT modifier)))
    (format:tabulate:at)
    (format:tabulate:non-option)
  )
)

;;;_$ (format nil "~2T/~2T/~2T/" nil)
;;;"  / / /"
;;;_$ (format nil "~2,4T/~2,4T/~2,4T/" nil)
;;;"  /   /   /"
;;;_$ (format nil "~2,4T///~2,4T///~2,4T///" nil)
;;;"  /// /// ///"

;;;_$ (format nil "~2@T/~2@T/~2@T/" nil)
;;;"  /  /  /"
;;;_$ (format nil "~2,4@T/~2,4@T/~2,4@T/" nil)
;;;"    /   /   /"
;;;_$ (format nil "~2,4@T///~2,4@T///~2,4@T///" nil)
;;;"    ///     ///     ///"

;;

(defun format:plural (modifier / value)
  (if (integerp (setq value (format:pop-value)))
    (if (= value 1)
      (if (not (null (member 'AT modifier)))
        "y"
        ""
      )
      (if (not (null (member 'AT modifier)))
        "ies"
        "s"
      )
    )
    (exit)
  )
)

;;;_$ (format t "bo~@p and girl~p" '(1 1))
;;;"boy and girl"
;;;_$ (format t "bo~@p and girl~p" '(2 1))
;;;"boies and girl"
;;;_$ (format t "bo~@p and girl~p" '(2 2))
;;;"boies and girls"

;;

(defun format:character (modifier) (coerce (format:pop-value) 'STRC))

;;;_$ (format nil "~C ~C" '(65 (SHIFT_JIS 33440)))
;;;"A ��"

;;;

(setq *format-directive*
       '((65 ;|"A"|; format:princ 4)
         (83 ;|"S"|; format:prin1 4)
         ;;(87 ;|"W"|; nil 0)
         (67 ;|"C"|; format:character 0)
         (37 ;|"%"|; format:line-feed 1)
         (38 ;|"&"|; format:fresh-line 1)
         (124 ;|"|"|; format:page-feed 1)
         (126 ;|"~"|; format:tilde 1)
         (82 ;|"R"|; format:integer 5)
         (68 ;|"D"|; format:integer-10 4)
         (66 ;|"B"|; format:integer-2 4)
         (79 ;|"O"|; format:integer-8 4)
         (88 ;|"X"|; format:integer-16 4)
         (70 ;|"F"|; format:fixed-format 5)
         (69 ;|"E"|; format:exponential 7)
         ;;(71 ;|"G"|; format:float 7)
         (36 ;|"$"|; format:monetary 4)
         ;;(73 ;|"I"|; nil 1)
         (84 ;|"T"|; format:tabulate 2)
         (42 ;|"*"|; format:go-to 1)
         (63 ;|"?"|; format:recursive 0)
         (80 ;|"P"|; format:plural 0)
         ;;
         (60 ;|"<"|; format:justification:enter 4)
         (62 ;|">"|; format:justification:exit 0)
         ;;
         (91 ;|"["|; format:conditional:enter 1)
         (93 ;|"]"|; format:conditional:exit 0)
         ;;
         (123 ;|"{"|; format:iteration:enter 1)
         (125 ;|"}"|; format:iteration:exit 0)
         ;;
         (40 ;|"("|; format:case-conversion:enter 0)
         (41 ;|")"|; format:case-conversion:exit 0)
         ;;
         (94 ;|"^"|; format:break 3)
         (59 ;|";"|; format:separator 2)
        )
)
