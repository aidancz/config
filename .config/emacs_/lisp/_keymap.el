;; -*- lexical-binding: t -*-

(keymap-global-set "<f1>"
  (lambda ()
    (interactive)
    (if (one-window-p)
      (save-buffers-kill-terminal)
      (delete-window))))

(keymap-global-set "<f2> <f1>" 'save-buffers-kill-terminal)

(provide '_keymap)
