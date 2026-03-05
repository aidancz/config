;; -*- lexical-binding: t -*-

;;; about lexical-binding

;; (info "(elisp)Lexical Binding")
;; (info "(emacs)Specifying File Variables")

;;; reference config

;; https://github.com/purcell/emacs.d
;; https://github.com/protesilaos/dotfiles/blob/master/emacs/.emacs.d/prot-emacs.org

;;; elisp debug

;; (top-level)
;; https://emacs.stackexchange.com/questions/75179/how-to-stop-evaluating-within-emacs-for-debugging-purposes

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

(require '_package)

;;; package 2

(require '_nofrils)
;; (require '_standard-themes)

(require '_emacs)
(require '_evil)
(require '_org)
