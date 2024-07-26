;; ------------------------------
;; User Information
;; ------------------------------
(setq user-full-name "Robert Alicea"
      user-mail-address "train@idoneitatemlife.com")

;; ------------------------------
;; Fonts and Appearance
;; ------------------------------
(setq doom-font (font-spec :family "Source Code Pro" :size 20)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 20)
      doom-big-font (font-spec :family "Source Code Pro" :size 24)
      doom-theme 'doom-molokai
      display-line-numbers-type t
      doom-modeline-icon t
      doom-modeline-height 25
      inhibit-startup-screen t)

(global-display-line-numbers-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-frame-parameter (selected-frame) 'alpha '(98 98))
(add-to-list 'default-frame-alist '(alpha 98 98))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; ------------------------------
;; Org Mode Configuration
;; ------------------------------
(setq org-directory "~/org/"
      org-startup-indented t
      org-hide-leading-stars t)

(setq-default fill-column 80)

(use-package! org
  :defer t
  :config
  ;; Enable visual line mode and auto-fill mode in Org mode
  (add-hook 'org-mode-hook #'visual-line-mode)
  (add-hook 'org-mode-hook #'auto-fill-mode)
  ;; Tangle Org Babel code blocks after saving
  (add-hook 'org-mode-hook
            (lambda ()
              (add-hook 'after-save-hook 'org-babel-tangle 'append 'local))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)))

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
  (add-hook 'pdf-view-mode-hook (lambda () (pdf-view-midnight-minor-mode -1)))
  (add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1))))

(map! :map pdf-view-mode-map
      "h" #'pdf-annot-add-highlight-markup-annotation
      "t" #'pdf-annot-add-text-annotation
      "D" #'pdf-annot-delete
      "p" #'pdf-view-previous-page-command
      "n" #'pdf-view-next-page-command
      "e" #'pdf-view-goto-page
      "b" #'pdf-view-scroll-down-or-next-page
      "f" #'pdf-view-scroll-up-or-previous-page
      "d" #'pdf-view-dark-minor-mode)

;; ------------------------------
;; LaTeX Configuration
;; ------------------------------
(with-eval-after-load 'tex
  (setq LaTeX-command "latex -shell-escape"
        TeX-PDF-mode t
        TeX-auto-save t
        TeX-parse-self t
        TeX-master nil)
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

;; ------------------------------
;; Keybindings
;; ------------------------------
(map! :leader
      :prefix ("c" . "code")
      :desc "Format buffer" "f" #'lsp-format-buffer
      :desc "Organize imports" "i" #'lsp-organize-imports
      :desc "Find references" "r" #'lsp-find-references)

(map! :leader
      :desc "Correct word" "sc" #'flyspell-correct-word-before-point)

(map! :leader
      :desc "Flyspell correct" "ss" #'flyspell-correct-wrapper)

(map! :leader
      :desc "Increase text scale" "zi" #'text-scale-increase
      :desc "Decrease text scale" "zo" #'text-scale-decrease
      :desc "Reset text scale" "zr" (lambda () (interactive) (text-scale-set 3)))

;; ------------------------------
;; Custom Functions and Hooks
;; ------------------------------
(defun my/set-default-text-scale ()
  "Set the default text scale."
  (text-scale-set 5))

(add-hook 'after-init-hook 'my/set-default-text-scale)
(add-hook 'doom-init-ui-hook #'doom-disable-line-numbers-h)

;; ------------------------------
;; Indentation and Garbage Collection
;; ------------------------------
(setq-default standard-indent 4
              tab-width 4
              evil-shift-width 4
              indent-tabs-mode t)

(setq gc-cons-threshold (* 100 1024 1024))
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1024 1024)
                  gc-cons-percentage 0.1)))

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
  (global-company-mode 1))

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

(evil-define-key 'normal 'global
  (kbd "SPC f f") 'find-file
  (kbd "SPC b b") 'switch-to-buffer)

(evil-define-key 'insert 'global
  (kbd "C-c c") 'comment-line)
