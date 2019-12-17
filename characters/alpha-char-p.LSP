;;;(include 'alpha-char-p "./characters/alpha-char-p")

;;;(aplha-char-p ascii-code)
;;;
;;;ascii-code : integer
;;;
;;;retrun : T or nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'lower-case-p "./characters/lower-case-p")
(include 'upper-case-p "./characters/upper-case-p")

(defun alpha-char-p (ascii-code)
  (or (lower-case-p ascii-code) (upper-case-p ascii-code))
)