;;;(include 'endp "./conses/endp")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun endp (alist)
  (if (listp alist)
    (null alist)
    (exit)
  )
)