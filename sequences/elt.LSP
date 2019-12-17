;;;(include 'elt "./sequences/elt")

;;;(elt sequence n)
;;;
;;;sequence : sequence
;;;
;;;n        : integer
;;;
;;;retrun  : atom, or list
;;;
;;; Similar to nth function with n range checks
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (elt '(0 1 2 3 4) 3) 
;;;3
;;;_$ (elt '(0 1 2 3 4) 6) 
;;;; �G���[: quit / exit �ɂ�钆�~
;;;_$ (elt "01234" 3) 
;;;51

(include 'sequencep-list "./sequences/_sequencep-list")

(defun elt:sub (alist)
  (if (and (not (minusp n)) (< n (length alist)))
    (nth n alist)
    (exit)
  )
)

(defun elt (sequence n) (elt:sub (sequencep-list sequence)))