;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; ------------------------------
;; User Information
;; ------------------------------
(setq user-full-name "Robert Alicea"
      user-mail-address "train@idoneitatemlife.com")

;; ------------------------------
;; Fonts and Appearance
;; ------------------------------
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "Sans" :size 20) ; Enhanced variable pitch font
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 24)
      doom-theme 'doom-monokai-pro
      display-line-numbers-type t
      doom-modeline-icon t
      doom-modeline-height 25
      inhibit-startup-screen t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-frame-parameter (selected-frame) 'alpha '(98 98))
(add-to-list 'default-frame-alist '(alpha 98 98))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(defun my/set-default-text-scale ()
  "Set the default text scale."
  (text-scale-set 0)) ;; Set default to 0 to avoid excessive zoom
(add-hook 'after-init-hook #'my/set-default-text-scale)

;; ------------------------------
;; Org Mode Configuration
;; ------------------------------
(setq org-directory "~/org/"
      org-startup-indented t
      org-hide-leading-stars t
      org-hide-emphasis-markers t)

(setq-default fill-column 80)

(use-package! org
  :defer t
  :config
  ;; Tangle Org Babel code blocks after saving if in Org mode
  (add-hook 'after-save-hook
            (lambda ()
              (when (eq major-mode 'org-mode)
                (org-babel-tangle 'append 'local)))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)))

;; Org Bullets for better visual appearance
(use-package! org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list '("◉" "○" "●" "◆" "▶")))

;; Enable Flyspell in Org mode for spell checking
(add-hook 'org-mode-hook #'flyspell-mode)
(setq ispell-dictionary "en_US")

;; Enable auto-calculation in Org-mode tables
(setq org-table-automatic-realign t)  ; Automatically realign tables after edits
(setq org-table-automatic-recalculate t)  ; Automatically recalculate after edits
(add-hook 'before-save-hook 'org-table-recalculate-buffer-tables)

;; Custom function and keybinding to recalculate tables in Org mode
(defun my/org-table-recalculate-at-point ()
  "Recalculate the Org table if the point is within a table."
  (interactive)
  (when (org-at-table-p)
    (org-table-recalculate t)))

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") #'my/org-table-recalculate-at-point))

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
        pdf-view-resize-factor 1.1)
  (setq-default pdf-view-display-size 'fit-page)
  (add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1))))

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
(with-eval-after-load 'tex
  (setq LaTeX-command "latex -shell-escape"
        TeX-PDF-mode t
        TeX-auto-save t
        TeX-parse-self t
        TeX-master nil
        TeX-source-correlate-mode t               ; Enable SyncTeX
        TeX-source-correlate-method 'synctex)
  (add-hook 'TeX-mode-hook
            (lambda ()
              (add-to-list 'TeX-command-list
                           '("XeLaTeX" "xelatex -interaction=nonstopmode %s"
                             TeX-run-command t t :help "Run XeLaTeX")))))

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
                                "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")))

(setq org-export-babel-evaluate t)  ;; Enable evaluation of code blocks during export
(setq org-confirm-babel-evaluate nil)  ;; Disable confirmation prompt for code block evaluation

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
      :desc "Increase text scale" "zi" #'text-scale-increase
      :desc "Decrease text scale" "zo" #'text-scale-decrease
      :desc "Reset text scale" "zr" (lambda () (interactive) (text-scale-set 0)))

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
      native-comp-async-report-warnings-errors 'silent)

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
