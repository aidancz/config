;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ appearance
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode 0)

;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ copy & paste
(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)

;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ extra files
(setq make-backup-files nil)
;; stop creating <filename>~
(setq auto-save-default nil)
;; stop creating #<filename>#
(setq create-lockfiles nil)
;; stop creating .#<filename>
(setq auto-save-list-file-prefix nil)
;; stop creating auto-save-list dir
(setq url-configuration-directory
(concat (getenv "XDG_CACHE_HOME") "/emacs/url")
)
;; move url dir
