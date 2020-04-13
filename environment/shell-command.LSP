;;;(include 'shell-command "./environment/shell-command")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'member-of-option-p "./common/member-of-option-p")
(vl-arx-import 'startapp)

(defun shell-command (command-line mode)
  (if (member-of-option-p 'shell-command 'mode '(KEEP CLOSE))
    (startapp "cmd"
              (strcat (cond ((= mode 'KEEP) "/K")
                            (T "/C")
                      )
                      " "
                      command-line
              )
    )
    (exit)
  )
)
