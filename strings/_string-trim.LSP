;;;(include 'string-trim:sub "./strings/_string-trim")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun string-trim:sub (clist)
  (if clist
    (if (member (car clist) trim-chars)
      (string-trim:sub (cdr clist))
      clist
    )
  )
)
