;; Hide ugly ahh initial UI stuff
(tool-bar-mode 0)       ;; Hide the menu bar
(menu-bar-mode 0)       ;; Hide the tool bar
(scroll-bar-mode 0)     ;; Hide the scrollbar
(column-number-mode 1)
(show-paren-mode 1)
(electric-pair-mode t) ;; Automatic parens pairing

;; Move customization settings out of init.el
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;;Load my tweaks on appearence
(setq appearence-file "~/.emacs.d/appearence.el")
(when (file-exists-p appearence-file)
  (load appearence-file))

;;Load my personal keybindings
(setq keybinds-file "~/.emacs.d/keybinds.el")
(when (file-exists-p keybinds-file)
  (load keybinds-file))

;; Backup files
(setq backup-directory-alist `(("." . , (expand-file-name "tmp/backups/" user-emacs-directory))))

;; Autosave files
;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

(setq uniquify-buffer-name-style 'forward
      ;; no beeping or blinking please
      ring-bell-function #'ignore
      visible-bell nil)

;; Use require for built in packages
(require 'project)
(setq project-mode-line t)

;;; Elpaca package manager
;; https://github.com/progfolio/elpaca
(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))

;; Load all my modules/../ files 
;; directory-files-recursively returns a list of the files that recurecursively finds by going into the dir recursively per se a grosso modo
;; then, each file is evaluated hilando fino
(setq files (directory-files-recursively "~/.emacs.d/modules/" "\\.el\\'" nil t))
  (dolist (file files)
    (load-file file))
