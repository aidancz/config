;; https://github.com/cosmos72/schemesh/tree/main/doc

;; # env

;; (sh-eval-file (shell-string {$XDG_CONFIG_HOME/schemesh/env.ss}))
;; at this time, $XDG_CONFIG_HOME is unavailable, so:
(sh-eval-file (shell-string {$HOME/.config/schemesh/env.ss}))

;; # startx

(if (and (string=? (sh-env-ref (sh-globals) "DISPLAY") "")
         (string=? (sh-env-ref (sh-globals) "XDG_VTNR") "1"))
    (sh-run {exec startx}))

;; # alias

(sh-eval-file (shell-string {$XDG_CONFIG_HOME/schemesh/alias.ss}))

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

;; (linectx-keytable-insert! linectx-default-keytable
;;   (lambda (lctx)
;;     ;; (repl-parser-set 'scheme)
;;     ;; (repl-parser-set 'shell)
;;     ;; (repl-parser-toggle)
;;   "\x1b;\x4f;\x51;\x0d;")
;; ;; <f2> s

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (sh-run {setsid -f $TERMINAL >/dev/null 2>&1}))
  "\x1b;\x4f;\x51;\x0d;")
;; <f2> <cr>

;; (linectx-keytable-insert! linectx-default-keytable
;;   (lambda (lctx)
;;     ())
;;   "\x1b;\x4f;\x51;\x77;")
;; ;; <f2> w
;; ;; TODO: zoxide

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (let ((path (sh-run/string-rtrim-newlines {fzf --no-multi}))
          (cd (top-level-value 'sh-cd))
          (dirname (lambda (path) (sh-run/string-rtrim-newlines {dirname (values path)}))))
      (if (file-directory? path)
        (cd path)
        (cd (dirname path)))
      ;; (linectx-redraw-all lctx)
    ))
  "\x1b;\x4f;\x51;\x65;")
;; <f2> e

(sh-alias "y"
  (lambda (args)
    (let ((tmp (sh-run/string-rtrim-newlines {mktemp -t "yazi-cwd.XXXXXX"})))
      (sh-run {command yazi (values args) (string-append "--cwd-file=" tmp)})
      (let ((cwd (call-with-input-file tmp get-string-all)))
        (if (and (not (eof-object? cwd))
                 (not (string=? cwd (charspan->string (sh-cwd (sh-globals)))))
                 (file-directory? cwd))
            (sh-cd (sh-globals) cwd)))
      (file-delete tmp))
    (quote ())))

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (sh-run {y}))
  "\x1b;\x4f;\x51;\x66;")
;; <f2> f
;; https://yazi-rs.github.io/docs/quick-start#shell-wrapper

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (sh-run {nvim}))
  "\x1b;\x4f;\x51;\x76;")
;; <f2> v

(linectx-keytable-insert! linectx-default-keytable
  (lambda (lctx)
    (sh-run {tig}))
  "\x1b;\x4f;\x51;\x74;")
;; <f2> t
