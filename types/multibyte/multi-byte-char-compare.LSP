;;;(include 'multi-byte-char:compare "./types/multibyte/multi-byte-char-compare")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'defstruct "./structures/defstruct")
(include 'concatenate "./sequences/concatenate")
(include '*multi-byte-char:types*
         "./types/multibyte/multi-byte-char-types"
)

(defun multi-byte-char:compare:same-type (/ func-code)
  (setq func-code (concatenate
                    'SYM
                    (list mtype1 '(45 99 111 100 101) ;|"-code"|;)
                  )
  )
  (- (apply func-code mchar1) (apply func-code mchar2))
)

(defun multi-byte-char:compare (mchar1 mchar2 / mtype1 mtype2)
  (if (= (setq mtype1 (structure-type-of mchar1))
         (setq mtype2 (structure-type-of mchar2))
      )
    (multi-byte-char:compare:same-type)
    (if (member (structure-type-of char1)
                (member (structure-type-of char2) *multi-byte-char:types*)
        )
      1
      -1
    )
  )
)