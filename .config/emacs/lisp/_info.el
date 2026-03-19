;; -*- lexical-binding: t -*-

;; https://emacs.stackexchange.com/questions/81904/how-to-replace-info-with-emacs
;; https://emacs.stackexchange.com/questions/68314/how-to-show-an-info-mode-manual-entirely-on-one-page
;; https://emacsnotes.wordpress.com/2023/09/11/view-info-texi-org-and-md-files-as-info-manual/

(unless (package-installed-p 'info-plus)
  (package-vc-install "https://github.com/emacsmirror/info-plus"))

;; (eval-after-load "info" '(require 'info+))

(custom-theme-set-faces 'nofrils
  `(Info-quoted       ((t . (:inherit nofrils_blue))))
  `(info-header-node  ((t . (:inherit nofrils_blue))))
  `(info-header-xref  ((t . (:inherit nofrils_cyan))))
  `(info-index-match  ((t . (:inherit nofrils_blue_bg))))
  `(info-menu-header  ((t . (:inherit nofrils_magenta))))
  `(info-menu-star    ((t . (:inherit nofrils_magenta))))
  `(info-node         ((t . (:inherit nofrils_red_bg)))) ; this face seems unused except for inheritance by info-header-node
  `(info-title-1      ((t . (:inherit nofrils_red))))
  `(info-title-2      ((t . (:inherit nofrils_yellow))))
  `(info-title-3      ((t . (:inherit nofrils_green))))
  `(info-title-4      ((t . (:inherit nofrils_cyan))))
  `(info-xref         ((t . (:inherit nofrils_cyan))))
  `(info-xref-visited ((t . (:inherit nofrils_cyan_bg))))
)

(setq Info-hide-note-references t)
(setq Info-use-header-line t)

;; (add-hook 'Info-mode-hook (lambda () (setq scroll-conservatively 0))) ; bad, change scroll-conservatively globally
;; (add-hook 'Info-mode-hook (lambda () (setq-local scroll-conservatively 0)))
;; https://lists.gnu.org/archive/html/bug-gnu-emacs/2026-03/msg00277.html

;; (info "(info)Top") lists these commands:

;; Info-next
;; Info-prev
;; Info-scroll-up
;; Info-scroll-down
;; beginning-of-buffer
;; end-of-buffer
;; Info-summary
;; Info-forward-node
;; Info-backward-node
;; Info-menu
;; Info-up
;; Info-next-reference
;; Info-prev-reference
;; Info-follow-nearest-node
;; Info-follow-reference
;; Info-history-back
;; Info-history-forward
;; Info-history
;; Info-directory
;; Info-top-node
;; Info-search
;; Info-index
;; Info-index-next
;; Info-virtual-index
;; Info-apropos
;; Info-goto-node
;; Info-nth-menu-item
;; clone-buffer
;; info
;; info-display-manual

;; (keymap-set Info-mode-map "j" 'Info-next-reference)
;; (keymap-set Info-mode-map "k" 'Info-prev-reference)
;; (keymap-set Info-mode-map "l" 'Info-history-forward)
;; (keymap-set Info-mode-map "h" 'Info-history)

;; (keymap-set Info-mode-map "f" 'Info-scroll-up)
;; (keymap-set Info-mode-map "d" 'Info-scroll-down)
;; (keymap-set Info-mode-map "g" 'end-of-buffer)
;; (keymap-set Info-mode-map "s" 'beginning-of-buffer)

;; (keymap-set Info-mode-map "m" 'Info-menu)

(provide '_info)
