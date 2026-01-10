;; Hide ugly ahh initial UI stuff
(tool-bar-mode 0)       ;; Hide the menu bar
(menu-bar-mode 0)       ;; Hide the tool bar
(scroll-bar-mode 0)     ;; Hide the scrollbar
(column-number-mode 1)
(show-paren-mode 1)
(electric-pair-mode t) ;; Automatic parens pairing

;; Temp dark mode TODO remove
(invert-face 'default)


;; Backup files
(setq backup-directory-alist `(("." . , (expand-file-name "tmp/backups/" user-emacs-directory))))

;; Autosave files
;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))


;; MAC SPECIFIC STUFF------------- below
;; Sane trackpad/mouse scroll settings. Also disables smooth scrolling because
;; it's disturbingly clunky and slow without something like
;; jdtsmith/ultra-scroll-mac.
(setq mac-redisplay-dont-reset-vscroll t
      mac-mouse-wheel-smooth-scroll nil)

;; Sets `ns-transparent-titlebar' and `ns-appearance' frame parameters so window
;; borders will match the enabled theme.
(and (or (daemonp)
         (display-graphic-p))
     (require 'ns-auto-titlebar nil t)
     (ns-auto-titlebar-mode +1))

(setq delete-by-moving-to-trash (not noninteractive))
;; MAC SPECIFIC STUFF------------- above

(setq uniquify-buffer-name-style 'forward
      ;; no beeping or blinking please
      ring-bell-function #'ignore
      visible-bell nil)
