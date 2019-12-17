;;;(include 'lcm "./numbers/lcm")

;;;Returns the least common multiple of two integers

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (lcm 12 18)
;;;36
;;;_$ (lcm 18 24)
;;;72
;;;_$ (lcm 60 48)
;;;240
;;;_$ (lcm 84 70)
;;;420
;;;_$ (lcm 36 72)
;;;72

(defun lcm (integer1 integer2)
  (/ (* integer1 integer2) (gcd integer1 integer2))
)