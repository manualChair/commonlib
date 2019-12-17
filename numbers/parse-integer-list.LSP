;;;(include 'parse-integer-list "./numbers/parse-integer-list")

;;;(parse-integer-list alist start end radix junk-allowed)
;;;
;;;alist : list
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;radix : integer (2~36) or if nil 10
;;;
;;;junk-allowed : T or nil
;;;
;;;return : integer

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (parse-integer-list (vl-string->list "FFFF") nil nil 16 T)
;;;65535
;;;_$ (parse-integer-list (vl-string->list "FFFF") 2 nil 16 T)
;;;255
;;;_$ (parse-integer-list (vl-string->list "FFFF") 2 3 16 T)
;;;15
;;;_$ (parse-integer-list (vl-string->list "100yen") nil nil nil T)
;;;100
;;;_$ (parse-integer-list (vl-string->list "100yen") nil nil nil nil)
;;;; �G���[: quit / exit �ɂ�钆�~

(include 'default "./common/default")
(include 'scope-p "./common/scope-p")
(include 'digit-char-p "./characters/digit-char-p")
(include 'subseq-list "./sequences/subseq-list")

(defun parse-integer:sub (clist value / this next)
  (if (setq this (digit-char-p (car clist) radix))
    (if (and (setq value (+ (* value radix) this))
             (cdr clist)
             (setq next (parse-integer:sub (cdr clist) value))
        )
      next
      value
    )
    (if junk-allowed
      nil
      (exit)
    )
  )
)

(defun parse-integer-list
       (alist start end radix junk-allowed / sign value)
  (setq start (max 0 (default start 0))
        end   (min (default end '(length alist)) (length alist))
        radix (default radix 10)
        sign  (default
                (cond ((= (car alist) (ascii "-")) (setq alist (cdr alist)) -1)
                      ((= (car alist) (ascii "+")) (setq alist (cdr alist)) 1)
                )
                '1
              )
  )
  (if
    (and alist
         (and (integerp radix) (scope-p radix 2 36))
         (setq value (parse-integer:sub (subseq-list alist start end) 0))
    )
     (* sign value)
     (exit)
  )
)