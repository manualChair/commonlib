;;;(include 'mapc "./conses/mapc")

;;;(mapc $_func $_list-alist)
;;;
;;;$_func : function symbol or list
;;;
;;;$_list-alist : list ex. '((A B C) (1 2 3))
;;;
;;;return : list ex. '(A B C)
;;;         this call ($_func A 1) ($_func B 2) ($_func C 3)

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (mapc 'print '((1 2 3)))
;;;
;;;1 
;;;2 
;;;3 (1 2 3)

(include 'endp "./conses/endp")
(include 'cars "./conses/cars")
(include 'cdrs "./conses/cdrs")

(defun mapc:sub ($_list-alist / $_args)
  (if (vl-every (function (lambda (alist) (not (endp alist)))) $_list-alist)
    (progn (apply $_func (setq $_args (cars $_list-alist)))
           (cons (car $_args) (mapc:sub (cdrs $_list-alist)))
    )
  )
)

(defun mapc ($_func $_list-alist) (mapc:sub $_list-alist))