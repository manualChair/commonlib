;;;(include 'replace-all "./sequences/replace-all")

;;;(replace-all new-sub-sequence sub-sequence sequence start end)
;;;
;;;new-sub-sequence : sequence
;;;
;;;sub-sequence : sequence
;;;
;;;sequence : sequence
;;;
;;;test-func : test function symbol (default equal)
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

;;;_$ (replace-all '(A B C) '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil nil nil)
;;;(0 1 2 A B C 0 1 2 A B C)
;;;_$ (replace-all '(A B C) '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil 5 nil)
;;;(0 1 2 3 4 0 1 2 A B C)
;;;_$ (replace-all "Pencil" "Pen" "Pen Apple Pinaple Pen" nil nil nil)
;;;"Pencil Apple Pinaple Pencil"
;;;_$ (replace-all "Pinapple" "APPLE" "Pen apple Apple APPLE" nil nil nil)
;;;"Pen apple Apple Pinapple"
;;;_$ (replace-all "Pinapple" "APPLE" "Pen apple Apple APPLE" 'char-equal nil nil)
;;;"Pen Pinapple Pinapple Pinapple"

(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'replace-all-list "./sequences/replace-all-list")

(defun replace-all
       (new-sub-sequence sub-sequence sequence test-func start end)
  (coerce (replace-all-list
            (sequencep-list new-sub-sequence)
            (sequencep-list sub-sequence)
            (sequencep-list sequence)
            test-func
            start
            end
          )
          (sequence-type-of sequence)
  )
)