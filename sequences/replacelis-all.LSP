;;;(include 'replacelis-all "./sequences/replacelis-all")

;;;(replacelis-all assoc-list sequence start end)
;;;
;;;assoc-list : association list
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

;;;_$ (replacelis-all '(((0 1) A) ((2 3 4) < >)) '(0 1 2 3 4 0 1 2 3 4) nil nil nil)
;;;(A < > A < >)
;;;_$ (replacelis-all '(("A" . "��") ("I" . "��") ("U" . "��")) "A I U E O" nil nil nil)
;;;"�� �� �� E O"

(include 'type-of "./types/type-of")
(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'replacelis-all-list "./sequences/replacelis-all-list")

(defun replacelis-all (assoc-list sequence test-func start end)
  (coerce
    (replacelis-all-list
      (mapcar
        (function
          (lambda (cell)
            (cons (sequencep-list (car cell)) (sequencep-list (cdr cell)))
          )
        )
        assoc-list
      )
      (sequencep-list sequence)
      test-func
      start
      end
    )
    (sequence-type-of sequence)
  )
)