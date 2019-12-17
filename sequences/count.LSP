;;;(include 'count "./sequences/count")

;;;(count item sequence test-func start end)
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
;;;return : integer
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (count (ascii "s") "All is well that ends well" nil nil nil)
;;;2
;;;_$ (count (ascii "s") "All is well that ends well" nil 3 7)
;;;1
;;;_$ (count (ascii "S") "Speech is silver, silence is gold" 'char-equal nil nil)
;;;5

(include 'functionp "./flow/functionp")
(include 'count-if "./sequences/count-if")

(defun count (item sequence test-func start end)
  (if (functionp (eval (setq test-func (default test-func ''equal))))
    (count-if
      (function (lambda (test-item) (apply test-func (list item test-item)))
      )
      sequence
      start
      end
    )
    (exit)
  )
)