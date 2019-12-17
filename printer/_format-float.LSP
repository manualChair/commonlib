;;;(include 'format:monetary "./printer/_format-float")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'format:integer->slist "./printer/_format-integer-slist")
(include 'registry:getGrouping "./printer/_format-wondows-registry")
;;
(include 'default "./common/default")
(include 'coerce "./types/coerce")
(include 'char-equal "./characters/char-equal")
(include 'make-list "./conses/make-list")
(include 'plusp "./numbers/plusp")
(include 'log-b "./numbers/log-b")
(include 'round-off "./numbers/round-off")
(include 'padding-list "./sequences/padding-list")
(include 'subseq-list "./sequences/subseq-list")
(include 'position-list-if "./sequences/position-list-if")

(defun format:fixed-format:rtos:integer (float-integer / sign alist)
  (setq sign  (if (minusp float-integer)
                (list 45) ;|(ascii "-")|;
                (if add-sign
                  (list 43) ;|(ascii "+")|;
                )
              )
        alist (coerce (rtos (abs float-integer) 2 0) 'SLIST)
  )
  (if integer-digit
    (setq alist (padding-list
                  alist 'LEFT integer-digit nil 48 ;|(ascii "0")|;)
    )
  )
  (setq alist (append sign alist))
  (if grouping
    (format:integer:grouping
      alist
      (registry:getThousand)
      (registry:getGrouping)
    )
    alist
  )
)

(defun format:fixed-format:rtos:decimals
       (float-decimals / alist period-pos)
  (if (setq alist      (coerce (rtos float-decimals 2 decimal-digit) 'SLIST)
            period-pos (position-list-if
                         (function (lambda (item) (= item 46 ;|(ascii ".")|;)))
                         alist
                         nil
                         nil
                         nil
                       )
      )
    (subseq-list alist (1+ period-pos) nil)
  )
)

(defun format:fixed-format:rtos
       (float-value integer-digit decimal-digit add-sign grouping / int)
  (append (if (not (zerop (setq int (fix (round-off float-value decimal-digit)))))
            (format:fixed-format:rtos:integer int)
            (if (minusp float-value)
              '(45 48) ;|"-0"|;
              (if add-sign
                '(43 48) ;|"+0"|;
                '(48) ;|"0"|;
              )
            )
          )
          (if grouping
            (list (registry:getDecimal))
            '(46) ;|(ascii ".")|;
          )
          (padding-list
            (format:fixed-format:rtos:decimals (- float-value int))
            'RIGHT
            decimal-digit
            nil
            48 ;|(ascii "0")|;
          )
  )
)

(defun format:fixed-format:overflow (alist)
  (if (and (not overflow-code) (<= width (length alist)))
    alist
    (padding-list alist 'LEFT width overflow-code pad-code)
  )
)

(defun format:fixed-format
       (modifier width digits shift overflow-code pad-code)
  (setq width         (max (default (eval width) '0) 0)
        digits        (max (default (eval digits) '(getvar "LUPREC")) 0)
        shift         (default (eval shift) '0)
        overflow-code (default (eval overflow-code) nil)
        pad-code      (default (eval pad-code) '32 ;| (ascii " ") |;)
  )
  (coerce (format:fixed-format:overflow
            (format:fixed-format:rtos
              (* (float (format:pop-value)) (expt 10.0 shift))
              nil
              digits
              (not (null (member 'AT modifier)))
              (not (null (member 'COLON modifier)))
            )
          )
          'STR
  )
)

;;;_$ (format nil "~F ~F" '(1234 -1234.56))
;;;"1234.00 -1234.56"
;;;_$ (format nil "~,4F ~,4F" '(1234 -1234.56))
;;;"1234.0000 -1234.5600"
;;;_$ (format nil "~10F ~10F" '(1234 -1234.56))
;;;"   1234.00   -1234.56"
;;;_$ (format nil "~,,2F ~,,2F" '(1234 -1234.56))
;;;"123400.00 -123456.00"
;;;_$ (format nil "~,,-4F ~,,-4F" '(1234 -1234.56))
;;;"0.12 -0.12"
;;;_$ (format nil "~@F ~@F" '(1234 -1234.56))
;;;"+1234.00 -1234.56"

;;;_$ (format nil "~10,3,,'#,'@F" '(-1234.56789))
;;;"@-1234.568"
;;;_$ (format nil "~10,4,,'#,'@F" '(-1234.56789))
;;;"-1234.5679"
;;;_$ (format nil "~10,5,,'#,'@F" '(-1234.56789))
;;;"##########"

;;;

(defun format:exponential:rtos
       (float-value digits exponents shift add-sign / base)
  (setq base (- (fix (log-b (abs float-value) 10)) shift -1))
  (append
    (format:fixed-format:rtos
      (/ float-value (expt 10.0 base))
      nil
      digits
      add-sign
      nil
    )
    (cons
      exponent-code
      (format:integer->slist base 10 (1+ exponents) 48 ;|(ascii "0")|; T)
    )
  )
)


(defun format:exponential (modifier      width         digits
                           exponents     shift         overflow-code
                           pad-code      exponent-code
                          )
  (setq width         (max (default (eval width) '0) 0)
        digits        (max (default (eval digits) '(getvar "LUPREC")) 0)
        exponents     (max (default (eval exponents) '0) 0)
        shift         (default (eval shift) '1)
        overflow-code (default (eval overflow-code) nil)
        pad-code      (default (eval pad-code) '32 ;| (ascii " ") |;)
        exponent-code (default (eval exponent-code) '101 ;| (ascii "e") |;)
  )
  (coerce (format:fixed-format:overflow
            (format:exponential:rtos
              (float (format:pop-value))
              digits
              exponents
              shift
              (not (null (member 'AT modifier)))
            )
          )
          'STR
  )
)

;;;_$ (format nil "~E ~E" '(1234 -1234.56))
;;;"1.23e+3 -1.23e+3"
;;;_$ (format nil "~,4E ~,4E" '(1234 -1234.56))
;;;"1.2340e+3 -1.2346e+3"
;;;_$ (format nil "~,4,3E ~,4,3E" '(1234 -1234.56))
;;;"1.2340e+003 -1.2346e+003"
;;;_$ (format nil "~@E ~@E" '(1234 -1234.56))
;;;"+1.23e+3 -1.23e+3"

;;;_$ (format nil "~,4,,2E ~,4,,2E" '(1234 -1234.56))
;;;"12.3400e+2 -12.3456e+2"
;;;_$ (format nil "~,4,,-2E ~,4,,-2E" '(1234 -1234.56))
;;;"0.0012e+6 -0.0012e+6"

;;;_$ (format nil "~10,,,2,'#,'@,'!E" '(-12345.6789))
;;;"@-12.35!+3"
;;;_$ (format nil "~10,,,3,'#,'@,'!E" '(-12345.6789))
;;;"-123.46!+2"
;;;_$ (format nil "~10,,,4,'#,'@,'!E" '(-12345.6789))
;;;"##########"

;;;

;|
(defun format:float (modifier   width      digits     exponents
                     shift      overflow-code         pad-code
                     exponent-code         /          arg
                     base       ee         ww         d
                     dd
                    )
  (setq arg  (format:pop-value)
        base (log-b arg 10)
        ee   (+ (default (eval exponents) '2) 2)
        ww   (if width
               (- width ee)
             )
        d    (default (eval digits) (max 0 (min base 7)))
        dd   (- d base)
  )
  (format:skip-value -1)
  (if (and (<= 0 dd) (<= dd d))
    (format:fixed-format modifier ww d nil overflow-code pad-code)
    (format:exponential
      modifier      width         digits        exponents
      shift         overflow-code pad-code      exponent-code
     )
  )
)
|;

;;;

(defun format:monetary:padding (alist-signed / sign alist)
  (setq sign  (if (and (= (car alist-signed) 43 ;|(ascii "+")|;)
                       (null (member 'AT modifier))
                  )
                nil
                (list (car alist-signed))
              )
        alist (cdr alist-signed)
  )
  (if (<= width (+ (length sign) (length alist)))
    (append sign alist)
    (if (not (null (member 'COLON modifier)))
      (append
        sign
        (padding-list alist 'LEFT (- width (length sign)) nil pad-code)
      )
      (padding-list (append sign alist) 'LEFT width nil pad-code)
    )
  )
)

(defun format:monetary
       (modifier digits integer-digit width pad-code / sign)
  (setq digits        (max (default (eval digits) '2) 2)
        integer-digit (max (default (eval integer-digit) '1) 1)
        width         (max (default (eval width) '0) 0)
        pad-code      (default (eval pad-code) '32 ;| (ascii " ") |;)
  )
  (coerce (append sign
                  (format:monetary:padding
                    (format:fixed-format:rtos
                      (float (format:pop-value))
                      (1+ integer-digit)
                      digits
                      T
                      nil
                    )
                  )
          )
          'STR
  )
)

;;;_$ (format nil "\\ ~$ \\ ~$" '(1234 -1234.56789))
;;;"\\ 1234.00 \\ -1234.57"
;;;_$ (format nil "\\ ~@$ \\ ~@$" '(1234 -1234.56789))
;;;"\\ +1234.00 \\ -1234.57"
;;;_$ (format nil "\\ ~4$ \\ ~4$" '(1234 -1234.56789))
;;;"\\ 1234.0000 \\ -1234.5679"
;;;_$ (format nil "\\ ~,7$ \\ ~,7$" '(1234 -1234.56789))
;;;"\\ 0001234.00 \\ -0001234.57"

;;;_$ (format nil "\\ ~,,10,'@$ \\ ~,,10,'@$" '(1234 -1234.56789))
;;;"\\ @@@1234.00 \\ @@-1234.57"
;;;_$ (format nil "\\ ~:,,10,'@$ \\ ~:,,10,'@$" '(1234 -1234.56789))
;;;"\\ @@@1234.00 \\ -@@1234.57"
;;;_$ (format nil "\\ ~:@,,10,'@$ \\ ~:@,,10,'@$" '(1234 -1234.56789))
;;;"\\ +@@1234.00 \\ -@@1234.57"
