;;;(include 'typep "./types/typep")

;;;(typep item type-symbol)
;;;
;;;item : atom or list
;;;
;;;type-symbol : symbol of Data-type
;;;
;;;return : T or nil

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'type-of "./types/type-of")

(defun typep (item type-symbol)
  (= (type-of item) type-symbol)
)