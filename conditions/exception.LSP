;;;(include 'exception "./conditions/exception")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun exception ($_func $_args $_onException / $_result)
  (if $_func
    (if (vl-catch-all-error-p
          (setq $_result (vl-catch-all-apply $_func $_args))
        )
      ((lambda ($error $error-message) (eval $_onException))
        $_result
        (vl-catch-all-error-message $_result)
      )
      $_result
    )
    (exit)
  )
)
