;;;(include 'format:tilde "./printer/_format-control-code")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'default "./common/default")
(include 'make-list "./conses/make-list")
(include 'make-string "./strings/make-string")
(include 'plusp "./numbers/plusp")

(defun format:line-feed (modifier number)
  (setq number (default (eval number) 1))
  (if (plusp number)
    (make-string number 10 ;| LF "\n"|;)
    ""
  )
)

;;;_$ (format nil "~%" nil)
;;;"\n"
;;;_$ (format nil "~5%" nil)
;;;"\n\n\n\n\n"

(defun format:fresh-line (modifier number)
  (setq number (default (eval number) 1))
  (if (plusp number)
    (make-string
      (if (zerop cursor)
        (1- number)
        number
      )
      10 ;| LF "\n"|;
    )
    ""
  )
)

;;;_$ (format nil "~&" nil)
;;;""
;;;_$ (format nil "ABCD~&" nil)
;;;"ABCD\n"
;;;_$ (format nil "~5&" nil)
;;;"\n\n\n\n"
;;;_$ (format nil "ABCD~5&" nil)
;;;"ABCD\n\n\n\n\n"

(defun format:page-feed (modifier number)
  (setq number (default (eval number) 1))
  (if (plusp number)
    (make-string number 12 ;| FF |;)
    ""
  )
)

;;;_$ (format nil "~|" nil)
;;;"\014"
;;;_$ (format nil "~5|" nil)
;;;"\014\014\014\014\014"

(defun format:tilde (modifier number)
  (setq number (default (eval number) 1))
  (if (plusp number)
    (make-string (default (eval number) 1) 126 ;| "~" |;)
    ""
  )
)

;;;_$ (format nil "~~" nil)
;;;"~"
;;;_$ (format nil "~5~" nil)
;;;"~~~~~"
