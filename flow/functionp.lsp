;;;(include 'functionp "./flow/functionp")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'type-of "./types/type-of")

(defun functionp (item / itype)
  (setq itype (type-of item))
  (or (= itype 'SUBR) (= itype 'USUBR) (= itype 'EXRXSUBR))
)