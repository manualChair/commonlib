;;;(include 'acons "./conses/acons")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (acons 'price 100 '((type . apple))) 
;;;((PRICE . 100) (TYPE . APPLE))

(defun acons (key value assoc-list) (cons (cons key value) assoc-list))