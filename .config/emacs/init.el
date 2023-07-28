;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ appearance
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode 0)

;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ copy & paste
(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)

;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ orgmode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ extra files
(setq make-backup-files nil)
;; stop creating <filename>~
(setq auto-save-default nil)
;; stop creating #<filename>#
(setq create-lockfiles nil)
;; stop creating .#<filename>
(setq auto-save-list-file-prefix nil)
;; stop creating auto-save-list dir
(setq url-configuration-directory "~/.cache/emacs/url")
;; move url dir
