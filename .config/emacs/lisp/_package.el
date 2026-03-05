;; -*- lexical-binding: t -*-

;; http://xahlee.info/emacs/emacs/emacs_package_system.html

;; emacs has a built-in package manager called "package.el"
;; it installs packages from "elpa" (emacs lisp package archive)

(require 'package)

(setq package-archives '(
	("gnu"             . "https://elpa.gnu.org/packages/")
;;	("gnu-devel"       . "https://elpa.gnu.org/devel/")
	("nongnu"          . "https://elpa.nongnu.org/nongnu/")
;;	("nongnu-devel"    . "https://elpa.nongnu.org/nongnu-devel/")
	("melpa"           . "https://melpa.org/packages/")
;;	("melpa-stable"    . "https://stable.melpa.org/packages/")

;;	("gnu-cn"          . "http://1.15.88.122/gnu/")
;;	("nongnu-cn"       . "http://1.15.88.122/nongnu/")
;;	("melpa-cn"        . "http://1.15.88.122/melpa/")
;;	("melpa-stable-cn" . "http://1.15.88.122/stable-melpa/")
;;	https://elpamirror.emacs-china.org/
))
(setq package-archive-priorities '())
(setq package-install-upgrade-built-in nil)
(setq package-pinned-packages '())
(setq package-load-list '(all))

;; M-x package-refresh-contents
;; M-x package-install (from elpa)
;; M-x package-vc-install (from github)
;; M-x package-vc-install-from-checkout (from local)
;; M-x package-upgrade
;; M-x package-delete

(defun ensure (package)
  "ensure the package is installed on disk"
  (unless (package-installed-p package)
    (package-install package)))

(provide '_package)
