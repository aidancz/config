(define set!
  (lambda (name value)
    (sh-env-set! #t name value 'export)))

(set! "foo" "bar") ; test

;; # xdg

(set! "XDG_CONFIG_HOME" (shell-string {$HOME/.config}))
(set! "XDG_CACHE_HOME"  (shell-string {$HOME/.cache}))
(set! "XDG_DATA_HOME"   (shell-string {$HOME/.local/share}))
(set! "XDG_STATE_HOME"  (shell-string {$HOME/.local/state}))
(set! "XDG_EXE_HOME"    (shell-string {$HOME/.local/bin}))

;; # aidan

(set! "AIDAN_GIT"   (shell-string {$HOME/sync_git}))
(set! "AIDAN_CLOUD" (shell-string {$HOME/sync_cloud}))

;; # path

(define path_string->list
  (lambda (s)
    (string-split s #\:)))

(define path_list->string
  (lambda (l)
    (string-join l ":")))

(define path_prepend
  (lambda (p)
    (let ((path (path_string->list (shell-string {$PATH}))))
      (unless (member p path)
        (set! "PATH" (path_list->string (cons p path)))))))

(path_prepend (shell-string {$HOME/.local/bin}))
(path_prepend (shell-string {$AIDAN_GIT/yazi/target/release}))
(path_prepend (shell-string {$HOME/.cargo/bin}))
(path_prepend "/usr/heirloom/bin")
(path_prepend (shell-string {$HOME/Desktop/qemacs}))

;; # proxy

(set! "http_proxy"  "http://127.0.0.1:8889/")
(set! "https_proxy" "http://127.0.0.1:8889/")
(set! "all_proxy"   "http://127.0.0.1:8889/")
(set! "no_proxy"    "localhost, 127.0.0.1, ::1")

;; # program default

(set! "TERMINAL" "st")
(set! "EDITOR"   "nvim")
(set! "VISUAL"   "nvim")
(set! "PAGER"    "less")
(set! "BROWSER"  "firefox")
