;;;(include 'reverse-sequence "./sequences/reverse-sequence")

;;;(reverse-sequence sequence)
;;;
;;;sequence : sequence
;;;
;;;return : sequence
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")

(defun reverse-sequence (sequence)
  (coerce (reverse (sequencep-list sequence)) (sequence-type-of sequence))
)