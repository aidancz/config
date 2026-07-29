;; -*- lexical-binding: t -*-

;; https://www.reddit.com/r/emacs/comments/vahsao/orgmode_use_capitalized_property_keywords_or/

(custom-theme-set-faces 'nofrils
  `(org-level-1 ((t . (:inherit nofrils_red))))
  `(org-level-2 ((t . (:inherit nofrils_yellow))))
  `(org-level-3 ((t . (:inherit nofrils_green))))
  `(org-level-4 ((t . (:inherit nofrils_cyan))))
  `(org-level-5 ((t . (:inherit nofrils_red))))
  `(org-level-6 ((t . (:inherit nofrils_yellow))))
  `(org-level-7 ((t . (:inherit nofrils_green))))
  `(org-level-8 ((t . (:inherit nofrils_cyan))))

  `(org-block-begin-line ((t . (:inherit nofrils_magenta))))
  `(org-block-end-line ((t . (:inherit nofrils_magenta))))
)

(setq org-startup-folded 'content)
(setq org-startup-truncated nil)
(setq org-ellipsis "●")
(setq org-property-format "%s %s")
(setq org-link-descriptive nil)

(setq org-src-preserve-indentation t)
(setq org-src-window-setup 'reorganize-frame)

(setq org-startup-with-inline-images t)
(setq org-image-actual-width '(0.25))
;; (setq org-image-actual-height '(0.25)) ; does not exist
(setq org-cycle-inline-images-display nil) ; only affects the command org-cycle (bound to TAB by default)

(setq org-startup-with-latex-preview t)
(setq org-preview-latex-default-process 'dvipng)
;; (setq org-preview-latex-process-alist '())

(provide '_org)
