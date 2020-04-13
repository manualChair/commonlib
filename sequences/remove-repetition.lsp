;;;(include 'remove-repetition "./sequences/remove-repetition")

;;;(remove-repetition sequence test-func start end from-end)
;;;
;;;sequence : sequence
;;;
;;;test-func : function
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;from-end : atom (T or nil)
;;;
;;;return : sequence
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (remove-repetition '(0 0 1 1 2 2 1 2) '= nil nil nil)
;;;(0 1 2 1 2)
;;;_$ (remove-repetition '(0 0 1 1 2 2 1 2) '= 1 5 nil)
;;;(0 0 1 2 2 1 2)
;;;_$ (remove-repetition "WwwwwwHOooooo" 'char-equal nil nil nil)
;;;"wHo"
;;;_$ (remove-repetition "WwwwwwHOooooo" 'char-equal nil nil T)
;;;"WHO"

(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'remove-repetition-list "./sequences/remove-repetition-list")

(defun remove-repetition (sequence test-func start end from-end)
  (coerce (remove-repetition-list
            (sequencep-list sequence)
            test-func
            start
            end
            from-end
          )
          (sequence-type-of sequence)
  )
)
