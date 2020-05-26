;;;(include 'characterp "./characters/characterp")

;;;(charactorp item)
;;;
;;;item   : integer or structure
;;;
;;;retrun : T or nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include '*LISPSYS* "./common/LISPSYS")
(include 'integerp "./numbers/integerp")
(include 'plusp "./numbers/plusp")
(include 'multi-byte-char-p "./types/multibyte/multi-byte-char-p")

(defun characterp (item) 
  (or (plusp *LISPSYS*)
      (and (integerp item) (<= 0 item) (<= item 255))
      (multi-byte-char-p item)
  )
)