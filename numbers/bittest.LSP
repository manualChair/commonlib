;;;(include 'bittest "./numbers/bittest")

;;;(bittest integer bit)
;;;
;;;integer : integer
;;;
;;;bit : integer
;;;
;;;return : T or nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (bitlist 134565)
;;;(1 4 32 128 256 1024 2048 131072)
;;;_$ (bittest 134565 1024)
;;;T
;;;_$ (bittest 134565 65536)
;;;nil

(include 'integerp "./numbers/integerp")

(defun bittest (integer bit)
  (if (and (integerp integer) (integerp bit) (not (minusp bit)))
    (= (logand integer bit) bit)
    (exit)
  )
)