;;;(include 'search "./sequences/search")

;;;(search sub-sequence sequencestart start end from-end)
;;;
;;;sub-sequence : sequence
;;;
;;;sequence : sequence
;;;
;;;test-func : test function symbol (default equal)
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;from-end : atom (T or nil)
;;;
;;;return : integer of index. zero-indexed.
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (search "well" "All is well that ends well" nil nil nil nil)
;;;7
;;;_$ (search "�݂���" "����݂���̂����ɂ���݂���" nil nil nil nil)
;;;2
;;;_$ (search '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil nil nil nil)
;;;3
;;;_$ (search '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil nil nil T)
;;;8
;;;_$ (search '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil 5 nil nil)
;;;8
;;;_$ (search '(3 4) '(0 1 2 3 4 0 1 2 3 4) nil nil 5 T)
;;;3
;;;_$ (search "APPLE" "Pen apple Apple APPLE" nil nil nil nil)
;;;16
;;;_$ (search "APPLE" "Pen apple Apple APPLE" 'char-equal nil nil nil)
;;;4

(include 'sequencep-list "./sequences/_sequencep-list")
(include 'search-list "./sequences/search-list")

(defun search (sub-sequence sequence test-func start end from-end)
  (search-list
    (sequencep-list sub-sequence)
    (sequencep-list sequence)
    test-func
    start
    end
    from-end
  )
)
