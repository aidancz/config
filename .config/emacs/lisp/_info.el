;; -*- lexical-binding: t -*-

;; https://emacs.stackexchange.com/questions/81904/how-to-replace-info-with-emacs
;; https://emacs.stackexchange.com/questions/68314/how-to-show-an-info-mode-manual-entirely-on-one-page
;; https://emacsnotes.wordpress.com/2023/09/11/view-info-texi-org-and-md-files-as-info-manual/

(unless (package-installed-p 'info-plus)
  (package-vc-install "https://github.com/emacsmirror/info-plus"))

(eval-after-load "info" '(require 'info+))

(custom-theme-set-faces 'nofrils
  `(info-menu-header ((t . (:inherit nofrils_magenta))))
  `(info-menu-star ((t . (:inherit nofrils_magenta))))
  `(info-title-1 ((t . (:inherit nofrils_red))))
  `(info-title-2 ((t . (:inherit nofrils_yellow))))
  `(info-title-3 ((t . (:inherit nofrils_green))))
  `(info-title-4 ((t . (:inherit nofrils_cyan))))
  `(info-xref ((t . (:inherit nofrils_cyan))))
  `(info-xref-visited ((t . (:inherit nofrils_cyan_bg))))

  `(Info-quoted ((t . (:inherit nofrils_yellow_bg))))
  `(info-header-node ((t . (:inherit nofrils_blue_bg))))
  `(info-header-xref ((t . (:inherit nofrils_green_bg))))
  `(info-index-match ((t . (:inherit nofrils_white_bg))))
  `(info-node ((t . (:inherit nofrils_red_bg))))
)

(setq Info-hide-note-references t)
(setq Info-use-header-line t)

(add-hook 'Info-mode-hook (lambda () (setq scroll-conservatively 0)))

(keymap-set Info-mode-map "j" 'Info-next)
(keymap-set Info-mode-map "k" 'Info-prev)
(keymap-set Info-mode-map "l"
  (lambda ()
    (interactive)
    (Info-goto-node
      (Info-extract-menu-counting 1))))
(keymap-set Info-mode-map "h" 'Info-up)

(keymap-set Info-mode-map "f" 'Info-scroll-up)
(keymap-set Info-mode-map "d" 'Info-scroll-down)

(keymap-set Info-mode-map "m" 'Info-menu)
;; (keymap-set Info-mode-map "" 'Info-next-reference)
;; (keymap-set Info-mode-map "" 'Info-prev-reference)

(provide '_info)
