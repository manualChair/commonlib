;;;(include 'format:integer->slist "./strings/_format-integer-slist")

;;;(format:integer->slist atype integer radix width add-sign)
;;;
;;;integer : integer
;;;
;;;radix : integer (2~36) or if nil 10
;;;
;;;width : integer or nil
;;;
;;;add-sign : T or nil
;;;
;;;retrun : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (format:integer->slist 255 10 nil nil)
;;;(50 53 53)
;;;_$ (format:integer->slist 255 10 5 nil)
;;;(48 48 50 53 53)
;;;_$ (format:integer->slist 255 10 5 T)
;;;(43 48 50 53 53)
;;;_$ (format:integer->slist 255 2 nil nil)
;;;(49 49 49 49 49 49 49 49)

(include 'default "./common/default")
(include 'scope-p "./common/scope-p")
(include 'digit-char "./characters/digit-char")
(include 'integerp "./numbers/integerp")
(include 'plusp "./numbers/plusp")
(include 'make-list "./conses/make-list")
(include 'padding-list "./sequences/padding-list")

(defun format:integer->slist
       (integer radix width pad-code add-sign / stack sign result)
  (if (integerp integer)
    (progn
      (setq sign  (if (minusp integer)
                    (list 45 ;|(ascii "-")|;)
                    (if add-sign
                      (list 43 ;|(ascii "+")|;)
                    )
                  )
            width (if (and width (plusp width))
                    (if sign
                      (if (< 1 width)
                        (1- width)
                      )
                      width
                    )
                  )
      )
      (if (zerop integer)
        (append sign
                (if width
                  (make-list width 48 ;|(ascii "0")|;)
                  '(48)
                )
        )
        (if (scope-p (setq radix (default radix 10)) 2 36)
          (progn (setq integer (abs integer))
                 (while (< 0 integer)
                   (setq stack   (cons (digit-char (rem integer radix) radix) stack)
                         integer (/ integer radix)
                   )
                 )
                 (append sign
                         (if (and width (< (length stack) width))
                           (padding-list stack 'LEFT width nil pad-code)
                           stack
                         )
                 )
          )
          (exit)
        )
      )
    )
  )
)
