;;;(include 'format:integer:grouping "./printer/_format-integer-grouping")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'endp "./conses/endp")
(include 'digit-char-p "./characters/digit-char-p")

(defun format:integer:grouping:sub (alist index)
  (if (not (endp alist))
    (if (digit-char-p (cadr alist) radix)
      (cons (car alist)
            (if (zerop (setq index (1- index)))
              (cons comma-code
                    (format:integer:grouping:sub (cdr alist) comma-interval)
              )
              (format:integer:grouping:sub (cdr alist) index)
            )
      )
      alist
    )
  )
)

(defun format:integer:grouping (alist comma-code comma-interval)
  (reverse (format:integer:grouping:sub (reverse alist) comma-interval))
)