;; stop creating <filename>~
(setq make-backup-files nil)
;; stop creating #<filename>#
(setq auto-save-default nil)
;; stop creating .#<filename>
(setq create-lockfiles nil)
;; stop creating auto-save-list dir
(setq auto-save-list-file-prefix nil)
;; move url dir
(setq url-configuration-directory "~/.cache/emacs/url")






(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "CodeNewRoman Nerd Font" :foundry "CNR " :slant normal :weight normal :height 150 :width normal)))))
