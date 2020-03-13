;;;(include '*multi-byte-char:types* "./types/multibyte/multi-byte-char-types")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include '*ISO-639-1* "./common/ISO-639-1")
(include 'default "./common/default")

(setq *multi-byte-char:locale* '((JA Shift_JIS UNICODE) (EN UNICODE)))

;;

(setq *multi-byte-char:types*
       (default
         (cdr
           (assoc *ISO-639-1* *multi-byte-char:locale*)
         )
         '(quote (UNICODE))
       )
)
