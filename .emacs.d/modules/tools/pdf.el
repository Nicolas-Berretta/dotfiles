;;; -*- lexical-binding: t; -*-

;; https://codeberg.org/divyaranjan/emacs-reader
;; NOTE: this package has mupdf as dependency
;; brew install mupdf
(add-to-list 'load-path "~/.emacs.d/elpaca/repos/emacs-reader")

(use-package reader
  :ensure (:host codeberg :repo "divyaranjan/emacs-reader"
		 :files ("*.el" "render-core.dylib")
		 :pre-build ("make" "all")))
