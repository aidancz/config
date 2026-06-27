;; https://github.com/cosmos72/schemesh/tree/main/doc

;; # scheme

(define v values)
;; https://github.com/cosmos72/schemesh/issues/40

(define e expand)

;; # env

;; (sh-eval-file (shell-string {$XDG_CONFIG_HOME/schemesh/env.ss}))
;; at this time, $XDG_CONFIG_HOME is unavailable, so:
(sh-eval-file (shell-string {$HOME/.config/schemesh/env.ss}))

;; # prompt

(define my-prompt
  (lambda (lctx)
    (let ((a (linectx-prompt-ansi-text lctx))
          (p (linectx-parser-name lctx)))
      (ansi-text-clear! a)
      (blue a "(")
      (blue a (cond
                ((eq? p 'shell) "$")
                ((eq? p 'scheme) "λ")))
      (blue a " ")
      (blue a (c-hostname))
      (blue a " ")
      (blue a (c-username))
      (blue a " ")
      (blue a (charspan->string (sh-home->~ (sh-cwd))))
      (blue a ")")
      (blue a " ")
      (linectx-prompt-ansi-text-set! lctx a)
    )))

(linectx-prompt-proc my-prompt)

;; # lineedit

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
