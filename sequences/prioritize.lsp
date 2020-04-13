;;;(include 'prioritize "./sequences/prioritize")

;;;(prioritize sequence index advance)
;;;
;;;sequence : sequence
;;;
;;;index advance : integer
;;;
;;;return : sequence

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (prioritize '(0 1 2) 1 1)
;;;(0 2 1)
;;;_$ (prioritize '(0 1 2) 1 -1)
;;;(1 0 2)
;;;_$ (prioritize '(0 1 2) 1 0)
;;;(0 1 2)
;;;_$ (prioritize "ABC" 1 1)
;;;"ACB"
;;;_$ (prioritize "ABC" 1 -1)
;;;"BAC"
;;;_$ (prioritize "ABC" 1 0)
;;;"ABC"

(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'prioritize-list "./sequences/prioritize-list")

(defun prioritize (sequence index advance)
  (coerce (prioritize-list
            (sequencep-list sequence)
            index advance
          )
          (sequence-type-of sequence)
  )
)
