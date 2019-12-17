;;;(include 'list->string "./types/multibyte/list-string")

;;;(list->string clist)
;;;
;;;string : list of integer or structure of multibyte charactor
;;;
;;;return : string

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include '*multi-byte-char:function* "./types/multibyte/multi-byte-char-func")

(defun decode-multibytecharactor:sub (tlist)
  (if tlist
    (if (apply (read (strcat (vl-symbol-name (car tlist)) "-p"))
               (list item)
        )
      (apply (multi-byte-function-decode
               (cdr (assoc (car tlist) *multi-byte-char:function*))
             )
             (list item)
      )
      (decode-multibytecharactor:sub (cdr tlist))
    )
    (list item)
  )
)

(defun decode-multibytecharactor (item)
  (decode-multibytecharactor:sub
    (mapcar 'car *multi-byte-char:function*)
  )
)


(defun list->string (clist)
  (vl-list->string
    (apply 'append (mapcar 'decode-multibytecharactor clist))
  )
)