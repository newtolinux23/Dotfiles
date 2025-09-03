;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; ------------------------------
;; User Information
;; ------------------------------
(setq user-full-name "Rob Alicea"
      user-mail-address "train@idoneitatemlife.com")

;; ------------------------------
;; Org Mode Configuration
;; ------------------------------
(defun my/org-babel-tangle-on-save ()
  "Tangle the current Org file on save."
  (when (string-equal (file-name-extension buffer-file-name) "org")
    (org-babel-tangle)))

(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'my/org-babel-tangle-on-save 'append 'local)))

(setq pdf-view-midnight-colors '("black" . "white"))
(add-hook 'pdf-view-mode-hook (lambda () (pdf-view-midnight-minor-mode -1)))

;; ------------------------------
;; Fonts and Appearance
;; ------------------------------
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 12)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 16))

(setq default-frame-alist '((font . "JetBrainsMono Nerd Font-16") (height . 50) (width . 100)))

;; ------------------------------
;; Theme
;; ------------------------------
(setq doom-theme 'doom-monokai-pro)

;; ------------------------------
;; UI Enhancements
;; ------------------------------
(setq display-line-numbers-type t
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

;; === Load custom.el safely ===
(setq custom-file "~/.doom.d/custom.el")
(load custom-file 'noerror 'nomessage)
