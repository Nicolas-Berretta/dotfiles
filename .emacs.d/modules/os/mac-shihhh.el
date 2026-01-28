;;; -*- lexical-binding = t; -*-

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
