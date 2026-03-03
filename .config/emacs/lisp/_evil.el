;; https://evil.readthedocs.io/en/latest/index.html
;; https://github.com/noctuid/evil-guide

(ensure 'evil)

(setq evil-default-state 'emacs)
;; http://bling.github.io/blog/2015/01/06/emacs-as-my-leader-1-year-later/

(setq evil-normal-state-modes '(
  fundamental-mode
  text-mode
  prog-mode
))
(setq evil-insert-state-modes '())
(setq evil-visual-state-modes '())
(setq evil-replace-state-modes '())
(setq evil-operator-state-modes '())
(setq evil-motion-state-modes '())
(setq evil-emacs-state-modes '(
  special-mode
))
;; (info "(elisp)Basic Major Modes")

(setq evil-want-C-u-delete t)
(setq evil-want-C-u-scroll t)
(setq evil-want-Y-yank-to-eol t)
(setq evil-disable-insert-state-bindings t)

(setq evil-search-module 'evil-search)

(setq evil-repeat-move-cursor nil)
(setq evil-move-cursor-back nil)
(setq evil-move-beyond-eol t)
(setq evil-cross-lines t)

(setq evil-normal-state-cursor t)
(setq evil-insert-state-cursor t)
(setq evil-visual-state-cursor t)
(setq evil-replace-state-cursor t)
(setq evil-operator-state-cursor t)
(setq evil-motion-state-cursor t)
(setq evil-emacs-state-cursor t)

(setq evil-split-window-below t)
(setq evil-vsplit-window-right t)

(setq evil-highlight-closing-paren-at-point-states '())

(setq evil-undo-system 'undo-redo)

(setq evil-want-change-word-to-end nil)
(setq evil-want-minibuffer nil)
(setq evil-want-integration nil)
(setq evil-want-keybinding nil)

(require 'evil)
(evil-mode 1)

(provide '_evil)
