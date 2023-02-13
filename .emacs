(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
     ("http" . "proxyout.lanl.gov:8080")
     ("https" . "proxyout.lanl.gov:8080")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(initial-frame-alist '((fullscreen . maximized)))
 '(org-agenda-files '("~/notes/todo.org" "~/notes/capture.org"))
 '(package-selected-packages
   '(magit company lua-mode vterm vertico use-package solarized-theme shrink-path marginalia magit-section emacsql-sqlite eglot doom-themes dashboard cdlatex auctex all-the-icons))
 '(tool-bar-mode nil))

;; set font
(set-face-attribute 'default nil :font "Fira Code" :height 150)

;; include homebrew path on mac so that emacs can find pdflatex and such
(setenv "PATH" (concat (getenv "PATH") ":/opt/homebrew/bin"))
(setq exec-path (append exec-path '("/opt/homebrew/bin")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(require 'use-package)

(load-theme 'solarized-dark t)

;; (setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; fix underline in mode-line
(setq x-underline-at-descent-line t)

;; increace garbage collection threshhold and special variable limit
(setq gc-cons-threshold 100000000)
(setq max-specpdl-size 5000)

;; turn on cdlatex in org-mode and auctex
(add-hook 'org-mode-hook #'turn-on-org-cdlatex)
(add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)

;; don't put the w3 validation link when exporting to html from org
(setq org-html-validation-link nil)

;; just don't make backups or auto-save
(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

(tool-bar-mode -1)	 ; disable toolbar on startup
(toggle-scroll-bar -1)	 ; disable scroll bar on startup
(electric-pair-mode 1)	 ; enable auto-closing pairs
(show-paren-mode 1)	 ; mark the matching paren
(pixel-scroll-mode 1)
(global-goto-address-mode 1)

;; enable minibufferhistory
(savehist-mode 1)

;; spaces and spaces only
(setq-default idnent-tabs-mode nil)

;; default fill-width
(setq-default fill-column 80)

(setq
 ;; No need to see GNU agitprop.
 inhibit-startup-screen t
 ;; No need to remind me what a scratch buffer is.
 initial-scratch-message nil
 ;; Double-spaces after periods is morally wrong.
 sentence-end-double-space nil
 ;; Never ding at me, ever.
 ring-bell-function 'ignore
 ;; Save existing clipboard text into the kill ring before replacing it.
 save-interprogram-paste-before-kill t
 ;; Prompts should go in the minibuffer, not in a GUI.
 use-dialog-box nil
 ;; Fix undo in commands affecting the mark.
 mark-even-if-inactive nil
 ;; Let C-k delete the whole line.
 kill-whole-line t
 ;; accept 'y' or 'n' instead of yes/no
 use-short-answers t
 ;; eke out a little more scrolling performance
 fast-but-imprecise-scrolling t
 ;; prefer newer elisp files
 load-prefer-newer t
 ;; I want to close these fast, so switch to it so I can just hit 'q'
 help-window-select t
 ;; this certainly can't hurt anything
 delete-by-moving-to-trash t
 ;; keep the point in the same place while scrolling
 scroll-preserve-screen-position t
 ;; more info in completions
 completions-detailed t
 ;; highlight error messages more aggressively
 next-error-message-highlight t
 ;; don't let the minibuffer muck up my window tiling
 read-minibuffer-restore-windows t
 ;; scope save prompts to individual projects
 save-some-buffers-default-predicate 'save-some-buffers-root
 ;; don't keep duplicate entries in kill ring
 kill-do-not-save-duplicates t
 )

;; don't wrap long lines but enable scrolling instead
(setq mouse-wheel-tilt-scroll t
      mouse-wheel-flip-direction t)
(setq-default truncate-lines t)

;; enable right-click menu
(context-menu-mode 1)

;; fuzzy match in vertico
(setq completion-styles '(basic substring partial-completion flex))

;; setup org capture
(setq org-default-notes-file "~/notes/capture.org")

;; KEYBINDINGS
(global-set-key (kbd "C-c n") 'next-buffer)
(global-set-key (kbd "C-c p") 'previous-buffer)

;; PACKAGES

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package vterm
  :ensure t)

(use-package tex
  :ensure auctex)

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
