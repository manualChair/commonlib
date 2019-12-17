;;;(include 'array-dimensions "./arrays/array-dimensions")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'range "./conses/range")

(defun array-dimensions (array)
  (mapcar (function (lambda (dimension)
                      (1+ (- (vlax-safearray-get-u-bound array dimension)
                             (vlax-safearray-get-l-bound array dimension)
                          )
                      )
                    )
          )
          (range 1 (1+ (vlax-safearray-get-dim array)) 1)
  )
)