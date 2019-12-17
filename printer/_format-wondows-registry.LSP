;;;(include 'registry:getGrouping "./printer/_format-wondows-registry")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'word "./strings/word")

(setq *registry:internationalKey*
       "HKEY_CURRENT_USER\\Control Panel\\International"
)

(defun registry:getDecimal ()
  (ascii (vl-registry-read *registry:internationalKey* "sDecimal"))
)

(defun registry:getThousand ()
  (ascii (vl-registry-read *registry:internationalKey* "sThousand"))
)

(defun registry:getGrouping (/ group)
  (setq group
         (word 'STR
               (vl-registry-read *registry:internationalKey* "sGrouping")
               ";"
               nil
               nil
               nil
               nil
         )
  )
  (atoi (cond ((= (length group) 2) (car group))
              ((= (length group) 3) (cadr group))
              (T "0")
        )
  )
)
