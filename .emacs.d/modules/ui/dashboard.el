
(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))

;; use-package with Elpaca:
(use-package dashboard
  :ensure t
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook))

(setq dashboard-center-content t)

(setq dashboard-startup-banner 'logo)

(setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
			(projects  . 5)))
			;;(config    . 5))) TODO make a shortcut to config ./.emacs.d/ dir maybe

(setq dashboard-item-shortcuts '((recents   . "r")
                                 (bookmarks . "b")
                                 (projects  . "p")))

(setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal

(setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package

(setq dashboard-set-heading-icons t)

(setq dashboard-set-file-icons t)
 
