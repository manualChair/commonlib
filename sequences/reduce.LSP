;;;(include 'reduce "./sequences/reduce")

;;;(reduce func sequence)
;;;
;;;func     : function symbol or list
;;;           function apply binary argments.
;;;
;;;sequence : sequence
;;;
;;;return : (func (func A B) C)
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'recurse-binaryOperator "./evaluation/recurse-binOperator")
(include 'sequencep-list "./sequences/_sequencep-list")

(defun reduce (func sequence)
  ((recurse-binaryOperator func) (sequencep-list sequence))
)