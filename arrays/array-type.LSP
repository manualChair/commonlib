;;;(include 'array-type "./arrays/array-type")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'ALValue "./conses/ALValue")

(setq *array:array-type->sym*
       (list (cons vlax-vbInteger 'INT16)
             (cons vlax-vbInteger 'INT)
             (cons vlax-vbLong 'INT)
             (cons vlax-vbSingle 'SINGLE)
             (cons vlax-vbDouble 'REAL)
             (cons vlax-vbString 'STR)
             (cons vlax-vbObject 'VLA-object)
             (cons vlax-vbBoolean 'BOOL)
             (cons vlax-vbVariant 'VARIANT)
       )
)

(defun array-type (array)
  (ALValue *array:array-type->sym* (vlax-safearray-type array))
)
