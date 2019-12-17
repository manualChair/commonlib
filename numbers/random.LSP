;;;(include 'random "./numbers/random")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'default "./common/default")
(include 'type-of "./types/type-of")
(include 'coerce "./types/coerce")
(include 'plusp "./numbers/plusp")
(include 'integerp "./numbers/integerp")

;;;Integer Max Value = 2147483647
;;;Integer Min Value = -2147483648

(setq *random:integer-range*
       (- (float 2147483647) (float -2147483648))
      *random-state*
       (fix (rem (* 86400 (getvar "DATE")) *random:integer-range*)
       )
)

(defun random (limit state)
  (if
    (and (numberp limit) (plusp limit) (or (null state) (integerp state)))
     (coerce (* (/ limit *random:integer-range*)
                (+ (float (setq *random-state*
                                 (1+ (* (default state *random-state*) 69069))
                          )
                   )
                   2147483648.0
                )
             )
             (type-of limit)
     )
     (exit)
  )
)

