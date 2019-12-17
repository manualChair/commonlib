;;;(include '*multi-byte-char:function* "./types/multibyte/multi-byte-char-func")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'defstruct "./structures/defstruct")
(include 'unicode "./types/multibyte/_unicode")
(include 'Shift_JIS "./types/multibyte/_Shift_JIS")

(defstruct 'multi-byte-function
           '((predicate) (encode) (decode))
)

(setq *multi-byte-char:function*
       (list (cons 'Shift_JIS
                   (make-multi-byte-function
                     'encode:Shift_JIS-p
                     'encode:Shift_JIS
                     'decode:Shift_JIS
                   )
             )
             (cons 'UNICODE
                   (make-multi-byte-function
                     'encode:unicode-p
                     'encode:unicode
                     'decode:unicode
                   )
             )
       )
)

