;; File for custom vars edits

;; Move customization settings out of init.el
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))
