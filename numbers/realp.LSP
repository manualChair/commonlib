;;;(include 'realp "./numbers/realp")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'typep "./types/typep")

(defun realp (x) (typep x 'REAL))