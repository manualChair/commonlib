;;;(include 'sequence-type-of "./sequences/_sequence-type-of")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'type-of "./types/type-of")
(include 'multi-byte-char-p "./types/multibyte/multi-byte-char-p")

(defun sequence-type-of (sequence / stype)
  (setq stype (type-of sequence))
  (cond ((= stype 'LIST)
         (if (vl-some 'multi-byte-char-p sequence)
           'SLIST
           'LIST
         )
        )
        (T stype)
  )
)