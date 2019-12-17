;;;(include 'remove-duplicates "./sequences/remove-duplicates")

;;;(remove-duplicates sequence test-func start end from-end)
;;;
;;;sequence : sequence
;;;
;;;test-func : function
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;from-end : atom (T or nil)
;;;
;;;return : sequence
;;;
;;; sequence is STR SYM LIST VARIANT(STR SAFEARRAY) SAFEARRAY

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (remove-duplicates '(0 1 2 3 4 3 4 2 4 1 4 0) nil nil nil nil)
;;;(3 2 1 4 0)
;;;_$ (remove-duplicates '(0 1 2 3 4 3 4 2 4 1 4 0) nil nil nil T)
;;;(0 1 2 3 4)
;;;_$ (remove-duplicates "����݂���̂����ɂ���݂���" nil nil nil nil)
;;;"�̂����ɂ���݂���"
;;;_$ (remove-duplicates "����݂���̂����ɂ���݂���" nil nil nil T)
;;;"����݂���̂�����"

(include 'sequencep-list "./sequences/_sequencep-list")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'remove-duplicates-list "./sequences/remove-duplicates-list")

(defun remove-duplicates (sequence test-func start end from-end)
  (coerce (remove-duplicates-list
            (sequencep-list sequence)
            test-func
            start
            end
            from-end
          )
          (sequence-type-of sequence)
  )
)
