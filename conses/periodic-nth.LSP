;;;(include 'periodic-nth "./conses/periodic-nth")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (periodic-nth 5 '(0 1 2 3 4 5))
;;;5
;;;_$ (periodic-nth 6 '(0 1 2 3 4 5))
;;;0
;;;_$ (periodic-nth -1 '(0 1 2 3 4 5))
;;;5

(include 'mod "./numbers/mod")

(defun periodic-nth (index alist) (nth (mod index (length alist)) alist))