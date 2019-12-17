;;;(include 'make-string "./strings/make-string")

;;;(make-string size initial-element)
;;;
;;;size : integer
;;;
;;;initial-element : integer,list
;;;
;;;return : string

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (make-string 5 (ascii "a"))
;;;"aaaaa"
;;;_$ (make-string 5 '(SHIFT_JIS 33440))
;;;"����������"

(include 'characterp "./characters/characterp")
(include 'make-list "./conses/make-list")
(include 'list->string "./types/multibyte/list-string")

(defun make-string (size initial-element)
  (if (characterp initial-element)
    (list->string (make-list size initial-element))
    (exit)
  )
)