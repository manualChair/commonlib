;;;(include 'arrayp "./arrays/arrayp")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'typep "./types/typep")

(defun arrayp (item) (typep item 'SAFEARRAY))
