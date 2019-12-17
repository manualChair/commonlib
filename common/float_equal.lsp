;;;(include 'equal:float "./common/float_equal")
;;;(include '=:float "./common/float_equal")
;;;(include 'zerop:float "./common/float_equal")
;;;(include '/=:float "./common/float_equal")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include '*tolerance* "./common/tolerance")

(defun equal:float (a b) (equal a b *tolerance*))

(setq =:float equal:float)

(defun zerop:float (a)
  (equal:float a 0.0)
)

(defun /=:float (a b)
  (not (equal:float a b))
)

