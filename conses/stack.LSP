;;;(include 'create-stack "./conses/stack")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (setq s (create-stack '(A B)))
;;;*ST:HND-6*
;;;_$ (push 'C s)
;;;*ST:HND-6*
;;;_$ (push 'D s)
;;;*ST:HND-6*
;;;_$ (pop s)
;;;D
;;;_$ (pop s)
;;;C
;;;_$ (pop s)
;;;A
;;;_$ (pop s)
;;;B
;;;_$ (pop s)
;;;nil
;;;_$ (pop s)
;;;nil
;;;_$ (release-handle s)
;;;nil

(include 'defstruct "./structures/defstruct")
(include 'make-handle "./symbols/make-handle")

(defstruct 'stack '((data)))

(setq create-stack
       (eval
         (list
           'lambda
           '(data)
           (list 'make-handle ''ST (list (eval make-stack) 'data))
         )
       )
)

(defun pop (handle / result)
  (setq result (car (stack-data (vl-symbol-value handle))))
  (set handle (make-stack (cdr (stack-data (vl-symbol-value handle)))))
  result
)

(defun push (item handle)
  (set handle
       (make-stack (cons item (stack-data (vl-symbol-value handle))))
  )
  handle
)