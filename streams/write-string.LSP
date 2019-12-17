;;;(include 'write-string "./streams/write-string")

;;; +------------------------------------------------------+
;;;   Copyright (c) 2020 manual chair japan                 
;;;   Released under the MIT license                        
;;;   https://opensource.org/licenses/mit-license.php       
;;; +------------------------------------------------------+

(include 'default "./common/default")
(include 'typep "./types/typep")
(include 'coerce "./types/coerce")
(include 'mapc "./conses/mapc")
(include 'stringp "./strings/stringp")
(include 'sequence-type-of "./sequences/_sequence-type-of")
(include 'subseq-list "./sequences/subseq-list")

(defun write-string (astring stream start end / alist)
  (if (stringp astring)
    (progn
      (setq alist (subseq-list (coerce astring 'SLIST) start end)
            start (max 0 (default start '0))
            end   (min (default end '(length alist)) (length alist))
      )
      (if (typep stream 'FILE)
        (mapc
          (function (lambda (ascii-code) (write-char ascii-code stream)))
          (list (coerce alist 'LIST))
        )
        (prompt (coerce alist 'STR))
      )
      (coerce alist (sequence-type-of astring))
    )
  )
)