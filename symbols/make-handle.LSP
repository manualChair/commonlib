;;;(include 'make-handle "./symbols/make-handle")

;;;(make-handle group data)
;;;
;;;group : string, list, symbol, variant(string or safe-array), safe-array(integer)
;;;
;;;data : atom or list
;;;
;;;return : symbol
;;;
;;;(release-handle handle)
;;;
;;;handle : symbol
;;;
;;;return : nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

;;;_$ (setq a (make-handle "DATA" '(DATA 123 456 789)))
;;;*DATA:HND-0*
;;;_$ (vl-symbol-value a)
;;;(DATA 123 456 789)
;;;_$ (set a '(DATA +++ +++ +++))
;;;(DATA +++ +++ +++)
;;;_$ (vl-symbol-value a)
;;;(DATA +++ +++ +++)
;;;_$ (release-handle a)
;;;nil
;;;_$ (vl-symbol-value a)
;;;nil

(include 'default "./common/default")
(include 'coerce "./types/coerce")
(include 'ALValue "./conses/ALValue")
(include 'set-ALValue "./conses/set-ALValue")
(include 'concatenate "./sequences/concatenate")

(setq *handleCounts* nil)

(defun make-handle:increment-count (count)
  (if (= count 2147483647)
    0
    (1+ count)
  )
)

(defun make-handle (group data / count start handle)
  (setq group (coerce group 'SYM)
        count (default (ALValue *handleCounts* group) 0)
        start count
  )
  (while (boundp (setq handle
                        (concatenate 'SYM (list "*" group ":HND-" (itoa count) "*"))
                 )
         )
    (if (= (setq count (make-handle:increment-count count)) start)
      (progn (princ "\n ERROR : Handle count was OVERFLOW") (exit))
    )
  )
  (setq count          (make-handle:increment-count count)
        *handleCounts* (set-ALValue *handleCounts* group count)
  )
  (set handle data)
  handle
)

(defun release-handle (handle) (set handle nil))