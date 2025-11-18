;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;; === UI Enhancements ===
(package! doom-themes)
(package! dracula-theme)
(package! all-the-icons)
(package! dashboard)

;; === Writing & Focus ===
(package! writeroom-mode)
(package! focus)
(package! olivetti)

;; === Org-mode Enhancements ===
(package! org-modern)
(package! org-roam)
(package! org-roam-ui)
(package! org-noter)
(package! org-tanglesync)
(package! org-pandoc-import
  :recipe (:host github :repo "tecosaur/org-pandoc-import"))

;; === LaTeX & PDF Tools ===
(package! auctex)
(package! auctex-latexmk)
(package! cdlatex)
(package! citar)
(package! citar-org-roam)
(package! pdf-tools)

;; === Spell Checking & Grammar ===
(package! flyspell-correct)
(package! flyspell-correct-ivy)
(package! languagetool)

;; === Markdown & Export Tools ===
(package! markdown-mode)
(package! grip-mode)

;; === File Search & Navigation ===
(package! consult)
(package! consult-org-roam)
(package! embark)
(package! marginalia)

;; === Version Control ===

;; === Completion ===
