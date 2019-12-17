;;;(include 'substitute "./sequences/substitute")

;;;(substitute newitem olditem sequence test-func start end count from-end)
;;;
;;;newitem : atom or list
;;;
;;;olditem : atom or list
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

;;;_$ (substitute 1 'A '(a b c A B C a b) nil nil nil nil nil)
;;;(1 B C 1 B C 1 B)
;;;_$ (substitute 1 'A '(a b c A B C a b) nil nil nil 2 nil)
;;;(1 B C 1 B C A B)
;;;_$ (substitute 1 'A '(a b c A B C a b) nil nil nil 2 T)
;;;(A B C 1 B C 1 B)
;;;_$ (substitute 1 'A '(a b c A B C a b) nil nil 6 2 T)
;;;(1 B C 1 B C A B)
;;;_$ (substitute (ascii "H") (ascii "h") "hello, hey, hi!" nil nil nil nil nil)
;;;"Hello, Hey, Hi!"
;;;_$ (substitute (ascii "H") (ascii "h") "hello, hey, hi!" nil nil nil 2 T)
;;;"hello, Hey, Hi!"

(include 'functionp "./flow/functionp")
(include 'substitute-if "./sequences/substitute--if")

(defun substitute
       (newitem olditem sequence test-func start end count from-end)
  (if (functionp (eval (setq test-func (default test-func ''equal))))
    (substitute-if
      newitem
      (function
        (lambda (test-item) (apply test-func (list olditem test-item)))
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