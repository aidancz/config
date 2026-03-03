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

  (custom-theme-set-faces 'nofrils

    ;; (info "(elisp)Basic Faces")

    `(default ((t . (:background ,color0 :foreground ,color7))))
    `(cursor ((t . (:background ,color7))))

    `(region ((t . (:inherit nofrils_reverse))))
    `(link ((t . (:inherit nofrils_cyan))))
    `(link-visited ((t . (:inherit nofrils_magenta))))
    ;; `(highlight ((t . (:inherit nofrils_reverse))))
    `(highlight ((t . (:inverse-video t))))
  )
)

(provide-theme 'nofrils)
