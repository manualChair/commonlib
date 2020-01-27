;;;(include 'substitute-if "./sequences/substitute-if")

;;;(substitute-if new-item predicate sequence start end count from-end)
;;;
;;;new-item : atom or list
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

;;;_$ (substitute-if 1 (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil nil nil)
;;;(1 B C 1 B C 1 B)
;;;_$ (substitute-if 1 (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil 2 nil)
;;;(1 B C 1 B C A B)
;;;_$ (substitute-if 1 (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil nil 2 T)
;;;(A B C 1 B C 1 B)
;;;_$ (substitute-if 1 (function (lambda (item) (equal item 'A))) '(a b c A B C a b) nil 6 2 T)
;;;(1 B C 1 B C A B)
;;;_$ (substitute-if (ascii "1") (function (lambda (item) (equal item (ascii "a")))) "abcABCabc" nil nil nil nil)
;;;"1bcABC1bc"

(include 'coerce "./types/coerce")
(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'substitute-list-if
         "./sequences/substitute-list-if"
)

(defun substitute-if ($_new-item    $_predicate   $_sequence
                      $_start       $_end         $_count
                      $_from-end
                     )
  (coerce (substitute-list-if
            $_new-item
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
