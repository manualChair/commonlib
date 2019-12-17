;;;(include 'ALValue "./conses/ALValue")

;;;(ALValue assoc-list key)
;;;
;;;assoc-list : list
;;;
;;;key : atom or list
;;;
;;;return : atom or list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (ALValue '((PRICE . 100) (TYPE . APPLE)) 'PRICE)
;;;100

(defun ALValue (assoc-list key) (cdr (assoc key assoc-list)))
