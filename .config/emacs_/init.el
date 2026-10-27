;; -*- lexical-binding: t -*-

;;; about lexical-binding

;; (info "(elisp)Lexical Binding")
;; (info "(emacs)Specifying File Variables")

;;; reference config

;; https://github.com/purcell/emacs.d
;; https://github.com/protesilaos/dotfiles/blob/master/emacs/.emacs.d/prot-emacs.org

;;; elisp debug

;; (error "Done")
;; https://stackoverflow.com/questions/25393418/stop-execution-of-emacs

;;; package 0

;; http://xahlee.info/emacs/emacs/emacs_installing_packages.html
;; http://xahlee.info/emacs/emacs/elisp_library_system.html
;; http://xahlee.info/emacs/emacs/elisp_feature_name.html

(add-to-list 'load-path (concat user-emacs-directory "lisp"))

;; (locate-library "test")
;; (load "test")
(require 'test)

;;; package 1

(require 'package_)

;;; package 2

(require 'nofrils_)
;; (require 'standard-themes_)

(require 'emacs_)
(require 'keymap_)

(require 'evil_)
(require 'info_)
(require 'org_)
(require 'magit_)

(require 'vertico_)
(require 'orderless_)
(require 'marginalia_)
