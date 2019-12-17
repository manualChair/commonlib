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
;;;retrun  : string or list etc.

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (padding-list '(A A A) 'LEFT 7 nil '+)
;;;(+ + + + A A A)
;;;_$ (padding-list '(A A A) 'RIGHT 7 nil '+)
;;;(A A A + + + +)
;;;_$ (padding-list '(A A A) 'BOTH 7 nil '+)
;;;(+ + A A A + +)
;;;_$ (padding-list '(A A A A A) 'BOTH 3 nil '+)
;;;(A A A)
;;;_$ (padding-list '(A A A A A) 'BOTH 3 '# '+)
;;;(# # #)

(include 'member-of-option-p "./common/member-of-option-p")
(include 'make-list "./conses/make-list")
(include 'affix-list "./sequences/affix-list")
(include 'subseq-list "./sequences/subseq-list")

(defun padding-list:quote (alist / n)
  (setq n (fix (/ (- len width) 2)))
  (subseq-list alist n (- len n))
)

(defun padding-list (alist mode width overflow pad / len)
  (if (member-of-option-p 'padding-list 'mode '(LEFT RIGHT BOTH))
    (progn (setq len (length alist))
           (if (<= len width)
             (affix-list
               alist
               (make-list (if (= mode 'BOTH)
                            (fix (/ (- width len) 2))
                            (- width len)
                          )
                          pad
               )
               mode
             )
             (if overflow
               (make-list width overflow)
               (cond ((= mode 'LEFT) (subseq-list alist (- len width) nil))
                     ((= mode 'RIGHT) (subseq-list alist 0 width))
                     ((= mode 'BOTH) (padding-list:quote alist))
               )
             )
           )
    )
  )
)

