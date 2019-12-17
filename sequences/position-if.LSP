;;;(include 'position-if "./sequences/position-if")

;;;(position-if $_predicate $_sequence $_start $_end $_from-end)
;;;
;;;$_predicate : predicate function
;;;            function apply single argment.
;;;
;;;$_sequence : sequence
;;;
;;;$_start : integer or nil
;;;
;;;$_end : integer or nil
;;;
;;;$_from-end : atom (T or nil)
;;;
;;;return : integer of index. zero-indexed.
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (position-if 'oddp '(0 1 2 3 4 5 0 1 2 3 4 5) nil nil nil)
;;;1
;;;_$ (position-if 'zerop '(0 1 2 3 4 5 0 1 2 3 4 5) 3 nil nil)
;;;6
;;;_$ (position-if 'zerop '(0 1 2 3 4 5 0 1 2 3 4 5) nil nil T)
;;;6
;;;_$ (position-if (function (lambda (item) (= item (ascii "a")))) "This is a pen" nil nil nil)
;;;8

(include 'sequencep-list "./sequences/_sequencep-list")
(include 'position-list-if "./sequences/position-list-if")

(defun position-if ($_predicate $_sequence $_start $_end $_from-end)
  (position-list-if
    $_predicate
    (sequencep-list $_sequence)
    $_start
    $_end
    $_from-end
  )
)
