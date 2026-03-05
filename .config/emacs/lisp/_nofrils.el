;; -*- lexical-binding: t -*-

;; method1:

;; (load-theme 'nofrils t nil)
;; (setq custom--inhibit-theme-enable nil)

;; method2:

(load-theme 'nofrils t t)
(add-hook 'after-init-hook (lambda () (enable-theme 'nofrils)))

;; https://emacs.stackexchange.com/questions/48365/custom-theme-set-faces-does-not-work-in-emacs-27

(provide '_nofrils)
