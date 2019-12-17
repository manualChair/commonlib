;;;(include 'cars "./conses/cars")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'endp "./conses/endp")

(defun cars (list-alist)
  (if (not (endp list-alist))
    (cons (car (car list-alist)) (cars (cdr list-alist)))
  )
)

