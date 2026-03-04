;; -*- lexical-binding: t -*-

;; http://xahlee.info/emacs/emacs/emacs_create_theme.html
;; learn from built-in themes: emacs/etc/themes
;; http://xahlee.info/emacs/emacs/elisp_face.html

(deftheme nofrils)

(let
  (
    ;; (color0 "#000000")
    ;; (color1 "#ff0000")
    ;; (color2 "#00ff00")
    ;; (color3 "#ffff00")
    ;; (color4 "#0000ff")
    ;; (color5 "#ff00ff")
    ;; (color6 "#00ffff")
    ;; (color7 "#ffffff")

    (color0 (x-get-resource "color0" ""))
    (color1 (x-get-resource "color1" ""))
    (color2 (x-get-resource "color2" ""))
    (color3 (x-get-resource "color3" ""))
    (color4 (x-get-resource "color4" ""))
    (color5 (x-get-resource "color5" ""))
    (color6 (x-get-resource "color6" ""))
    (color7 (x-get-resource "color7" ""))
  )

  (dolist (face (face-list))
    (face-spec-reset-face face)
    (put face 'face-override-spec '())
    (put face 'face-defface-spec '())
    (put face 'customized-face '())
    (put face 'saved-face '())
  )
  ;; clear faces

  (defface nofrils_black   `((t . (:foreground ,color0))) "" :group 'nofrils)
  (defface nofrils_red     `((t . (:foreground ,color1))) "" :group 'nofrils)
  (defface nofrils_green   `((t . (:foreground ,color2))) "" :group 'nofrils)
  (defface nofrils_yellow  `((t . (:foreground ,color3))) "" :group 'nofrils)
  (defface nofrils_blue    `((t . (:foreground ,color4))) "" :group 'nofrils)
  (defface nofrils_magenta `((t . (:foreground ,color5))) "" :group 'nofrils)
  (defface nofrils_cyan    `((t . (:foreground ,color6))) "" :group 'nofrils)
  (defface nofrils_white   `((t . (:foreground ,color7))) "" :group 'nofrils)

  (defface nofrils_black_bg   `((t . (:background ,color0 :foreground ,color7))) "" :group 'nofrils)
  (defface nofrils_red_bg     `((t . (:background ,color1 :foreground ,color0))) "" :group 'nofrils)
  (defface nofrils_green_bg   `((t . (:background ,color2 :foreground ,color0))) "" :group 'nofrils)
  (defface nofrils_yellow_bg  `((t . (:background ,color3 :foreground ,color0))) "" :group 'nofrils)
  (defface nofrils_blue_bg    `((t . (:background ,color4 :foreground ,color0))) "" :group 'nofrils)
  (defface nofrils_magenta_bg `((t . (:background ,color5 :foreground ,color0))) "" :group 'nofrils)
  (defface nofrils_cyan_bg    `((t . (:background ,color6 :foreground ,color0))) "" :group 'nofrils)
  (defface nofrils_white_bg   `((t . (:background ,color7 :foreground ,color0))) "" :group 'nofrils)

  (defface nofrils_reverse `((t . (:inverse-video t))) "" :group 'nofrils)

  ;; NOTE: i want to disable defface's spec since here

  ;; version 1:
  ;; (fset 'defface
  ;;   (lambda (face spec doc &rest args)
  ;;     (apply 'defface face '() doc args)))

  ;; version 2:
  ;; (fset 'custom-declare-face
  ;;   (lambda (face spec doc &rest args)
  ;;     (apply 'custom-declare-face face '() doc args)))

  ;; version 3:
  ;; (defmacro defface (face spec doc &rest args)
  ;;   (declare (doc-string 3) (indent defun))
  ;;   (nconc (list 'custom-declare-face (list 'quote face) '() doc) args))

  ;; version 4:
  ;; (advice-add 'defface :around
  ;;   (lambda (orig face spec doc &rest args)
  ;;     (apply orig face '() doc args)))

  ;; version 5:
  (advice-add 'custom-declare-face :around
    (lambda (orig face spec doc &rest args)
      (apply orig face '() doc args)))

  (custom-theme-set-faces 'nofrils

    ;; (info "(emacs)Standard Faces")

    `(default                ((t . (:background ,color0 :foreground ,color7))))
    `(bold                   ((t . ())))
    `(italic                 ((t . ())))
    `(bold-italic            ((t . ())))
    `(underline              ((t . ())))
    `(fixed-pitch            ((t . ())))
    `(fixed-pitch-serif      ((t . ())))
    `(variable-pitch         ((t . ())))
    `(variable-pitch-text    ((t . ())))
    `(shadow                 ((t . (:inherit nofrils_blue))))

    `(highlight              ((t . (:inherit nofrils_blue_bg))))
    `(isearch                ((t . ())))
    `(query-replace          ((t . ())))
    `(lazy-highlight         ((t . ())))
    `(region                 ((t . (:inherit nofrils_blue_bg))))
    `(secondary-selection    ((t . ())))
    `(trailing-whitespace    ((t . ())))
    `(escape-glyph           ((t . ())))
    `(homoglyph              ((t . ())))
    `(nobreak-space          ((t . ())))
    `(nobreak-hyphen         ((t . ())))

    `(mode-line              ((t . ())))
    `(mode-line-active       ((t . ())))
    `(mode-line-inactive     ((t . ())))
    `(mode-line-highlight    ((t . ())))
    `(mode-line-buffer-id    ((t . ())))
    `(header-line            ((t . (:inherit nofrils_blue))))
    `(header-line-highlight  ((t . ())))
    `(tab-line               ((t . ())))
    `(vertical-border        ((t . ())))
    `(minibuffer-prompt      ((t . ())))
    `(fringe                 ((t . ())))
    `(cursor                 ((t . (:background ,color7))))
    `(tooltip                ((t . ())))
    `(mouse                  ((t . ())))

    `(scroll-bar             ((t . ())))
    `(tool-bar               ((t . ())))
    `(tab-bar                ((t . ())))
    `(menu                   ((t . ())))
    `(tty-menu-enabled-face  ((t . ())))
    `(tty-menu-disabled-face ((t . ())))
    `(tty-menu-selected-face ((t . ())))

    ;; (info "(elisp)Basic Faces")
    ;; generated via "comm -23 a.txt b.txt"

    `(border                 ((t . ())))
    `(child-frame-border     ((t . ())))
    `(error                  ((t . (:inherit nofrils_red))))
    `(link                   ((t . (:inherit nofrils_magenta))))
    `(link-visited           ((t . (:inherit nofrils_magenta_bg))))
    `(match                  ((t . ())))
    `(success                ((t . (:inherit nofrils_green))))
    `(warning                ((t . (:inherit nofrils_yellow))))
    `(window-divider         ((t . ())))

    ;; font lock mode

    `(font-lock-comment-face           ((t . (:inherit nofrils_blue))))
    `(font-lock-comment-delimiter-face ((t . (:inherit nofrils_blue))))

  )
)

(provide-theme 'nofrils)
