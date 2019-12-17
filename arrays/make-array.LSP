;;;(include 'make-array "./arrays/make-array")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'member-of-option-p "./common/member-of-option-p")
(include 'make-list "./conses/make-list")
(include 'ALValue "./conses/ALValue")

(setq *array:sym->array-type*
       (list (cons 'INT16 vlax-vbInteger)
             (cons 'INT vlax-vbLong)
             (cons 'SINGLE vlax-vbSingle)
             (cons 'REAL vlax-vbDouble)
             (cons 'STR vlax-vbString)
             (cons 'VLA-object vlax-vbObject)
             (cons 'BOOL vlax-vbBoolean)
             (cons 'VARIANT vlax-vbVariant)
       )
)

(defun make-array:initial-element (dimensions)
  (if (and dimensions (cdr dimensions))
    (make-list (car dimensions)
               (make-array:initial-element (cdr dimensions))
    )
    (make-list (car dimensions) initial-element)
  )
)

(defun make-array (element-type dimensions initial-element / result)
  (if (member-of-option-p
        'make-array
        'element-type
        '(INT16 INT SINGLE REAL STR VLA-OBJECT BOOL VARIANT)
      )
    (progn (setq result
                  (apply
                    'vlax-make-safearray
                    (cons (ALValue *array:sym->array-type* element-type)
                          (mapcar (function (lambda (size) (cons 0 (1- size))))
                                  dimensions
                          )
                    )
                  )
           )
           (vlax-safearray-fill
             result
             (if (vl-consp initial-element)
               initial-element
               (make-array:initial-element dimensions)
             )
           )
    )
    (exit)
  )
)