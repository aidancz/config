;; https://github.com/cosmos72/schemesh/tree/main/doc

;; * lineedit

;; https://github.com/cosmos72/schemesh/blob/main/lineedit/lineedit.ss

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (linectx-eof-set! lctx #t))
  "\x1b;\x4f;\x50;")
;; <f1>

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (linectx-insert/string! lctx "schemesh"))
  "\x18;\x14;")
;; C-x C-t

(linectx-keytable-insert! linectx-default-keytable
  lineedit-key-redraw "\x18;\x0c;")
;; C-x C-l

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (lineedit-key-cmd lctx "clear"))
  "\x0c;")
;; C-l

(linectx-keytable-insert! linectx-default-keytable
  lineedit-key-history-next
  "\x1b;\x5b;\x42;")
;; <down>

(linectx-keytable-insert! linectx-default-keytable
  lineedit-key-history-prev
  "\x1b;\x5b;\x41;")
;; <up>

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (vscreen-cursor-move/down! (linectx-vscreen lctx) 1))
  "\x0e;")
;; C-n

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (vscreen-cursor-move/up! (linectx-vscreen lctx) 1))
  "\x10;")
;; C-p
