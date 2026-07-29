;; -*- lexical-binding: t -*-

;;; misc

(setq disabled-command-function nil)
;; emacs does not allow "M-x scroll-left" by default, remove all these restrictions

(setq custom-safe-themes t)
;; stop warning me "Loading a theme can run Lisp code.  Really load?"

(setq custom-file (concat user-emacs-directory "custom.el"))
;; disable "M-x customize"

(setq find-function-C-source-directory "~/sync_git/emacs/src")
;; git clone --filter=blob:none https://github.com/aidancz/emacs
;; https://emacs.stackexchange.com/questions/62764/how-to-see-the-source-code-of-a-built-in-function

(fset 'yes-or-no-p 'y-or-n-p)
;; (setq hello (lambda () (message "hello")))
;; (hello) ; *** Eval error ***  Symbol’s function definition is void: hello
;; http://xahlee.info/emacs/emacs/lisp1_vs_lisp2.html
;; http://xahlee.info/emacs/emacs/elisp_symbol.html
;; (funcall hello) ; "hello"
;; (symbol-value 'hello) ; #f(lambda () [t] (message "hello"))
;; (symbol-function 'hello) ; nil
;; (symbol-value 'message) ; *** Eval error ***  Symbol’s value as variable is void: message
;; (symbol-function 'message) ; #<subr message>
;; (funcall (symbol-value 'hello)) ; "hello"
;;
;; (setq x 1) ; is actually (set 'x 1)
;; https://emacs.stackexchange.com/questions/9605/setq-with-lambda-argument-sets-symbols-variable-cell-or-function-cell
;; (fset 'x (lambda () (message "hello")))
;; (x) ; "hello"
;; (info "(elisp)Function Cells")

;;; appearance

;;;; surround

;; (setq display-line-numbers-type 'relative)
;; (setq display-line-numbers-current-absolute nil)
;; (global-display-line-numbers-mode 1)

(line-number-mode 1)

(setq column-number-indicator-zero-based nil)
(column-number-mode 1)

(setq echo-keystrokes 0.001)

(setq completions-format 'one-column)

;;;; buffer

(custom-theme-set-faces 'nofrils
  `(whitespace-trailing ((t . (:inherit nofrils_red_bg))))
)
(setq whitespace-style '(face trailing))
(setq whitespace-display-mappings '())
(global-whitespace-mode 1)
;; http://xahlee.info/emacs/emacs/emacs_init_whitespace_mode.html

(setq-default truncate-lines nil)
;; http://xahlee.info/emacs/emacs/emacs_line_no_wrap.html

(setq-default word-wrap nil)
;; http://xahlee.info/emacs/emacs/emacs_toggle-word-wrap.html

(blink-cursor-mode 0)

(custom-theme-set-faces 'nofrils
  `(show-paren-match ((t . (:inherit nofrils_blue_bg))))
  `(show-paren-mismatch ((t . (:inherit nofrils_red_bg))))
  `(show-paren-match-expression ((t . (:inherit nofrils_blue_bg))))
)
(setq show-paren-style 'parenthesis)
(setq show-paren-delay 0)
(show-paren-mode 1)

;;; scroll

;; emacs scroll down -> vi scroll up
;; emacs scroll up -> vi scroll down
;; emacs scroll buffer, vi scroll window

;;;; vertical

;; (info "(emacs)Auto Scrolling")

(setq scroll-margin 0)

(setq scroll-conservatively most-positive-fixnum)
;; (info "(efaq)Scrolling only one line")

;; (setq scroll-step 0)

;; (setq-default scroll-up-aggressively 1.0)
;; (setq-default scroll-down-aggressively 1.0)

(setq next-screen-context-lines 0)
(setq scroll-preserve-screen-position t)

;;;; horizontal

;; (info "(emacs)Horizontal Scrolling")

(setq auto-hscroll-mode t)

(setq hscroll-margin 0)

;; (setq hscroll-conservatively most-positive-fixnum)
;; "hscroll-conservatively" doesn't exist in emacs

(setq hscroll-step 1)

;;; search

;; (info "(emacs)Search Customizations")

(setq search-default-mode nil)

(setq isearch-lazy-highlight t)
(setq lazy-highlight-initial-delay 0)
(setq lazy-highlight-no-delay-length 1)

(setq isearch-lazy-count t)

;;; copy & paste

(setq select-enable-clipboard t)
(setq select-enable-primary t)

;;; undo

;; http://xahlee.info/emacs/emacs/emacs_best_redo_mode.html

(setq undo-no-redo t)

;;; indent

;; http://xahlee.info/emacs/emacs/emacs_tabs_space_indentation_setup.html

(setq-default tab-width 8)
(setq-default indent-tabs-mode t)
(setq-default tab-always-indent nil)

(electric-indent-mode 1)

;;; file operation

;;;; save

(setq save-silently t)

(setq mode-require-final-newline t)

(setq auto-save-default nil) ; #<filename>#

(setq auto-save-visited-interval 1)
(auto-save-visited-mode 1)

;;;; lock

(setq create-lockfiles nil) ; .#<filename>

;;;; backup

(setq make-backup-files nil) ; <filename>~

;;;; revert

(global-auto-revert-mode 1)

(provide '_emacs)
