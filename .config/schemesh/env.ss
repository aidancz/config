;; # locale

(sh-env-set! #t "LANG" "en_US.UTF-8" 'export)

;; # xdg

(sh-env-set! #t "XDG_CONFIG_HOME" (shell-string {$HOME/.config})      'export)
(sh-env-set! #t "XDG_CACHE_HOME"  (shell-string {$HOME/.cache})       'export)
(sh-env-set! #t "XDG_DATA_HOME"   (shell-string {$HOME/.local/share}) 'export)
(sh-env-set! #t "XDG_STATE_HOME"  (shell-string {$HOME/.local/state}) 'export)
(sh-env-set! #t "XDG_EXE_HOME"    (shell-string {$HOME/.local/bin})   'export)

;; # aidan

(sh-env-set! #t "AIDAN_GIT"   (shell-string {$HOME/sync_git})   'export)
(sh-env-set! #t "AIDAN_CLOUD" (shell-string {$HOME/sync_cloud}) 'export)

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
        (sh-env-set! #t "PATH" (path_list->string (cons p path)) 'export)))))

(path_prepend (shell-string {$HOME/.local/bin}))
(path_prepend (shell-string {$AIDAN_GIT/yazi/target/release}))
(path_prepend (shell-string {$HOME/.cargo/bin}))
(path_prepend "/usr/heirloom/bin")
(path_prepend (shell-string {$HOME/Desktop/qemacs}))

;; # proxy

(sh-env-set! #t "http_proxy"  "http://127.0.0.1:8889/"    'export)
(sh-env-set! #t "https_proxy" "http://127.0.0.1:8889/"    'export)
(sh-env-set! #t "all_proxy"   "http://127.0.0.1:8889/"    'export)
(sh-env-set! #t "no_proxy"    "localhost, 127.0.0.1, ::1" 'export)

;; # program default

(sh-env-set! #t "TERMINAL" "st"      'export)
(sh-env-set! #t "EDITOR"   "nvim"    'export)
(sh-env-set! #t "VISUAL"   "nvim"    'export)
(sh-env-set! #t "PAGER"    "less"    'export)
(sh-env-set! #t "BROWSER"  "firefox" 'export)

;; # program path

(sh-env-set! #t "INPUTRC"             (shell-string {$XDG_CONFIG_HOME/readline/.inputrc})   'export)
(sh-env-set! #t "ZDOTDIR"             (shell-string {$XDG_CONFIG_HOME/zsh})                 'export)
;; (sh-env-set! #t "XINITRC"             (shell-string {$XDG_CONFIG_HOME/x11/.xinitrc})        'export)
(sh-env-set! #t "LESSKEYIN"           (shell-string {$XDG_CONFIG_HOME/less/.lesskey})       'export)
(sh-env-set! #t "GTK2_RC_FILES"       (shell-string {$XDG_CONFIG_HOME/gtk-2.0/.gtkrc-2.0})  'export)
(sh-env-set! #t "DOOMDIR"             (shell-string {$XDG_CONFIG_HOME/doom})                'export)
(sh-env-set! #t "WGETRC"              (shell-string {$XDG_CONFIG_HOME/wget/wgetrc})         'export)
(sh-env-set! #t "GOPATH"              (shell-string {$XDG_DATA_HOME/go})                    'export)
(sh-env-set! #t "GNUPGHOME"           (shell-string {$AIDAN_CLOUD/password/gnupg})          'export)
(sh-env-set! #t "PASSWORD_STORE_DIR"  (shell-string {$AIDAN_CLOUD/password/password-store}) 'export)
(sh-env-set! #t "RIPGREP_CONFIG_PATH" (shell-string {$XDG_CONFIG_HOME/ripgrep/.ripgreprc})  'export)
(sh-env-set! #t "INFOPATH"            (shell-string {$HOME/info:})                          'export) ; the final colon has a special meaning here

;; # program config qt

(sh-env-set! #t "QT_QPA_PLATFORMTHEME" "qt5ct" 'export)

;; (sh-env-set! #t "QT_STYLE_OVERRIDE" "kvantum" 'export)

;; # program config fzf

;; (sh-env-set! #t "FZF_DEFAULT_COMMAND" "find -L" 'export)

(sh-env-set! #t "FZF_DEFAULT_OPTS"
  (string-join '(

    ;; color
    "--color=16"
    "--color=fg:-1"
    "--color=fg+:-1:reverse"
    "--color=bg:-1"
    "--color=bg+:-1:reverse"
      "--color=gutter:-1" ; subitem
    "--color=hl:4"
    "--color=hl+:4:reverse"
    "--color=query:-1"
    "--color=info:-1"
    "--color=border:-1"
    "--color=label:-1"
    "--color=prompt:-1"
    "--color=pointer:-1"
    "--color=marker:-1"
    "--color=spinner:-1"
    "--color=header:-1"

    ;; bind
    "--bind=f1:abort"
    "--bind=page-down:page-down"
    "--bind=page-up:page-up"
    "--bind=end:end-of-line"
    "--bind=home:beginning-of-line"
    "--bind=ctrl-end:last"
    "--bind=ctrl-home:first"
    "--bind=down:down"
    "--bind=up:up"
    "--bind=right:forward-char"
    "--bind=left:backward-char"
    "--bind=ctrl-f:half-page-down"
    "--bind=ctrl-d:half-page-up"
    "--bind=ctrl-g:offset-down"
    "--bind=ctrl-s:offset-up"
    "--bind=ctrl-space:offset-middle"
    "--bind=ctrl-j:preview-page-down"
    "--bind=ctrl-k:preview-page-up"
    "--bind=ctrl-l:preview-bottom"
    "--bind=ctrl-h:preview-top"
    "--bind=ctrl-e:end-of-line"
    "--bind=ctrl-a:beginning-of-line"
    ;; "--bind=ctrl-k:kill-line"
    "--bind=ctrl-x:select-all"
    "--bind=ctrl-t:toggle-all"
    "--bind=ctrl-r:clear-multi"
    "--bind=alt-s:toggle-sort"
    "--bind=alt-r:toggle-raw"
    "--bind=change:first"

    ;; misc
    "--layout=reverse"
    "--no-unicode"
    "--pointer="
    "--scrollbar="
    "--highlight-line"
    "--scroll-off=0"
    "--walker=file,dir,follow,hidden"
    "--no-exact"
    "--sort"

  ) " ") 'export)

(sh-env-set! #t "ESCDELAY" "0" 'export)
;; https://github.com/junegunn/fzf/issues/2052
;; https://minsw.github.io/fzf-color-picker/

;; # program config zoxide

(sh-env-set! #t "_ZO_FZF_OPTS" (sh-env-ref #t "FZF_DEFAULT_OPTS") 'export)

;; # program config yazi

(sh-env-set! #t "YAZI_ZOXIDE_OPTS" (sh-env-ref #t "FZF_DEFAULT_OPTS") 'export)

;; # program config ls

(sh-env-set! #t "LS_COLORS"
  (string-join '(

    "di=34"
    "ln=36"
    "or=30;43"
    "ex=32"

    "rs=00"
    "mh=00"
    "mi=00"
    "ca=00"

    "pi=33"
    "so=35"
    "do=35"
    "bd=33"
    "cd=33"
    "su=30;41"
    "sg=30;43"
    "tw=30;42"
    "ow=30;42"
    "st=30;44"

    "*.pdf=33"
    "*.epub=33"
    "*.doc=33"
    "*.xls=33"
    "*.ppt=33"
    "*.docx=33"
    "*.xlsx=33"
    "*.pptx=33"

    "*.jpg=33"
    "*.png=33"
    "*.svg=33"
    "*.mp4=33"
    "*.m4a=33"
    "*.mkv=33"
    "*.gif=33"

    "*.zip=33"
    "*.rar=33"
    "*.7z=33"
    "*.tar=33"
    "*.gz=33"

    "*.exe=33"
    "*.tmp=33"

  ) ":") 'export)

;; https://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors
;; https://linuxhint.com/ls_colors_bash/
;; https://www.gnu.org/software/termutils/manual/termcap-1.3/html_mono/termcap.html

;; # program config less

(sh-env-set! #t "LESS"
  (string-join '(
    "--ignore-case"
    "--incsearch"
    "--RAW-CONTROL-CHARS"
    "--quit-if-one-screen"
  ) " ") 'export)
;; https://stackoverflow.com/questions/74039591/how-to-clear-git-log-pager-output-after-closing
;; https://stackoverflow.com/questions/8883189/how-can-i-turn-on-a-pager-for-the-output-of-git-status

(sh-env-set! #t "LESS_TERMCAP_DEBUG" "1" 'export)
(sh-env-set! #t "GROFF_NO_SGR"       "1" 'export)

(sh-env-set! #t "LESS_TERMCAP_mb" (sh-run/string {printf '\e[31m'}) 'export)
(sh-env-set! #t "LESS_TERMCAP_md" (sh-run/string {printf '\e[33m'}) 'export)
(sh-env-set! #t "LESS_TERMCAP_so" (sh-run/string {printf '\e[7m'})  'export)
(sh-env-set! #t "LESS_TERMCAP_us" (sh-run/string {printf '\e[36m'}) 'export)
(sh-env-set! #t "LESS_TERMCAP_me" (sh-run/string {printf '\e[0m'})  'export)
(sh-env-set! #t "LESS_TERMCAP_se" (sh-run/string {printf '\e[0m'})  'export)
(sh-env-set! #t "LESS_TERMCAP_ue" (sh-run/string {printf '\e[0m'})  'export)

;; termcap terminfo  meaning
;; -------------------------
;; ks      smkx      make the keypad send commands
;; ke      rmkx      make the keypad send digits
;; vb      flash     emit visual bell
;; mb      blink     start blink
;; md      bold      start bold
;; me      sgr0      turn off bold, blink and underline
;; so      smso      start standout (reverse video)
;; se      rmso      stop standout
;; us      smul      start underline
;; ue      rmul      stop underline

;; https://unix.stackexchange.com/questions/119/colors-in-man-pages
;; https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
;; https://www.gnu.org/software/termutils/manual/termcap-1.3/html_mono/termcap.html
