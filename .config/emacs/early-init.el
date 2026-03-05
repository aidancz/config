;; -*- lexical-binding: t -*-

;; (setq inhibit-x-resources t) ; this seems also (setq inhibit-startup-screen t)
(setq inhibit-startup-screen t)

;; (setq inhibit-startup-echo-area-message "aidan")
;; i can't believe startup.el literally just search the text "(setq inhibit-startup-echo-area-message ...)" in init.el
;; shadow the function instead:
(defun display-startup-echo-area-message () nil)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(fringe-mode '(0 . 0))

(set-face-attribute 'default nil :background "black" :foreground "white")

(add-to-list 'default-frame-alist
             '(font . "monospace-15"))
;; (info "(emacs)Fonts")

(setq package-enable-at-startup t)
