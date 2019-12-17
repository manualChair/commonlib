;;;(include 'listToSS "./types/AutoCAD/listToSS")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun listToSS (alist / ename ss)
  (setq ss (ssadd))
  (foreach ename alist (if ename (ssadd ename ss)))
  ss
)
