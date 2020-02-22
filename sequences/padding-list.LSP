;;;(include 'padding-list "./sequences/padding-list")

;;;(padding-list alist mode width overflow pad)
;;;
;;;alist : list
;;;
;;;mode : symbol ('LEFT 'RIGHT 'BOTH)
;;;
;;;width : integer
;;;
;;;overflow , pad : atom or list
;;;
;;;retrun  : list

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (padding-list '(1 2 3 4 5) 'LEFT 8 nil '+)
;;;(+ + + 1 2 3 4 5)
;;;_$ (padding-list '(1 2 3 4 5) 'RIGHT 8 nil '+)
;;;(1 2 3 4 5 + + +)
;;;_$ (padding-list '(1 2 3 4 5) 'BOTH 8 nil '+)
;;;(+ 1 2 3 4 5 + +)
;;;_$ (padding-list '(1 2 3 4 5) 'LEFT 3 nil '+)
;;;(3 4 5)
;;;_$ (padding-list '(1 2 3 4 5) 'RIGHT 3 nil '+)
;;;(1 2 3)
;;;_$ (padding-list '(1 2 3 4 5) 'BOTH 3 nil '+)
;;;(2 3 4)
;;;_$ (padding-list '(1 2 3 4 5) 'LEFT 3 '# '+)
;;;(# # #)

(include 'member-of-option-p "./common/member-of-option-p")
(include 'ceiling "./numbers/ceiling")
(include 'floor "./numbers/floor")
(include 'plusp "./numbers/plusp")
(include 'make-list "./conses/make-list")
(include 'affix-list "./sequences/affix-list")
(include 'subseq-list "./sequences/subseq-list")

(defun padding-list:quote (n) (subseq-list alist n (- len n)))

(defun padding-list:both ()
  (if (plusp pad-count)
    (append (make-list (floor pad-count 2.0) pad)
            alist
            (make-list (ceiling pad-count 2.0) pad)
    )
    (if overflow
      (make-list width overflow)
      (padding-list:quote (- (floor pad-count 2.0)))
    )
  )
)

(defun padding-list (alist mode width overflow pad / len pad-count)
  (if (member-of-option-p 'padding-list 'mode '(LEFT RIGHT BOTH))
    (progn
      (setq len       (length alist)
            pad-count (- width len)
      )
      (if (= mode 'BOTH)
        (padding-list:both)
        (if (<= 0 pad-count)
          (affix-list alist (make-list pad-count pad) mode)
          (if overflow
            (make-list width overflow)
            (cond ((= mode 'LEFT) (subseq-list alist (- pad-count) nil))
                  ((= mode 'RIGHT) (subseq-list alist 0 width))
            )
          )
        )
      )
    )
    (exit)
  )
)
