;; init.el -*- lexical-binding: t; -*-

;; ------------------------------
;; Doom Modules
;; ------------------------------
(doom! :input
  ;; Input method modules
  ;; bidi     ; Bidirectional text support
  ;; chinese  ; Chinese language support
  ;; japanese ; Japanese language support
  ;; layout   ; Layout customization

    :completion

    company     ; The ultimate completion backend

    ;; helm      ; Completion and selection narrowing framework

    ;; ido      ; Advanced completion and selection

    ;; ivy      ; Completion and narrowing framework

    vertico     ; Minimal and fast vertical completion

  

    :ui

    doom         ; The Doom aesthetics

    ;; doom-dashboard ; A nifty splash screen for Emacs

    ;; doom-quit  ; Show a quit message

    ;; (emoji +unicode) ; Emoji support

    hl-todo      ; Highlight TODO/FIXME/NOTE/...

    ;; hydra      ; Hydra keybindings

    ;; indent-guides ; Show indentation guides

    ;; ligatures  ; Pretty symbols for code

    ;; minimap    ; A small map for code navigation

    ;; modeline   ; Customizable modeline

    ;; nav-flash  ; Flash the current line when navigating

    neotree      ; A tree-based file explorer

    ophints      ; Highlight operations hints

    (popup +defaults) ; Popup handling

    ;; tabs       ; Tab bar and related features

    ;; treemacs   ; Another tree-based file explorer

    ;; unicode    ; Unicode support

    (vc-gutter +pretty) ; Show version control diff indicators

    vi-tilde-fringe ; Add tilde marks in fringe

    ;; window-select ; Window selection framework

    workspaces   ; Manage workspaces

    ;; zen        ; Zen mode for distraction-free writing

  

    :editor

    (evil +everywhere) ; Vim emulation in Emacs

    file-templates ; Template management for new files

    ;; fold       ; Code folding

    ;; (format +onsave) ; Auto-format on save

    ;; god        ; God mode for Emacs

    ;; lispy      ; Lispy code editing

    ;; multiple-cursors ; Multiple cursors editing

    ;; objed      ; Object-oriented editing

    ;; parinfer   ; Parental inference for Lisp-like languages

    ;; rotate-text ; Rotate text snippets

    snippets     ; Template snippets

    ;; word-wrap  ; Enable word wrapping

  

    :emacs

    dired        ; Directory editor

    electric     ; Electric mode for interactive editing

    ;; ibuffer    ; Buffer management

    undo         ; Undo/redo functionality

    vc           ; Version control integration

  

    :term

    eshell       ; Emacs shell

    ;; shell      ; Traditional shell

    term         ; Terminal emulation

    vterm        ; Advanced terminal emulator

  

    :checkers

    syntax        ; Syntax checking

    (spell +flyspell) ; Spell checking

    grammar       ; Grammar checking

  

    :tools

    ;; ansible    ; Ansible automation

    ;; biblio     ; Bibliography management

    ;; collab     ; Collaborative tools

    ;; debugger   ; Debugging tools

    ;; direnv     ; Directory-specific environment variables

    ;; docker     ; Docker support

    ;; editorconfig ; EditorConfig integration

    ;; ein        ; Emacs IPython Notebook

    (eval +overlay) ; Code evaluation with overlay

    lookup       ; Documentation lookup

    ;; lsp        ; Language Server Protocol support

    magit        ; Git interface

    ;; make       ; Build automation

    ;; pass       ; Password management

    pdf          ; PDF tools

    ;; prodigy    ; Task management and automation

    ;; rgb        ; RGB color support

    ;; taskrunner ; Task running utilities

    ;; terraform  ; Terraform support

    ;; tmux       ; tmux integration

    ;; tree-sitter ; Syntax parsing and highlighting

    ;; upload:os  ; OS-specific file upload functionality

    ;; (:if (featurep :system 'macos) macos) ; macOS-specific configuration

    ;; tty        ; Terminal-only mode

  

    :lang

    ;; agda       ; Agda language support

    ;; beancount  ; Beancount accounting

    ;; (cc +lsp)  ; C/C++ language support with LSP

    ;; clojure    ; Clojure language support

    ;; common-lisp ; Common Lisp language support

    ;; coq        ; Coq proof assistant

    ;; crystal    ; Crystal language support

    ;; csharp     ; C# language support

    ;; data       ; Data science and analytics

    ;; (dart +flutter) ; Dart language with Flutter support

    ;; dhall      ; Dhall configuration language

    ;; elixir     ; Elixir language support

    ;; elm        ; Elm language support

    emacs-lisp   ; Emacs Lisp language support

    ;; erlang     ; Erlang language support

    ;; ess        ; Emacs Speaks Statistics

    ;; factor     ; Factor language support

    ;; faust      ; Faust programming language

    ;; fortran    ; Fortran language support

    ;; fsharp     ; F# language support

    ;; fstar      ; F# language support

    ;; gdscript   ; GDScript language support

    ;; (go +lsp)  ; Go language support with LSP

    ;; (graphql +lsp) ; GraphQL language support with LSP

    ;; (haskell +lsp) ; Haskell language support with LSP

    ;; hy         ; Hy language support

    ;; idris      ; Idris language support

    json         ; JSON language support

    ;; (java +lsp) ; Java language support with LSP

    ;; javascript ; JavaScript language support

    ;; julia      ; Julia language support

    ;; kotlin     ; Kotlin language support

    latex        ; LaTeX language support

    ;; lean       ; Lean theorem prover

    ;; ledger     ; Ledger accounting

    ;; lua        ; Lua language support

    markdown     ; Markdown language support

    ;; nim        ; Nim language support

    ;; ocaml      ; OCaml language support

    ;; php        ; PHP language support

    ;; plantuml   ; PlantUML support

    ;; purescript ; PureScript language support

    ;; python     ; Python language support

    ;; qt         ; Qt development

    ;; racket     ; Racket language support

    ;; raku       ; Raku language support

    ;; rest       ; RESTful API language support

    ;; rst        ; reStructuredText language support

    ;; (ruby +rails) ; Ruby language support with Rails

    ;; (rust +lsp) ; Rust language support with LSP

    ;; scala      ; Scala language support

    ;; (scheme +guile) ; Scheme language support with Guile

    sh           ; Shell scripting support

    ;; sml        ; Standard ML language support

    ;; solidity   ; Solidity language support

    ;; swift      ; Swift language support

    ;; terra      ; Terra language support

    ;; web        ; Web development

    ;; yaml       ; YAML language support

    ;; zig        ; Zig language support

  :email
  ;; (mu4e +org +gmail) ; mu4e email client with org and gmail support
  ;; notmuch    ; Notmuch email client
  ;; (wanderlust +gmail) ; Wanderlust email client with Gmail support

  :app
  ;; calendar   ; Calendar application
  ;; emms       ; Emacs Multimedia System
  ;; everywhere ; Global features
  ;; irc        ; IRC chat
  ;; (rss +org) ; RSS feeds with org support
  ;; twitter    ; Twitter integration

  :config
  ;; literate   ; Use literate configuration
  (default +bindings +smartparens) ; Default settings with keybindings and smartparens
)
