;;;(include 'multi-byte-char:compare "./types/multibyte/multi-byte-char-compare")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'type-of "./types/type-of")
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
  (- (apply func-code (list mchar1)) (apply func-code (list mchar2)))
)

(defun multi-byte-char:compare (mchar1 mchar2 / mtype1 mtype2)
  (if (= (setq mtype1 (type-of mchar1))
         (setq mtype2 (type-of mchar2))
      )
    (multi-byte-char:compare:same-type)
    (if (member (type-of char1)
                (member (type-of char2) *multi-byte-char:types*)
        )
      1
      -1
    )
  )
)