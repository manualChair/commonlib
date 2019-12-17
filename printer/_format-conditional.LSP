;;;(include 'format:conditional:enter "./printer/_format-conditional")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'format:in-parentheses "./printer/_format-in-parentheses")
;;
(include 'default "./common/default")
(include 'integerp "./numbers/integerp")

(defun format:conditional:colon (segments)
  (setq segments (vl-remove-if 'vl-symbolp segments))
  (if (format:pop-value)
    (cadr segments)
    (car segments)
  )
)

(defun format:conditional:at (segments)
  (setq segments (vl-remove-if 'vl-symbolp segments))
  (if (format:pop-value)
    (progn (format:skip-value -1) (car segments))
    '("")
  )
)

(defun format:conditional:non-option:default (segments)
  (if (not (endp segments))
    (cond ((or (= (car segments) 'COLON-AT) (= (car segments) 'COLON))
           (progn (setq default-segment (cadr segments)) nil)
          )
          ((vl-symbolp (car segments))
           (format:conditional:non-option:default (cdr segments))
          )
          (T
           (cons (car segments)
                 (format:conditional:non-option:default (cdr segments))
           )
          )
    )
  )
)

(defun format:conditional:non-option (segments / default-segment token)
  (setq segments (format:conditional:non-option:default segments)
        index    (default (eval index) '(format:pop-value))
  )
  (default
    (if (and (integerp index) (not (minusp index)))
      (default (nth index segments) 'default-segment)
      default-segment
    )
    ''("")
  )
)

(defun format:conditional:defun-separator ()
  (lambda (modifier rest-char-on-line length-of-line / colon at)
    (setq colon  (not (null (member 'COLON modifier)))
          at     (not (null (member 'AT modifier)))
          result (cond ((and colon at) (cons 'COLON-AT result))
                       (colon (cons 'COLON result))
                       (at (cons 'AT result))
                       (T (cons '| result))
                 )
    )
  )
)

(defun format:conditional:exit (modifier) "")

(defun format:conditional:enter (modifier        index
                                 /               format:separator
                                 segments        conditional-break
                                 result
                                )
  (setq format:separator (format:conditional:defun-separator)
        segments         (format:in-parentheses 'conditional)
        result           (format:main
                           (cond ((not (null (member 'COLON modifier)))
                                  (format:conditional:colon segments)
                                 )
                                 ((not (null (member 'AT modifier)))
                                  (format:conditional:at segments)
                                 )
                                 (T (format:conditional:non-option segments))
                           )
                           'conditional-break
                           nil
                         )
  )
  (if (= conditional-break 'EXIT) (set $break-symbol 'EXIT))
  result
)

;;;_$ (format nil "~[A~;B~;C~;D~:;1234~]" '(1))
;;;"B"
;;;_$ (format nil "~[A~;B~;C~;D~:;1234~]" '(5))
;;;"1234"
;;;_$ (format nil "~3[A~;B~;C~;D~:;1234~]" nil)
;;;"D"

;;;_$ (format nil "~:[False~;True~]" '(T))
;;;"True"
;;;_$ (format nil "~:[False~;True~]" '(nil))
;;;"False"

;;;_$ (format nil "~@[True~] ~A" '(T 100))
;;;"True T"
;;;_$ (format nil "~@[~A~] ~A" '(100 200))
;;;"100 200"
;;;_$ (format nil "~@[~A~] ~A" '(nil 100))
;;;" 100"
;;;_$ (format nil "~@[True~] ~A" '(nil 100))
;;;" 100"
