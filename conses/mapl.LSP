;;;(include 'mapl "./conses/mapl")

;;;(mapl $_func $_list-alist)
;;;
;;;$_func : list of function symbol or list
;;;
;;;$_list-alist : list of list. ex. '((A B C) (1 2 3))
;;;
;;;retrun : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (mapl 'identity '((0 1 2 3 4 5 6)))
;;;((0 1 2 3 4 5 6) (1 2 3 4 5 6) (2 3 4 5 6) (3 4 5 6) (4 5 6) (5 6) (6))
;;;_$ (mapl '(lambda (item1 item2) (append item1 item2)) '((0 1 2) (A B C)))
;;;((0 1 2) (1 2) (2))

(include 'endp "./conses/endp")
(include 'cdrs "./conses/cdrs")

(defun mapl:sub ($_list-alist)
  (if
    (vl-every (function (lambda (alist) (not (endp alist)))) $_list-alist)
     (progn (apply $_func $_list-alist)
            (cons (caar $_list-alist) (mapl:sub (cdrs $_list-alist)))
     )
  )
)

(defun mapl ($_func $_list-alist) (mapl:sub $_list-alist))
