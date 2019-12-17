;;;(include 'format:case-conversion "./printer/_format-case-conversion")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'format:in-parentheses "./printer/_format-in-parentheses")
;;
(include 'apply-partial "./evaluation/apply-partial")
(include 'string-downcase "./strings/string-downcase")
(include 'string-capitalize "./strings/string-capitalize")
(include 'string-upcase "./strings/string-upcase")
(include 'word "./strings/word")

(defun format:case-conversion:sub (astring / first-word)
  (apply
    'strcat
    (mapcar (function (lambda (token)
                        (if (equal token '(32) ;|" "|; )
                          " "
                          (if first-word
                            (string-downcase 'STR token nil nil)
                            (progn (setq first-word T)
                                   (string-capitalize 'STR token nil nil)
                            )
                          )
                        )
                      )
            )
            (word 'SLIST astring '(32) ;|" "|; nil T nil nil)
    )
  )
)

(defun format:case-conversion (astring modifier)
  (cond ((and (not (null (member 'AT modifier)))
              (not (null (member 'COLON modifier)))
         )
         (string-upcase 'STR astring nil nil)
        )
        ((and (not (null (member 'AT modifier)))
              (null (member 'COLON modifier))
         )
         (format:case-conversion:sub astring)
        )
        ((and (null (member 'AT modifier))
              (not (null (member 'COLON modifier)))
         )
         (string-capitalize 'STR astring nil nil)
        )
        (T (string-downcase 'STR astring nil nil))
  )
)

(defun format:case-conversion:exit (modifier) "")

(defun format:case-conversion:enter
       (modifier / case-conversion-break result)
  (setq result (format:case-conversion
                 (format:main
                   (apply 'append (format:in-parentheses 'case-conversion))
                   'case-conversion-break
                   nil
                 )
                 modifier
               )
  )
  (if (= case-conversion-break 'EXIT)
    (set $break-symbol 'EXIT)
  )
  result
)


;;;_$ (format nil "~(This is a pen~)" nil)
;;;"this is a pen"
;;;_$ (format nil "~:(This is a pen~)" nil)
;;;"This Is A Pen"
;;;_$ (format nil "~@(This is a pen~)" nil)
;;;"This is a pen"
;;;_$ (format nil "~:@(This is a pen~)" nil)
;;;"THIS IS A PEN"
