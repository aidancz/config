;; -*- lexical-binding: t -*-

(unless (package-installed-p 'orderless)
  (package-install 'orderless))

(custom-theme-set-faces 'nofrils
  `(orderless-match-face-0 ((t . (:inherit nofrils_blue))))
  `(orderless-match-face-1 ((t . (:inherit nofrils_blue))))
  `(orderless-match-face-2 ((t . (:inherit nofrils_blue))))
  `(orderless-match-face-3 ((t . (:inherit nofrils_blue))))
)

(require 'orderless)
(setq completion-styles '(orderless basic))
(setq completion-category-overrides '((file (styles partial-completion))))
(setq completion-pcm-leading-wildcard t)

(provide '_orderless)
