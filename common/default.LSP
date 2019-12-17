;;;(include 'default "./common/default")

;;;(default value onNull)
;;;
;;;value : atom or list
;;;
;;;onNull : expression
;;;
;;;return : If value is not nil, this return value.
;;;         If value is nil, this return (eval onNull).
;;;         empty string is include nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'typep "./types/typep")

(defun default (value onNull)
  (if (or (and (not (typep value 'STR)) (null value))
          (and (typep value 'STR) (= value ""))
      )
    (eval onNull)
    value
  )
)