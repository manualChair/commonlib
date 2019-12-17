;;;(include 'format:formatString "./printer/_format-formatString")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include '*format-directive* "./printer/_format-directive")
(include 'format:integer->slist "./printer/_format-integer-slist")
;;
(include 'default "./common/default")
(include 'apply-partial "./evaluation/apply-partial")
(include 'compose "./evaluation/compose")
(include 'coerce "./types/coerce")
(include 'endp "./conses/endp")
(include 'assoc-if "./conses/assoc-if")
(include 'char-equal "./characters/char-equal")
(include 'char "./strings/char")
(include 'word "./strings/word")
(include 'reduce "./sequences/reduce")
(include 'padding-list "./sequences/padding-list")
(include 'position "./sequences/position")
(include 'parse-integer-list "./numbers/parse-integer-list")
;;

(defun format:formatString:modifier:sub
       (alist modifier-code modifier-symbol / mod-index)
  (if (and (not (null alist))
           (setq mod-index (position modifier-code alist nil nil nil nil))
           (or (zerop mod-index)
               (/= (char alist (1- mod-index)) 39 ;|(ascii "'")|;)
           )
      )
    (setq modifier (cons modifier-symbol modifier)
          alist    (vl-remove modifier-code alist)
    )
  )
  alist
)

(defun format:formatString:modifier (alist)
  (apply
    '(reduce
      'compose
      '((apply-partial 'format:formatString:modifier:sub '(58 COLON) '(1))
        (apply-partial 'format:formatString:modifier:sub '(64 AT) '(1))
       )
     )
    (list alist)
  )
)

;;

(defun format:formatString:escape-char (alist)
  (if (not (endp alist))
    (if (char-equal (car alist) 39 ;|(ascii "'")|;)
      (append (format:integer->slist (cadr alist) 10 nil nil nil)
              (format:formatString:escape-char (cddr alist))
      )
      (cons (car alist) (format:formatString:escape-char (cdr alist)))
    )
  )
)

;;

(defun format:formatString:purse-arg (alist)
  (if alist
    (cond
      ((char-equal (car alist) 86 ;|(ascii "V")|;) ''(format:pop-value))
      ((char-equal (car alist) 35 ;|(ascii "#")|;)
       ''(format:number-rest-value)
      )
      (T (parse-integer-list alist nil nil 10 T))
    )
  )
)

;;

(defun format:formatString:exit-directive
       (func num-of-args / modifier args)
  (if (boundp 'func)
    (setq args   (mapcar
                   (function
                     (lambda (arg / alist)
                       (if
                         (not
                           (null (setq alist (coerce (default arg '"") 'SLIST)))
                         )
                          (format:formatString:purse-arg alist)
                       )
                     )
                   )
                   (padding-list
                     (if buffer
                       (word 'STR
                             (format:formatString:modifier
                               (format:formatString:escape-char
                                 (coerce (pop-buffer) 'SLIST)
                               )
                             )
                             ","
                             nil
                             nil
                             nil
                             nil
                       )
                     )
                     'RIGHT
                     num-of-args
                     nil
                     nil
                   )
                 )
          result (cons (cons func (cons (list 'QUOTE modifier) args)) result)
    )
  )
  (setq in-directive nil)
)

(defun format:formatString:enter-directive ()
  (if buffer
    (setq result (cons (pop-buffer) result))
  )
  (setq in-directive T)
)

(defun format:formatString
       (slist / in-directive ascii-code directive buffer result pop-buffer)
  (setq in-directive nil
        pop-buffer
         (lambda (/ token)
           (setq token  (coerce (reverse buffer) 'STR)
                 buffer nil
           )
           token
         )
  )
  (foreach ascii-code slist
    (if in-directive
      (if (and (setq directive
                      (assoc-if
                        (function (lambda (key) (char-equal key ascii-code))
                        )
                        *format-directive*
                      )
               )
               (/= (car buffer) 39 ;| (ascii "'") |;)
          )
        (apply 'format:formatString:exit-directive (cdr directive))
        (setq buffer (cons ascii-code buffer))
      )
      (if (= ascii-code 126 ;| (ascii "~") |;)
        (format:formatString:enter-directive)
        (setq buffer (cons ascii-code buffer))
      )
    )
  )
  (if buffer
    (setq result (cons (pop-buffer) result))
  )
  (reverse result)
)