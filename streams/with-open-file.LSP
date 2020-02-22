;;;(include 'with-open-file "./streams/with-open-file")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'typep "./types/typep")
(include 'compose "./evaluation/compose")

(defun with-open-file ($_filename $_mode $_func $_args)
  (if (and $_filename (typep $_filename 'STR) $_mode (typep $_mode 'STR))
    ((lambda (*error* / $stream $_result)
       (setq $stream  (open $_filename $_mode)
             $_result (apply $_func $_args)
       )
       (close $stream)
       $_result
     )
      (compose (function (lambda ($_msg) (close $stream) $_msg)) '*error*)
    )
    (exit)
  )
)