;; -*- lexical-binding: t -*-

(unless (package-installed-p 'marginalia)
  (package-install 'marginalia))

;; (custom-theme-set-faces 'nofrils
;;   `(vertico-current ((t . (:inherit nofrils_reverse))))
;; )

(require 'marginalia)
(keymap-set minibuffer-local-map "M-a" 'marginalia-cycle)
(marginalia-mode)

(provide '_marginalia)
