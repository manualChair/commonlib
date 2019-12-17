;;;(include 'fill "./sequences/fill")

;;;(fill sequence item start end)
;;;
;;;sequence : sequence
;;;
;;;item : atom or list
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;return : sequence
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (fill '(0 1 2 3 4 5 6) '* 1 4)
;;;(0 * * * 4 5 6)
;;;_$ (fill '(0 1 2 3 4 5 6) '* 2 nil)
;;;(0 1 * * * * *)
;;;_$ (fill '(0 1 2 3 4 5 6) '* nil 3)
;;;(* * * 3 4 5 6)
;;;_$ (fill '(0 1 2 3 4 5 6) '* nil nil)
;;;(* * * * * * *)
;;;_$ (fill "ABCDEFG" (ascii "*") 1 4)
;;;"A***EFG"

(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'fill-list "./sequences/fill-list")

(defun fill (sequence item start end)
  (coerce (fill-list (sequencep-list sequence) item start end)
          (sequence-type-of sequence)
  )
)