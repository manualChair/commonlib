;;;(include 'position "./sequences/position")

;;;(position item sequence test-func start end from-end)
;;;
;;;item : atom or list
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
;;;return : integer of index(zero-indexed) or nil
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (position 4 '(0 1 2 3 4 5 0 1 2 3 4 5) nil nil nil nil)
;;;4
;;;_$ (position 4 '(0 1 2 3 4 5 0 1 2 3 4 5) nil 5 nil nil)
;;;10
;;;_$ (position 4 '(0 1 2 3 4 5 0 1 2 3 4 5) nil nil nil T)
;;;10
;;;_$ (position 4 '(0 1 2 3 4 5 0 1 2 3 4 5) nil nil 5 T)
;;;4
;;;_$ (position (ascii "C") "ABCDEF" nil nil nil nil)
;;;2

(include 'functionp "./flow/functionp")
(include 'position-if "./sequences/position-if")

(defun position (item sequence test-func start end from-end)
  (if (functionp (eval (setq test-func (default test-func ''equal))))
    (position-if
      (function (lambda (test-item) (apply test-func (list item test-item)))
      )
      sequence
      start
      end
      from-end
    )
    (exit)
  )
)