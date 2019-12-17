;;;(include 'concatenate "./sequences/concatenate")

;;;(concatenate atype list-of-sequence)
;;;
;;;atype            : symbol
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