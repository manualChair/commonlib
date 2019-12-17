;;;(include 'padding "./sequences/padding")

;;;(padding sequence mode width overflow pad)
;;;
;;;sequence : sequence
;;;
;;;mode : symbol ('LEFT 'RIGHT 'BOTH)
;;;
;;;width : integer
;;;
;;;overflow , pad : atom or list
;;;
;;;retrun  : sequence
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (padding "10.0" 'LEFT 7 nil (ascii "*"))
;;;"***10.0"
;;;_$ (padding "10.0" 'RIGHT 7 nil (ascii "*"))
;;;"10.0***"
;;;_$ (padding "10.0" 'BOTH 7 nil (ascii "*"))
;;;"*10.0*"
;;;_$ (padding "10.0" 'LEFT 3 nil (ascii "*"))
;;;"0.0"
;;;_$ (padding "10.0" 'LEFT 3 (ascii "#") (ascii "*"))
;;;"###"

(include 'default "./common/default")
(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'padding-list "./sequences/padding-list")

(defun padding (sequence mode width overflow pad)
  (coerce (padding-list
            (sequencep-list sequence)
            mode
            width
            overflow
            (default pad '(ascii " "))
          )
          (sequence-type-of sequence)
  )
)
