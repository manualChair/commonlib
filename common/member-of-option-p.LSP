;;;(include 'member-of-option-p "./common/member-of-option-p")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun member-of-option-p (func-symbol arg-symbol keywords)
  (if (member (eval arg-symbol) keywords)
    T
    (progn (princ (strcat "\n; CAUTION : "
                          (vl-symbol-name func-symbol)
                          "::"
                          (vl-symbol-name arg-symbol)
                          " - "
                          (vl-prin1-to-string keywords)
                  )
           )
           nil
    )
  )
)