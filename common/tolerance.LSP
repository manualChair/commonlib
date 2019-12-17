;;;(include '*tolerance* "./common/tolerance")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(setq *tolerance* (expt 10.0 (- (* (getvar "LUPREC") 2))))