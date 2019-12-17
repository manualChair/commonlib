;;;(include 'defstruct "./structures/defstruct")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(defun defstruct (structure          fieldList          /
                  defstruct:field-r  fieldNameList      structure-string
                 )
  (if (or (not (vl-symbolp structure)) (not (listp fieldList))) (exit))
  ;;
  (defun defstruct:field-r (flist)
    (if flist
      (progn
        (set
          (read (strcat structure-string "-" (vl-symbol-name (car flist))))
          (eval (list 'lambda
                      '($_structure)
                      (list 'nth
                            (1+ (vl-position (car flist) fieldNameList))
                            '$_structure
                      )
                )
          )
        )
        (defstruct:field-r (cdr flist))
      )
    )
  )
  (setq structure-string (vl-symbol-name structure)
        fieldNameList    (mapcar 'car fieldList)
  )
  ;;
  (set                                  ; function MAKE-<STRUCTURE>
    (read (strcat "make-" structure-string))
    (eval
      (list
        'lambda
        fieldNameList
        (cons
          'list
          (cons
            (list 'quote structure)
            (mapcar (function (lambda (arg)
                                (list 'if
                                      (car arg)
                                      (car arg)
                                      (list 'eval (list 'quote (cdr arg)))
                                )
                              )
                    )
                    fieldList
            )
          )
        )
      )
    )
  )
  ;;
  (set
    (read (strcat structure-string "-p")) ; function <STRUCTURE>-p
    (eval (list 'lambda
                '($_structure)
                (list 'if
                      '(vl-consp $_structure)
                      (list '= '(car $_structure) (list 'quote structure))
                )
          )
    )
  )
  ;;
  (defstruct:field-r fieldNameList)     ; function <STRUCTURE>-<FIELD ... >
  (set structure (cons 'structure (mapcar 'car fieldList)))
  structure
)
