;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; To install packages from MELPA, ELPA, or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, specify a `:recipe`:
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package is located in a subdirectory of the repo, specify `:files`:
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;   :files ("some-file.el" "src/lisp/*.el")))

;; To disable a package included with Doom:
;; (package! builtin-package :disable t)

;; Override the recipe of a built-in package:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch` to install from a particular branch or tag:
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin` to specify a particular commit to install:
;; (package! builtin-package :pin "1a2b3c4d5e")

;; Unpin packages to allow updates:
;; (unpin! pinned-package)
;; (unpin! pinned-package another-pinned-package)
;; (unpin! t)

;; Package declarations
(package! doom-themes)               ; Themes for Doom Emacs
(package! dracula-theme)             ; Dracula theme
(package! all-the-icons)             ; Icons for various modes
(package! pdf-tools)                 ; PDF tools for Emacs
(package! flyspell-correct)          ; Correction tool for Flyspell
(package! flyspell-correct-ivy)      ; Ivy interface for Flyspell correction
(package! org-tanglesync)            ; Synchronization for Org Babel tangling
(package! company)                   ; Completion backend
(package! dashboard)                 ; Dashboard for Emacs
(package! visual-fill-column)
(package! pandoc-mode)
(package! writegood-mode)
(package! focus)
(package! org-bullets)
(package! org-modern)
