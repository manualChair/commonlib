;;;(include 'bitlist "./numbers/bitlist")

;;;(bitlist integer)
;;;
;;;integer : integer
;;;
;;;return : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (bitlist 134565)
;;;(1 4 32 128 256 1024 2048 131072)

(include 'integerp "./numbers/integerp")

(defun bitlist (integer)
  (if (and (integerp integer) (not (minusp integer)))
    (vl-remove 0
               (mapcar (function (lambda (i) (logand i integer)))
                       ;; (mapcar (function (lambda (shift) (lsh 1 shift))) (range 0 31 1))
                       '
                        (1        2        4        8        16
                         32       64       128      256      512
                         1024     2048     4096     8192     16384
                         32768    65536    131072   262144   524288
                         1048576  2097152  4194304  8388608  16777216
                         33554432 67108864 134217728         268435456
                         536870912         1073741824
                        )
               )
    )
    (exit)
  )
)

;;;(setq bitlist acet-calc-bitlist)
