;;;(include 'map "./sequences/map")

;;;(map $_type $_function $_list-of-sequence)
;;;
;;;$_type        : symbol
;;;
;;;$_function    : function
;;;
;;;$_list-of-sequence : list of sequence
;;;
;;;retrun  : atom, or list
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+


;;;_$ (map 'STR 'char-upcase (list "abcdefg"))
;;;"ABCDEFG"
;;;_$ (map 'LIST '+ (list '(0 1 2 3 4) '(4 3 2 1 0)))
;;;(4 4 4 4 4)
;;;_$ (map 'ARRAY '+ (list '(0 1 2 3 4) '(4 3 2 1 0)))
;;;#<safearray...>

(include 'sequencep-list "./sequences/_sequencep-list")

(defun map ($_type $_function $_list-of-sequence)
  (coerce (apply 'mapcar
                 (cons $_function
                       (mapcar (function (lambda (seq) (sequencep-list seq)))
                               $_list-of-sequence
                       )
                 )
          )
          $_type
  )
)