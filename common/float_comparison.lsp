;;;(include '<:float "./common/float_comparison")
;;;(include '>:float "./common/float_comparison")
;;;(include '<=:float "./common/float_comparison")
;;;(include '>=:float "./common/float_comparison")
;;;(include 'minusp:float "./common/float_comparison")
;;;(include 'plusp:float "./common/float_comparison")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include '=:float "./common/float_equal")

(defun <:float (a b) (and (/=:float a b) (< a b)))

(defun >:float (a b) (and (/=:float a b) (> a b)))

(defun <=:float (a b) (or (=:float a b) (< a b)))

(defun >=:float (a b) (or (=:float a b) (> a b)))

(defun minusp:float (a) (<:float a 0.0))

(defun plusp:float (a) (<:float 0.0 a))
