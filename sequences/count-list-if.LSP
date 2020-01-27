;;;(include 'count-list-if "./sequences/count-list-if")

;;;(count-list-if predicate alist start end)
;;;  count-list-if of only list version
;;;
;;;predicate : predicate function
;;;            function apply single argment.
;;;
;;;alist : list
;;;
;;;start : integer or nil
;;;
;;;end : integer or nil
;;;
;;;return : integer

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (count-list-if 'oddp '(0 1 2 3 4 5 6 7 8 9) nil nil)
;;;5
;;;_$ (count-list-if 'oddp '(0 1 2 3 4 5 6 7 8 9) 3 6)
;;;2

(include 'default "./common/default")
(include 'subseq-list "./sequences/subseq-list")

(defun count-list-if ($_predicate $_list $_start $_end)
  (setq $_start (max 0 (default $_start 0))
        $_end   (min (default $_end '(length $_list)) (length $_list))
  )
  (length (vl-remove-if-not $_predicate (subseq-list $_list $_start $_end))
  )
)