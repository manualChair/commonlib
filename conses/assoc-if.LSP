;;;(include 'assoc-if "./conses/assoc-if")

;;;(assoc-if predicate assoc-list)
;;;
;;;predicate : function symbol or list
;;;
;;;assoc-list : association list
;;;
;;;retuen : cons or list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (assoc-if '(lambda (key) (< 2 key)) '((1 . A) (2 . B) (3 . C) (4 . D)))
;;;(3 . C)
;;;_$ (assoc-if '(lambda (key) (< 10 key)) '((1 . A) (2 . B) (3 . C) (4 . D)))
;;;nil

(include 'endp "./conses/endp")

(defun assoc-if:sub ($_assoc-list)
  (if (not (endp $_assoc-list))
    (if (apply $_predicate (list (caar $_assoc-list)))
      (car $_assoc-list)
      (assoc-if:sub (cdr $_assoc-list))
    )
  )
)

(defun assoc-if ($_predicate $_assoc-list) (assoc-if:sub $_assoc-list))