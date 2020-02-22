;;;(include 'coerce "./types/coerce")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'member-of-option-p "./common/member-of-option-p")
(include 'type-of "./types/type-of")
(include 'list->string "./types/multibyte/list-string")
(include 'string->list "./types/multibyte/string-list")
(include 'characterp "./characters/characterp")
(include 'identity "./flow/identity")
(include 'SSToList "./types/AutoCAD/SSToList")
(include 'listToSS "./types/AutoCAD/listToSS")
(include 'make-array "./arrays/make-array")

(setq *coerce:func-table*
       (list
         (list
           'nil
           (cons 'STR (function (lambda (value) "")))
           '(SYM . identity)
           '(LIST . identity)
           '(SLIST . identity)
           (cons 'PICKSET
                 (function (lambda (value) (ssadd)))
           )
           (cons 'VARIANT
                 (function
                   (lambda (value)
                     (vlax-make-variant value vlax-vbEmpty)
                   )
                 )
           )
           '(SAFEARRAY . identity)
           '(BOOL . coerce:boolean)
         )
         ;;
         (list
           'INT
           '(INT . identity)
           '(REAL . float)
           '(STR . itoa)
           '(STRC . chr)
           '(SYM . identity)
           (cons 'VARIANT
                 (function
                   (lambda (value)
                     (vlax-make-variant value vlax-vbLong)
                   )
                 )
           )
           '(BOOL . coerce:boolean)
           '(CHAR . identity)
         )
         ;;
         (list
           'REAL
           '(INT . fix)
           '(REAL . identity)
           '(STR . rtos)
           '(SYM . identity)
           (cons VARIANT
                 (function
                   (lambda (value)
                     (vlax-make-variant value vlax-vbDouble)
                   )
                 )
           )
           '(BOOL . coerce:boolean)
           '(CHAR . fix)
           (cons 'STRC (function (lambda (value) (chr (fix value)))))
         )
         ;;
         (list
           'STR
           '(INT . atoi)
           '(REAL . atof)
           '(STR . identity)
           '(SYM . read)
           '(LIST . vl-string->list)
           '(SLIST . string->list)
           (cons 'SUBR (function (lambda (value) (eval (read value)))))
           (cons 'VARIANT
                 (function
                   (lambda (value)
                     (vlax-make-variant value vlax-vbString)
                   )
                 )
           )
           (cons
             'SAFEARRAY
             (function
               (lambda (value)
                 (coerce (vl-string->list value) 'SAFEARRAY)
               )
             )
           )
           (cons 'VECTOR
                 (function
                   (lambda (value) (coerce value 'SAFEARRAY))
                 )
           )
           '(BOOL . coerce:boolean)
           (cons 'CHAR
                 (function (lambda (value) (car (string->list value))))
           )
           (cons
             'STRC
             (function (lambda (value)
                         (list->string (list (car (string->list value))))
                       )
             )
           )
         )
         ;;
         (list
           'SYM
           (cons 'INT
                 (function (lambda (value) (atoi (vl-symbol-name value))))
           )
           (cons 'REAL
                 (function (lambda (value) (atof (vl-symbol-name value))))
           )
           '(STR . vl-symbol-name)
           '(SYM . identity)
           (cons 'LIST
                 (function
                   (lambda (value)
                     (coerce (vl-symbol-name value) 'LIST)
                   )
                 )
           )
           (cons 'SLIST
                 (function
                   (lambda (value)
                     (coerce (vl-symbol-name value) 'SLIST)
                   )
                 )
           )
           '(SUBR . eval)
           (cons
             'VARIANT
             (function
               (lambda (value)
                 (cond
                   ((or (= value ':vlax-true)
                        (= value ':vlax-false)
                    )
                    (vlax-make-variant value vlax-vbBoolean)
                   )
                   (T
                    (vlax-make-variant
                      (vl-symbol-name value)
                      vlax-vbString
                    )
                   )
                 )
               )
             )
           )
           (cons
             'SAFEARRAY
             (function
               (lambda (value)
                 (coerce (vl-symbol-name value) 'SAFEARRAY)
               )
             )
           )
           (cons 'VECTOR
                 (function
                   (lambda (value) (coerce value 'SAFEARRAY))
                 )
           )
           (cons 'BOOL
                 (function (lambda (value)
                             (if (= value ':vlax-false)
                               :vlax-false
                               (coerce:boolean value)
                             )
                           )
                 )
           )
           (cons 'CHAR
                 (function
                   (lambda (value)
                     (coerce (vl-symbol-name value) 'CHAR)
                   )
                 )
           )
           (cons 'STRC
                 (function
                   (lambda (value)
                     (coerce (vl-symbol-name value) 'STRC)
                   )
                 )
           )
         )
         ;;
         (list
           'LIST
           (cons 'INT
                 (function
                   (lambda (value) (coerce (car value) 'INT))
                 )
           )
           (cons
             'REAL
             (function
               (lambda (value) (coerce (car value) 'REAL))
             )
           )
           '(STR . list->string)
           (cons 'SYM
                 (function (lambda (value) (read (list->string value))))
           )
           (cons
             'LIST
             (function
               (lambda (value)
                 (if (not (vl-every 'atom value))
                   (apply 'append
                          (mapcar 'decode-multibytecharactor
                                  value
                          )
                   )
                   value
                 )
               )
             )
           )
           (cons
             'SLIST
             (function (lambda (value)
                         (coerce (coerce value 'STR) 'SLIST)
                       )
             )
           )
           '(SUBR . eval)
           '(PICKSET . ListToSS)
           (cons
             'VARIANT
             (function
               (lambda (value)
                 (coerce (coerce value 'SAFEARRAY) 'VARIANT)
               )
             )
           )
           (cons
             'SAFEARRAY
             (function
               (lambda (value / atype)
                 (make-array
                   (setq
                     atype (coerce:list-type-as-arrray
                             value
                           )
                   )
                   (coerce:list-dimensions-as-arrray value)
                   (if (= atype 'VLA-OBJECT)
                     (mapcar
                       (function (lambda (ename)
                                   (coerce ename 'VLA-OBJECT)
                                 )
                       )
                       value
                     )
                     value
                   )
                 )
               )
             )
           )
           (cons
             'VECTOR
             (function
               (lambda (value)
                 (coerce
                   (if
                     (< 1
                        (length
                          (coerce:list-dimensions-as-arrray
                            value
                          )
                        )
                     )
                      (apply 'append value)
                      value
                   )
                   'SAFEARRAY
                 )
               )
             )
           )
           '(BOOL . coerce:boolean)
           (cons 'CHAR
                 (function (lambda (value)
                             (if (characterp value)
                               value
                               (car (coerce value 'SLIST))
                             )
                           )
                 )
           )
           (cons 'STRC
                 (function (lambda (value)
                             (if (characterp value)
                               (list->string (list value))
                               (coerce (car value) 'STRC)
                             )
                           )
                 )
           )
         )
         ;;
         (list 'SUBR
               '(SUBR . identity)
               '(BOOL . coerce:boolean)
         )
         ;;
         (list
           'ENAME
           '(ENAME . identity)
           '(VLA-OBJECT . vlax-ename->VLA-object)
           (cons 'VARIANT
                 (function
                   (lambda (value)
                     (coerce (vlax-ename->VLA-object value)
                             'VARIANT
                     )
                   )
                 )
           )
           '(BOOL . coerce:boolean)
         )
         ;;
         (list
           'VLA-OBJECT
           '(ENAME . vlax-VLA-object->ename)
           '(VLA-OBJECT . identity)
           (cons 'VARIANT
                 (function
                   (lambda (value)
                     (vlax-make-variant value vlax-vbObject)
                   )
                 )
           )
           '(BOOL . coerce:boolean)
         )
         ;;
         (list
           'PICKSET
           '(LIST . SSToList)
           '(PICKSET . identity)
           (cons
             'VARIANT
             (function
               (lambda (value)
                 (coerce (coerce value 'SAFEARRAY) 'VARIANT)
               )
             )
           )
           (cons 'SAFEARRAY
                 (function
                   (lambda (value)
                     (coerce (coerce value 'LIST) 'SAFEARRAY)
                   )
                 )
           )
           (cons 'VECTOR
                 (function
                   (lambda (value) (coerce value 'SAFEARRAY))
                 )
           )
           '(BOOL . coerce:boolean)
         )
         ;;
         (list
           'VARIANT
           (cons 'INT
                 (function
                   (lambda (value)
                     (coerce (vlax-variant-value value) 'INT)
                   )
                 )
           )
           (cons
             'REAL
             (function
               (lambda (value)
                 (coerce (vlax-variant-value value) 'REAL)
               )
             )
           )
           (cons 'STR
                 (function
                   (lambda (value)
                     (coerce (vlax-variant-value value) 'STR)
                   )
                 )
           )
           (cons 'SYM
                 (function
                   (lambda (value)
                     (coerce (vlax-variant-value value) 'SYM)
                   )
                 )
           )
           (cons
             'LIST
             (function
               (lambda (value)
                 (coerce (vlax-variant-value value) 'LIST)
               )
             )
           )
           (cons
             'SLIST
             (function
               (lambda (value)
                 (coerce (vlax-variant-value value) 'SLIST)
               )
             )
           )
           (cons
             'SUBR
             (function
               (lambda (value)
                 (coerce (vlax-variant-value value) 'SUBR)
               )
             )
           )
           (cons
             'ENAME
             (function
               (lambda (value)
                 (coerce (vlax-variant-value value) 'ENAME)
               )
             )
           )
           (cons
             'VLA-OBJECT
             (function (lambda (value)
                         (coerce (vlax-variant-value value)
                                 'VLA-OBJECT
                         )
                       )
             )
           )
           (cons
             'PICKSET
             (function (lambda (value)
                         (coerce (vlax-variant-value value)
                                 'PICKSET
                         )
                       )
             )
           )
           '(VARIANT . identity)
           (cons
             'SAFEARRAY
             (function (lambda (value)
                         (coerce (vlax-variant-value value)
                                 'SAFEARRAY
                         )
                       )
             )
           )
           (cons
             'VECTOR
             (function
               (lambda (value)
                 (setq value (coerce value 'LIST))
                 (coerce
                   (if
                     (< 1
                        (length
                          (coerce:list-dimensions-as-arrray
                            value
                          )
                        )
                     )
                      (apply 'append value)
                      value
                   )
                   'SAFEARRAY
                 )
               )
             )
           )
           (cons
             'BOOL
             (function
               (lambda (value)
                 (coerce (vlax-variant-value value) 'BOOL)
               )
             )
           )
           (cons
             'CHAR
             (function
               (lambda (value)
                 (coerce (vlax-variant-value value) 'CHAR)
               )
             )
           )
           (cons
             'STRC
             (function
               (lambda (value)
                 (coerce (vlax-variant-value value) 'STRC)
               )
             )
           )
         )
         ;;
         (list
           'SAFEARRAY
           (cons
             'INT
             (function
               (lambda (value)
                 (coerce (vlax-safearray->list value) 'INT)
               )
             )
           )
           (cons
             'REAL
             (function
               (lambda (value)
                 (coerce (vlax-safearray->list value) 'REAL)
               )
             )
           )
           (cons
             'STR
             (function
               (lambda (value)
                 (coerce (vlax-safearray->list value) 'STR)
               )
             )
           )
           (cons
             'SYM
             (function
               (lambda (value)
                 (coerce (vlax-safearray->list value) 'SYM)
               )
             )
           )
           (cons 'LIST
                 (function
                   (lambda (value)
                     (if (= (vlax-safearray-type value)
                            vlax-vbObject
                         )
                       (mapcar 'vlax-VLA-object->ename
                               (vlax-safearray->list value)
                       )
                       (vlax-safearray->list value)
                     )
                   )
                 )
           )
           (cons
             'SLIST
             (function (lambda (value)
                         (coerce (vlax-safearray->list value)
                                 'SLIST
                         )
                       )
             )
           )
           (cons
             'PICKSET
             (function (lambda (value)
                         (coerce (vlax-safearray->list value)
                                 'PICKSET
                         )
                       )
             )
           )
           (cons 'VARIANT
                 (function
                   (lambda (value) (vlax-make-variant value))
                 )
           )
           '(SAFEARRAY . identity)
           (cons
             'VECTOR
             (function
               (lambda (value)
                 (setq value (coerce value 'LIST))
                 (coerce
                   (if
                     (< 1
                        (length
                          (coerce:list-dimensions-as-arrray
                            value
                          )
                        )
                     )
                      (apply 'append value)
                      value
                   )
                   'SAFEARRAY
                 )
               )
             )
           )
           '(BOOL . coerce:boolean)
           (cons
             'CHAR
             (function
               (lambda (value)
                 (coerce (vlax-safearray->list value) 'CHAR)
               )
             )
           )
           (cons
             'STRC
             (function
               (lambda (value)
                 (coerce (vlax-safearray->list value) 'STRC)
               )
             )
           )
         )
         ;;
       )
)

(setq *coerce:result-type-table*
       '((nil nil SYM)
         (INT INT)
         (REAL REAL)
         (STR STR)
         (SYM nil INT REAL SYM LIST SURB USUBR EXRXSUBR)
         (LIST nil LIST)
         (SLIST nil LIST)
         (SUBR SUBR USUBR EXRXSUBR)
         (ENAME ENAME)
         (VLA-OBJECT VLA-OBJECT)
         (PICKSET PICKSET)
         (VARIANT VARIANT)
         (SAFEARRAY SAFEARRAY)
         (VECTOR SAFEARRAY)
         (BOOL SYM)
         (CHAR INT LIST)
         (STRC STR)
        )
)

(setq *coerce:type-groups*
       '((nil . nil)
         (INT . INT)
         (INTEGER . INT)
         (REAL . REAL)
         (FLOAT . REAL)
         (DOUBLE . REAL)
         (STR . STR)
         (STRING . STR)
         (SYM . SYM)
         (SYMBOL . SYM)
         (LIST . LIST)
         (SLIST . SLIST)
         (SUBR . SUBR)
         (USUBR . SUBR)
         (EXRXSUBR . SUBR)
         (FUNCTON . SUBR)
         (ENAME . ENAME)
         (VLA-OBJECT . VLA-OBJECT)
         (PICKSET . PICKSET)
         (VARIANT . VARIANT)
         (SAFEARRAY . SAFEARRAY)
         (ARRAY . SAFEARRAY)
         (VECTOR . VECTOR)
         (BOOL . BOOL)
         (BOOLEAN . BOOL)
         (CHAR . CHAR)
         (CHARACTOR . CHAR)
         (STRC . STRC)
         (STRING-OF-CHARACTOR . STRC)
        )
)

;;

(defun coerce:boolean (value)
  (if value
    ':vlax-true
    ':vlax-false
  )
)

(defun coerce:list-type-as-arrray (alist / result)
  (if (vl-consp (car alist))
    (coerce:list-type-as-arrray (car alist))
    (if (= (setq result (type-of (car alist))) 'ENAME)
      'VLA-OBJECT
      result
    )
  )
)

(defun coerce:list-dimensions-as-arrray (alist)
  (if (vl-consp (car alist))
    (cons (length alist) (coerce:list-dimensions-as-arrray (car alist)))
    (list (length alist))
  )
)

;;

(defun coerce:type-group (atype) (cdr (assoc atype *coerce:type-groups*)))

(defun coerce:func-table (object)
  (cdr (assoc (coerce:type-group (type object)) *coerce:func-table*))
)

(defun coerce:check (value)
  (not (null (member (type-of value)
                     (cdr (assoc (coerce:type-group result-type)
                                 *coerce:result-type-table*
                          )
                     )
             )
       )
  )
)

(defun coerce:main (/ func result)
  (if (and (setq func (cdr (assoc (coerce:type-group result-type)
                                  (coerce:func-table object)
                           )
                      )
           )
           (coerce:check (setq result (apply func (list object))))
      )
    result
    (exit)
  )
)

(defun coerce (object result-type)
  (if (member-of-option-p
        'coerce
        'result-type
        (mapcar 'car *coerce:type-groups*)
      )
    (if (null result-type)
      (if (= (type-of object) 'SYM)
        (if (= object :vlax-false)
          nil
          (not (null object))
        )
        (not (null object))
      )
      (coerce:main)
    )
  )
)