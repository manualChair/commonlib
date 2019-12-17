;;;(include 'union "./conses/union")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (union '(a b c) '(c b s) nil)
;;;(A C B S)

(include 'set-difference "./conses/set-difference")

(defun union (alist1 alist2 test-func)
  (append (set-difference alist1 alist2 test-func) alist2)
)