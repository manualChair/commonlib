;;;(include 'multi-byte-char-p "./types/multibyte/multi-byte-char-p")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'defstruct "./structures/defstruct")
(include 'structure-p "./structures/structure-p")
(include '*multi-byte-char:types* "./types/multibyte/multi-byte-char-types")

(defun multi-byte-char-p (item)
  (and (structure-p item)
       (member (car item) *multi-byte-char:types*)
  )
)
