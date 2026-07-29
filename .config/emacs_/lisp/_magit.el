;; -*- lexical-binding: t -*-

(unless (package-installed-p 'magit)
  (package-install 'magit))

;; (custom-theme-set-faces 'nofrils
;;   `(org-level-1 ((t . (:inherit nofrils_red))))
;; )

(provide '_magit)
