;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; ------------------------------
;; User Information
;; ------------------------------
(setq user-full-name "Robert Alicea"
      user-mail-address "train@idoneitatemlife.com")

;; ------------------------------
;; Fonts and Appearance
;; ------------------------------
(setq my-font "JetBrains Mono"  ;; Exact name as found in fc-list
      doom-font (font-spec :family my-font :size 20)
      doom-variable-pitch-font (font-spec :family "Sans" :size 20)
      doom-big-font (font-spec :family my-font :size 24)
      doom-theme 'doom-monokai-pro
      display-line-numbers-type t
      doom-modeline-icon t
      doom-modeline-height 25
      inhibit-startup-screen t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Set transparency
(set-frame-parameter (selected-frame) 'alpha '(98 98))
(add-to-list 'default-frame-alist '(alpha 98 98))

;; Maximize the frame on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Set default text scale after initialization
(defun my/set-default-text-scale ()
  "Set the default text scale."
  (text-scale-set 0))
(add-hook 'after-init-hook #'my/set-default-text-scale)

;; ------------------------------
;; Org Mode Configuration
;; ------------------------------
(use-package! org
  :defer t
  :hook ((org-mode . org-bullets-mode)
         (org-mode . flyspell-mode)
         (org-mode . visual-fill-column-mode)
         (org-mode . my/set-default-text-scale))
  :config
  (setq org-directory "~/org/"
        org-startup-indented t
        org-hide-leading-stars t
        org-hide-emphasis-markers t
        org-table-automatic-realign t
        org-table-automatic-recalculate t
        org-export-babel-evaluate t
        org-confirm-babel-evaluate nil
        org-bullets-bullet-list '("◉" "○" "●" "◆" "▶"))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)))

  (add-hook 'before-save-hook 'org-table-recalculate-buffer-tables))

;; ------------------------------
;; YASnippet Configuration
;; ------------------------------
(use-package! yasnippet
  :config
  (setq yas-snippet-dirs '("/home/rob/.config/doom/snippets/"))
  (yas-global-mode 1))

;; ------------------------------
;; Writing and Focus Tools
;; ------------------------------
(use-package! visual-fill-column
  :hook (org-mode . visual-fill-column-mode)
  :config
  (setq visual-fill-column-width 80
        visual-fill-column-center-text t))

;; ------------------------------
;; PDF Tools Configuration
;; ------------------------------
(use-package! pdf-tools
  :defer t
  :config
  (pdf-tools-install)
  (setq pdf-view-midnight-colors '("#ffffff" . "#000000")
        pdf-view-resize-factor 1.1
        pdf-view-display-size 'fit-page)
  :hook (pdf-view-mode . (lambda () (display-line-numbers-mode -1))))

(with-eval-after-load 'pdf-tools
  (map! :map pdf-view-mode-map
        "h" #'pdf-annot-add-highlight-markup-annotation
        "t" #'pdf-annot-add-text-annotation
        "D" #'pdf-annot-delete
        "p" #'pdf-view-previous-page-command
        "n" #'pdf-view-next-page-command
        "e" #'pdf-view-goto-page
        "b" #'pdf-view-scroll-down-or-next-page
        "f" #'pdf-view-scroll-up-or-previous-page
        "d" #'pdf-view-dark-minor-mode))

;; ------------------------------
;; LaTeX Configuration
;; ------------------------------
(use-package! ox-latex
  :after org
  :config
  (setq org-latex-listings 'minted
        org-latex-packages-alist '(("" "minted" t)
                                   ("" "xcolor" t)
                                   ("" "hyperref" t)
                                   ("" "tocloft" t))
        org-latex-minted-options '(("breaklines" "true")
                                   ("bgcolor" "bg")
                                   ("fontsize" "\\footnotesize"))
        org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (setq org-export-babel-evaluate t
        org-confirm-babel-evaluate nil))

;; ------------------------------
;; Keybindings
;; ------------------------------
(map! :leader
      :prefix ("c" . "code")
      :desc "Format buffer" "f" #'lsp-format-buffer
      :desc "Organize imports" "i" #'lsp-organize-imports
      :desc "Find references" "r" #'lsp-find-references)

(map! :leader
      :desc "Correct word" "sc" #'flyspell-correct-word-before-point
      :desc "Flyspell correct" "ss" #'flyspell-correct-wrapper)

(map! :leader
      :desc "Adjust text scale" "zi" #'text-scale-increase
      :desc "Decrease text scale" "zo" #'text-scale-decrease
      :desc "Adjust text scale" "za" #'text-scale-adjust)

(map! :leader
      :desc "Magit Status" "g s" #'magit-status)

;; ------------------------------
;; Custom Functions and Hooks
;; ------------------------------
;; Auto-Revert Mode
(global-auto-revert-mode t)

;; Which-Key for Keybinding Guidance
(use-package! which-key
  :config
  (which-key-mode))

;; ------------------------------
;; Indentation and Garbage Collection
;; ------------------------------
(setq-default standard-indent 4
              tab-width 4
              evil-shift-width 4
              indent-tabs-mode t)

;; Garbage Collection Magic Hack
(use-package! gcmh
  :config
  (setq gcmh-idle-delay 'auto
        gcmh-high-cons-threshold (* 16 1024 1024)) ;; 16MB threshold
  (gcmh-mode 1))

;; ------------------------------
;; Native Compilation Settings
;; ------------------------------
(setq native-comp-speed 2
      native-comp-async-report-warnings-errors 'silent
      native-comp-deferred-compilation t)

;; ------------------------------
;; Ivy and Company Configuration
;; ------------------------------
(use-package! ivy
  :defer t
  :config
  (ivy-mode 1))

(use-package! company
  :defer t
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 2
        company-selection-wrap-around t)
  (global-company-mode 1))

;; LSP Mode Enhancements
(after! lsp-mode
  (setq lsp-headerline-breadcrumb-enable t
        lsp-signature-auto-activate t))

;; ------------------------------
;; PATH Configuration
;; ------------------------------
(setenv "PATH" (concat (getenv "PATH") ":/home/rob/.nix-profile/bin"))
(setq exec-path (append exec-path '("/home/rob/.nix-profile/bin")))

;; ------------------------------
;; Doom Dashboard Configuration
;; ------------------------------
(setq +doom-dashboard-functions
      '(doom-dashboard-widget-banner
        doom-dashboard-widget-shortmenu
        doom-dashboard-widget-loaded))
