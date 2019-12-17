;;;(include 'affix "./sequences/affix")

;;;(affix sequence deco mode)
;;;
;;;sequence : sequence
;;;
;;;deco : sequence
;;;
;;;mode : symbol ('LEFT 'RIGHT 'BOTH or nil)
;;;
;;;return : sequence
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (affix "HAPPY" "*+*" 'LEFT)
;;;"*+*HAPPY"
;;;_$ (affix "HAPPY" "*+*" 'RIGHT)
;;;"HAPPY*+*"
;;;_$ (affix "HAPPY" "*+*" 'BOTH)
;;;"*+*HAPPY*+*"
;;;_$ (affix "HAPPY" "*+*" nil)
;;;"*+*"
;;;_$ (affix '(A A A A) '(* *) 'LEFT)
;;;(* * A A A A)

(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'affix-list "./sequences/affix-list")

(defun affix (sequence deco mode)
  (coerce (affix-list (sequencep-list sequence) (sequencep-list deco) mode)
          (sequence-type-of sequence)
  )
)