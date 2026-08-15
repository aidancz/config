(define __zoxide_pwd
  (lambda ()
    (charspan->string (sh-cwd (sh-globals)))))

(define __zoxide_cd
  (lambda args
    (cond
      ((null? args) (sh-cd (sh-globals)))
      ((string=? (car args) "-") (sh-cd- (sh-globals)))
      (else (sh-cd (sh-globals) (car args))))))

(define __zoxide_hook
  (let ((pwd (__zoxide_pwd)))
    (lambda (pwd-after-eval)
      (unless (string=? pwd-after-eval pwd)
        (set! pwd pwd-after-eval)
        (sh-run {command zoxide add -- (values pwd-after-eval)})))))

(let ((repl-original-eval (repl-current-eval)))
  (repl-current-eval
    (lambda (form env)
      (let ((vals (repl-original-eval form env)))
        (__zoxide_hook (__zoxide_pwd))
        vals))))

(sh-alias "__zoxide_z"
  (lambda (args)
    (cond
      ((null? args) (__zoxide_cd))
      ((and (= (length args) 1)
            (string=? (car args) "-"))
       (__zoxide_cd (car args)))
      ((and (= (length args) 1)
            (file-directory? (car args)))
       (__zoxide_cd (car args)))
      ((and (= (length args) 2)
            (string=? (car args) "--"))
       (__zoxide_cd (cadr args)))
      (else
       (let* ((job {command zoxide query --exclude (__zoxide_pwd) -- (values args)})
              (result (sh-run/string-rtrim-newlines job))
              (status (sh-job-status job)))
         (when (ok? status) (__zoxide_cd result)))))
    (quote ())))

(sh-alias "__zoxide_zi"
  (lambda (args)
    (let* ((job {command zoxide query --interactive -- (values args)})
           (result (sh-run/string-rtrim-newlines job))
           (status (sh-job-status job)))
      (when (ok? status) (__zoxide_cd result)))
    (quote ())))

(sh-alias "z" (quote ("__zoxide_z")))
(sh-alias "zi" (quote ("__zoxide_zi")))
