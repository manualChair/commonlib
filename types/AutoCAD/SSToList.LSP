;;;(include 'SSToList "./types/AutoCAD/SSToList")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun SSToList:sub (ss index numOfEntity /)
  (if (< index numOfEntity)
    (cons (ssname ss index) (SSToList:sub ss (1+ index) numOfEntity))
  )
)

(defun SSToList (ss /)
  (if ss
    (SSToList:sub ss 0 (sslength ss))
  )
)
