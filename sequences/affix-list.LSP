;;;(include 'affix-list "./sequences/affix-list")

;;;(affix-list alist deco mode)
;;;
;;;alist : list
;;;
;;;deco : list
;;;
;;;mode : symbol ('LEFT 'RIGHT 'BOTH or nil)
;;;
;;;return : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (affix-list '(A A A A) '(* *) 'LEFT)
;;;(* * A A A A)
;;;_$ (affix-list '(A A A A) '(* *) 'RIGHT)
;;;(A A A A * *)
;;;_$ (affix-list '(A A A A) '(* *) 'BOTH)
;;;(* * A A A A * *)
;;;_$ (affix-list '(A A A A) '(* *) 'nil)
;;;(* *)

(include 'member-of-option-p "./common/member-of-option-p")

(defun affix-list (alist deco mode)
  (if (member-of-option-p 'addto 'mode '(nil LEFT RIGHT BOTH))
    (if mode
      (cond ((= mode 'LEFT) (append deco alist))
            ((= mode 'RIGHT) (append alist deco))
            ((= mode 'BOTH) (append deco alist deco))
      )
      deco
    )
    (exit)
  )
)