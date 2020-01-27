;;;(include 'thin-out "./sequences/thin-out")

;;;(thin-out sequence start end)
;;;
;;;sequence : sequence
;;;
;;;start end : integer or nil
;;;
;;;return : sequence

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (thin-out "0123456789" 5 6)
;;;"012346789"
;;;_$ (thin-out "0123456789" nil nil)
;;;""
;;;_$ (thin-out "0123456789" 3 nil)
;;;"012"
;;;_$ (thin-out "0123456789" nil 6)
;;;"6789"
;;;_$ (thin-out '(0 1 2 3 4 5 6 7 8 9) 5 6)
;;;(0 1 2 3 4 6 7 8 9)

(include 'remove-if "./sequences/remove-if")

(defun thin-out (sequence start end)
  (remove-if (function (lambda (item) T)) sequence start end nil nil)
)
