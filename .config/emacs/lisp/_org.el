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
)

(setq org-startup-folded 'content)

(setq org-ellipsis "●")

(setq org-link-descriptive nil)

(setq org-adapt-indentation t)
;; (setq org-adapt-indentation t)
;; * level 1
;;   * level 2

;; (setq org-list-indent-offset 6)
;; - fruit
;;         - apple
;;         - banana
;; 8 - 2 = 6

(provide '_org)
