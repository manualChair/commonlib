;;;(include 'unicode "./types/multibyte/_unicode")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'defstruct "./structures/defstruct")
(include 'padding-list "./sequences/padding-list")
(include 'parse-integer-list "./numbers/parse-integer-list")
(include 'plusp "./numbers/plusp")
(include 'digit-char "./characters/digit-char")

(defstruct 'unicode '((code . '0)))

(defun encode:unicode-p (clist)
  (and (= (car clist) 92 ;| \ |;)
       (or (= (cadr clist) 85 ;| U |;) (= (cadr clist) 117 ;| u |;))
       (= (caddr clist) 43 ;| + |;)
  )
)

(defun encode:unicode:make (clist)
  (make-unicode (parse-integer-list clist 0 4 16 nil))
)

(defun encode:unicode (clist) (cons (encode:unicode:make (cdddr clist)) 7))

;;

(defun decode:unicode:to-hex-string (integer / stack)
  (while (plusp integer)
    (setq stack   (cons (digit-char (rem integer 16) radix) stack)
          integer (/ integer 16)
    )
  )
  stack
)

(defun decode:unicode (unicode-s)
  (append '(92 85 43) ;_ \U+
          (padding-list
            (decode:unicode:to-hex-string (unicode-code unicode-s))
            'LEFT
            4
            nil
            48 ;|(ascii "0")|;
          )
  )
)
