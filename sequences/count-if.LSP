;;;(include 'count-if "./sequences/count-if")

;;;(count-if predicate sequence start end)
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
;;;return : integer
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (count-if 'upper-case-p "ABCDabcd" nil nil)
;;;4
;;;_$ (count-if 'upper-case-p "ABCDabcd" 2 4)
;;;2

(include 'sequencep-list "./sequences/_sequencep-list")
(include 'count-list-if "./sequences/count-list-if")

(defun count-if ($_predicate $_sequence $_start $_end)
  (count-list-if
    $_predicate
    (sequencep-list $_sequence)
    $_start
    $_end
  )
)