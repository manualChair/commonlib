;;;(include 'cdrs "./conses/cdrs")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'endp "./conses/endp")

(defun cdrs (list-alist)
  (if (not (endp list-alist))
    (cons (cdr (car list-alist)) (cdrs (cdr list-alist)))
  )
)

