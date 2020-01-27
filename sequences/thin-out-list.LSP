;;;(include 'thin-out-list "./sequences/thin-out-list")

;;;(thin-out-list alist start end)
;;;
;;;alist : list
;;;
;;;start end : integer or nil
;;;
;;;return : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (thin-out-list '(0 1 2 3 4 5 6 7 8 9) 5 6)
;;;(0 1 2 3 4 6 7 8 9)
;;;_$ (thin-out-list '(0 1 2 3 4 5 6 7 8 9) nil nil)
;;;nil
;;;_$ (thin-out-list '(0 1 2 3 4 5 6 7 8 9) 3 nil)
;;;(0 1 2)
;;;_$ (thin-out-list '(0 1 2 3 4 5 6 7 8 9) nil 6)
;;;(6 7 8 9)

(include 'remove-list-if "./sequences/remove-list-if")

(defun thin-out-list (alist start end)
  (remove-list-if (function (lambda (item) T)) alist start end nil nil)
)
