;;;(include 'remove-if "./sequences/remove-if")

;;;(remove-if predicate sequence start end count from-end)
;;;
;;;predicate : predicate function
;;;            function apply single argment.
;;;
;;;sequence : sequence
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;count : integer or nil
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

;;;_$ (remove-if (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil nil nil)
;;;(B C B C B)
;;;_$ (remove-if (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil 2 nil)
;;;(B C B C A B)
;;;_$ (remove-if (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil 2 T)
;;;(A B C B C B)
;;;_$ (remove-if (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil 6 2 T)
;;;(B C B C A B)
;;;_$ (remove-if (function (lambda (item) (equal item (ascii "A")))) "abcABCab" nil nil nil nil)
;;;"abcBCab"

(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'remove-list-if "./sequences/remove-list-if")

(defun remove-if ($_predicate $_sequence $_start $_end $_count $_from-end)
  (coerce (remove-list-if
            $_predicate
            (sequencep-list $_sequence)
            $_start
            $_end
            $_count
            $_from-end
          )
          (sequence-type-of $_sequence)
  )
)