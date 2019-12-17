;;;(include 'sequence-length "./sequences/sequence-length")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'sequence-list "./sequences/_sequence-list")

(defun sequence-length (sequence)
  (length (sequence-list sequence))
)