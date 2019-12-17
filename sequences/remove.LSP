;;;(include 'remove "./sequences/remove")

;;;(remove item sequence test-func start end count from-end)
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
;;;count : integer
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

;;;_$ (remove 'A '(a b c A B C a b) nil nil nil nil nil)
;;;(B C B C B)
;;;_$ (remove 'A '(a b c A B C a b) nil nil nil 2 nil)
;;;(B C B C A B)
;;;_$ (remove 'A '(a b c A B C a b) nil nil nil 2 T)
;;;(A B C B C B)
;;;_$ (remove 'A '(a b c A B C a b) nil nil 6 2 T)
;;;(B C B C A B)
;;;_$ (remove (ascii "A") "abcABCab" nil nil nil nil nil)
;;;"abcBCab"
;;;_$ (remove (ascii "A") "abcABCab" 'char-equal nil nil nil nil)
;;;"bcBCb"

(include 'functionp "./flow/functionp")
(include 'remove-if "./sequences/remove-if")

(defun remove (item sequence test-func start end count from-end)
  (if (functionp (eval (setq test-func (default test-func ''equal))))
    (remove-if
      (function (lambda (test-item) (apply test-func (list item test-item)))
      )
      sequence
      start
      end
      count
      from-end
    )
    (exit)
  )
)
