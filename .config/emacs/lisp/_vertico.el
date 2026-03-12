;; -*- lexical-binding: t -*-

(unless (package-installed-p 'vertico)
  (package-install 'vertico))

(custom-theme-set-faces 'nofrils
  `(vertico-current ((t . (:inherit nofrils_reverse))))
)

(setq vertico-scroll-margin 0)
(setq vertico-count 10)
(setq vertico-resize 'grow-only)
(setq vertico-cycle nil)

(vertico-mode)

(provide '_vertico)
