;;;(include 'string-equal "./strings/string-equal")

;;;(string-equal string1 string2 start1 end1 start2 end2)
;;;
;;;string1 : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;string2 : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;start1 end1 start2 end2 : integer
;;;
;;;return : T or nil (ignore case)

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (string-equal "abc" "ABC" nil nil nil nil)
;;;T
;;;_$ (string-equal "������" "������" nil nil nil nil) ;_multi-byte-charactor	
;;;T

(include 'char-equal "./characters/char-equal")
(include 'stringp-list "./strings/_stringp-list")
(include 'subseq-list "./sequences/subseq-list")

(defun string-equal:sub (clist1 clist2)
  (cond ((and clist1 clist2)
         (if (char-equal (car clist1) (car clist2))
           (string-equal:sub (cdr clist1) (cdr clist2))
         )
        )
        ((and clist1 (null clist2)) nil)
        ((and (null clist1) clist2) nil)
        ((and (null clist1) (null clist2)) T)
  )
)

(defun string-equal (string1 string2 start1 end1 start2 end2)
  (string-equal:sub
    (subseq-list (stringp-list string1) start1 end1)
    (subseq-list (stringp-list string2) start2 end2)
  )
)