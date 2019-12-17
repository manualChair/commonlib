;;;(include 'format:in-parentheses "./printer/_format-in-parentheses")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'typep "./types/typep")
(include 'coerce "./types/coerce")
(include 'string "./strings/string")
(include 'string-equal "./strings/string-equal")
(include 'word "./strings/word")

(setq *format-parentheses*
       '((justification . "~< ... ~>")
         (conditional . "~[ ... ~]")
         (iteration . "~{ ... ~}")
         (case-conversion . "~( ... ~)")
        )
)

(defun format:in-parentheses:period-p (token period / tokens)
  (setq tokens (word 'SLIST token ":" nil nil nil nil))
  (if (caddr tokens)
    (if (string-equal
          (caddr tokens)
          period
          nil
          (length period)
          nil
          (length period)
        )
      (cadr tokens)
    )
  )
)

(defun format:in-parentheses (in-phase / stack token phase buffer result)
  (setq stack (list (coerce in-phase 'SLIST)))
  (while (and (setq token (format:pop-token))
              (not (and (listp token)
                        (string-equal
                          in-phase
                          (format:in-parentheses:period-p
                            (car token)
                            '(69 88 73 84) ;|"EXIT"|;
                          )
                          nil
                          nil
                          nil
                          nil
                        )
                   )
              )
         )
    (cond ((typep token 'STR) (setq buffer (cons token buffer)))
          ((setq phase (format:in-parentheses:period-p
                         (car token)
                         '(69 78 84 69 82) ;|"ENTER"|;
                       )
           )
           (setq stack  (cons phase stack)
                 buffer (cons token buffer)
           )
          )
          ((setq phase (format:in-parentheses:period-p
                         (car token)
                         '(69 88 73 84) ;|"EXIT"|;
                       )
           )
           (setq buffer (cons token buffer)
                 stack  (if (string-equal phase (car stack) nil nil nil nil)
                          (cdr stack)
                          (progn (princ "\n; ERROR : in Pairing of ")
                                 (princ (string (car stack)))
                                 (princ " : ")
                                 (princ (cdr (assoc (read (string (car stack)))
                                                    *format-parentheses*
                                             )
                                        )
                                 )
                                 (exit)
                          )
                        )
           )
          )
          ((= (car token) 'format:separator)
           (if (null (cdr stack))
             (progn (setq result (cons (reverse buffer) result)
                          buffer nil
                    )
                    (eval token)
             )
             (setq buffer (cons token buffer))
           )
          )
          (T (setq buffer (cons token buffer)))
    )
  )
  ;; calling end-parenthese-function (set end-option)
  (eval token)
  (if buffer
    (setq result (cons (reverse buffer) result))
  )
  (reverse result)
)