;;;(include '*LISPSYS* "./common/LISPSYS")

;;; *LISPSYS* : integer (The value of (getvar "LISPSYS")) or -1

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'default "./common/default")

(setq *LISPSYS* (default (getvar "LISPSYS") '-1))