;;;(include 'concatenate "./sequences/concatenate")

;;;(concatenate atype list-of-sequence)
;;;
;;;atype            : symbol (STR LIST SLIST SYM VARIANT SAFEARRAY VECTOR)
;;;
;;;list-of-sequence : list of sequence
;;;
;;;return           : sequence
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (concatenate 'LIST '((0 1 2 3) (A B C D)))
;;;(0 1 2 3 A B C D)
;;;_$ (concatenate 'STR '("Auto" "CAD"))
;;;"AutoCAD"
;;;_$ (concatenate 'SLIST '("Auto" "CAD"))
;;;(65 117 116 111 67 65 68)

(include 'type-of "./types/type-of")
(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")

(defun concatenate (atype list-of-sequence)
  (coerce (apply 'append
            (mapcar (function (lambda (sequence) (sequencep-list sequence)))
                    list-of-sequence
            )
          )
          atype
  )
)