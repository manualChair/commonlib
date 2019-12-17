;;;(include 'format:prinx "./printer/_format-prinx")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'default "./common/default")
(include 'coerce "./types/coerce")
(include 'compose "./evaluation/compose")
(include 'make-list "./conses/make-list")
(include 'ceiling "./numbers/ceiling")
(include 'reduce "./sequences/reduce")
(include 'string-equal "./strings/string-equal")

(defun format:prinx:colon (alist)
  (if
    (and
      (not (null (member 'COLON modifier)))
      (string-equal alist '(110 105 108) ;| "nil" |; nil nil nil nil)
    )
     '(40 41) ;| "()" |;
     alist
  )
)

(defun format:prinx:at ;|@|;   (alist / append-at)
  (setq append-at (if (not (null (member 'AT modifier)))
                    (lambda (x-fix) (append x-fix alist))
                    (lambda (x-fix) (append alist x-fix))
                  )
  )
  (setq alist (append-at (make-list minimum pad-code)))
  ;;
  (if (< (length alist) width)
    (setq alist (append-at
                     (make-list
                       (* (ceiling (/ (float (- width (length alist))) group) nil)
                          group
                       )
                       pad-code
                     )
                   )
    )
  )
  alist
)


(defun format:prinx (alist)
  (apply '(reduce 'compose '(format:prinx:colon format:prinx:at))
         (list alist)
  )
)

(defun format:princ (modifier width group minimum pad-code)
  (setq width    (max (default (eval width) '0) 0)
        group    (max (default (eval group) '1) 1)
        minimum  (max (default (eval minimum) '0) 0)
        pad-code (default (eval pad-code) '32 ;| (ascii " ") |;)
  )
  ;;
  (coerce
    (format:prinx (coerce (vl-princ-to-string (format:pop-value)) 'SLIST))
    'STR
  )
)


(defun format:prin1 (modifier width group minimum pad-code)
  (setq width    (max (default (eval width) '0) 0)
        group    (max (default (eval group) '1) 1)
        minimum  (max (default (eval minimum) '0) 0)
        pad-code (default (eval pad-code) '32 ;| (ascii " ") |;)
  )
  ;;
  (coerce
    (format:prinx (coerce (vl-prin1-to-string (format:pop-value)) 'SLIST))
    'STR
  )
)

;;;_$ (format nil "~A ~A ~A ~A ~A ~A" '(10 123.45 "ABCD" SYMBOL (1 2 3)))
;;;"10 123.45 ABCD SYMBOL (1 2 3) nil"
;;;_$ (format nil "~A ~A ~A ~A ~A ~:A" '(10 123.45 "ABCD" SYMBOL (1 2 3)))
;;;"10 123.45 ABCD SYMBOL (1 2 3) ()"

;;;_$ (format nil "~10,,,'*A" '(1334))
;;;"1334******"
;;;_$ (format nil "~@10,,,'*A" '(1334))
;;;"******1334"

;;;_$ (format nil "~10,8,,'*A" '(1334))
;;;"1334********"
;;;_$ (format nil "~@10,8,,'*A" '(1334))
;;;"********1334"

;;;_$ (format nil "~,,3,'*A" '(1334))
;;;"1334***"
;;;_$ (format nil "~@,,3,'*A" '(1334))
;;;"***1334"

;;;_$ (format nil "~15,,3,'*A" '(1334))
;;;"1334***********"
;;;_$ (format nil "~15,7,3,'*A" '(1334))
;;;"1334*****************"

;;;_$ (format nil "~10,,,'*S" '("ABC"))
;;;"\"ABC\"*****"
