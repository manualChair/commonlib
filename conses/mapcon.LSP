;;;(include 'mapcon "./conses/mapcon")

;;;(mapcon $_func $_list-alist)
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

;;;_$ (mapcon 'identity '((0 1 2 3 4 5 6)))
;;;(0 1 2 3 4 5 6 1 2 3 4 5 6 2 3 4 5 6 3 4 5 6 4 5 6 5 6 6)
;;;_$ (mapcon '(lambda (item1 item2) (append item1 item2)) '((0 1 2) (A B C)))
;;;(0 1 2 A B C 1 2 B C 2 C)

(include 'maplist "./conses/maplist")

(defun mapcon ($_func $_list-alist)
  (apply 'append (maplist $_func $_list-alist))
)