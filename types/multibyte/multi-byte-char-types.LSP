;;;(include '*multi-byte-char:types* "./types/multibyte/multi-byte-char-types")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'default "./common/default")
(include 'assoc-if "./conses/assoc-if")

(setq *multi-byte-char:locale* '(((JPN JA) Shift_JIS UNICODE)))

;;

(setq *multi-byte-char:types*
       (default
         (cdr (assoc-if
                (function
                  (lambda (key)
                    (member (read (getvar "LOCALE")) key)
                  )
                )
                *multi-byte-char:locale*
              )
         )
         '(quote (UNICODE))
       )
)
