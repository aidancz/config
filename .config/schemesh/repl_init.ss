;; https://github.com/cosmos72/schemesh/tree/main/doc

;; * lineedit

;; https://github.com/cosmos72/schemesh/blob/main/lineedit/lineedit.ss

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
