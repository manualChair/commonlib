;;;(include 'subseq "./sequences/subseq")

;;;(subseq sequence start end)
;;;
;;;sequence : sequence
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

;;;_$ (subseq '(0 1 2 3 4 5 6) 1 4)
;;;(1 2 3)
;;;_$ (subseq '(0 1 2 3 4 5 6) 2 nil)
;;;(2 3 4 5 6)
;;;_$ (subseq '(0 1 2 3 4 5 6) nil 3)
;;;(0 1 2)
;;;_$ (subseq '(0 1 2 3 4 5 6) nil nil)
;;;(0 1 2 3 4 5 6)
;;;_$ (subseq "0123456" 2 4)
;;;"23"

(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'subseq-list "./sequences/subseq-list")

(defun subseq (sequence start end)
  (coerce (subseq-list (sequencep-list sequence) start end)
          (sequence-type-of sequence)
  )
)