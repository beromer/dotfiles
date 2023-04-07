;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; APPEARANCE
;; (load-theme 'misterioso t)
(setq solarized-distinct-fringe-background t)
(setq solarized-high-contrast-mode-line t)
(setq solarized-scale-org-headlines nil)

(load-theme 'solarized-dark t)
;; only change the font size
(set-face-attribute 'default nil :height 160)
;; disable menu-bar on non-mac
(unless (memq window-system '(mac ns))
  (menu-bar-mode -1))
;; disable toolbar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
;; disable scroll bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
;; disable horizontal scroll bar
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))
;; (setq display-line-numbers-type 'relative)
;; (global-display-line-numbers-mode t)
;; don't automatically adjust window width as line numbers increase
;; (setq-default display-line-numbers-width 3)
;; (global-linum-mode t)

(setq
 ;; fix underline in mode-line
 x-underline-at-descent-line t
 ;; No need to see GNU agitprop.
 inhibit-startup-screen t
 ;; No need to remind me what a scratch buffer is.
 initial-scratch-message nil)

;; KEYBINDINGS
;; simpler keybinding for moving between windows
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-O") (lambda ()
                                (interactive)
                                (other-window -1)))
(global-set-key (kbd "M-i") 'imenu)
;; easily move to previous and next buffer
(global-set-key (kbd "C-c n") 'next-buffer)
(global-set-key (kbd "C-c p") 'previous-buffer)
;; use interactive buffer explorer
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; zap up to char instead of through char
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)
(global-set-key (kbd "M-z") 'zap-up-to-char)
;; better searching
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
;; M-SPC does cycle-spacing
(global-set-key [remap just-one-space] 'cycle-spacing)

;; COMPLETIONS
;; enable fido
(fido-mode 1)
;; present completions vertically (C-n, C-p to select)
(fido-vertical-mode 1)
;; more info in completions
(setq completions-detailed t)
;; fuzzy match
(setq completion-styles '(basic substring partial-completion flex))

;; EDITING
;; show matching paren when point is outside but next to paren group
(show-paren-mode 1)
;; auto insert closing pairs
(electric-pair-mode 1)
;; use spaces, not tabs
(setq-default indent-tabs-mode nil)
;; treat camelCase as distinct words
(global-subword-mode 1)
;; delete active region when typing over it
(delete-selection-mode 1)

;; OTHER/NOT ORGANIZED
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; save position of point in buffers
(save-place-mode 1)

;; always reload buffer if it changes on disk
(auto-revert-mode 1)

;; always save everything when compiling
(setq compilation-ask-about-save nil)

;; set default compile command
(setq compile-command "ninja -C ~/src/fury/build/")

;; remember window configurations (C-c <left> and C-c <right>)
(winner-mode 1)

(savehist-mode 1)
(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      load-prefer-newer t
      backup-by-copying t
      frame-inhibit-implied-resize t
      ediff-window-setup-function 'ediff-setup-windows-plain
      custom-file (expand-file-name "custom.el" user-emacs-directory))

(unless backup-directory-alist
  (setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                 "backups")))))


;; increace garbage collection threshhold and special variable limit
(setq gc-cons-threshold 100000000)
(setq max-specpdl-size 5000)

;; don't put the w3 validation link when exporting to html from org
(setq org-html-validation-link nil)

;; smooth scrolling (bad performance)
;; (pixel-scroll-mode 1)
(global-goto-address-mode 1)

(setq
 ;; enable additional search motions (M-<,M-> for first/last result,C-v,M-v for results off-screen)
 isearch-allow-motion t
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
 ;; kill-whole-line t
 ;; accept 'y' or 'n' instead of yes/no
 use-short-answers t
 ;; eke out a little more scrolling performance
 ;; fast-but-imprecise-scrolling t
 ;; prefer newer elisp files
 load-prefer-newer t
 ;; I want to close these fast, so switch to it so I can just hit 'q'
 help-window-select t
 ;; this certainly can't hurt anything
 delete-by-moving-to-trash t
 ;; keep the point in the same place while scrolling
 scroll-preserve-screen-position t
 ;; highlight error messages more aggressively
 next-error-message-highlight t
 ;; don't let the minibuffer muck up my window tiling
 read-minibuffer-restore-windows t
 ;; scope save prompts to individual projects
 save-some-buffers-default-predicate 'save-some-buffers-root
 ;; don't keep duplicate entries in kill ring
 kill-do-not-save-duplicates t
 ;; stuff copied from eos
 redisplay-dont-pause t
 jit-lock-stealth-time 0.2
 tooltip-reuse-hidden-frame t
 max-mini-window-height 0.3
 ;; Margins
 left-margin-width 1
 right-margin-width 1)

;; don't wrap long lines but enable scrolling instead
(setq mouse-wheel-tilt-scroll t
      mouse-wheel-flip-direction t)
(setq-default truncate-lines t)

;; enable right-click menu
(context-menu-mode 1)

;; MACHINE CONFIG
;; load machine specific init file
;; it looks for a file names <hostname>.el and loads it if present
;; use it for require-ing different configs for each machine you use
(setq gilesp-local-filename (concat system-name ".el"))
(setq gilesp-local-file (expand-file-name gilesp-local-filename user-emacs-directory))
(when (file-readable-p gilesp-local-file)
  (load-file gilesp-local-file))


;; PACKAGES
;; org mode
(require 'org-mouse)
(add-hook 'org-mode-hook #'turn-on-org-cdlatex)
(setq org-num-max-level 2
      org-num-skip-tags t
      org-num-skip-commented t
      org-num-skip-footnotes t)
(add-hook 'org-mode-hook #'org-indent-mode)
(add-hook 'org-mode-hook #'org-bullets-mode)

;; yasnippet
(yas-global-mode t)

;; company mode
(global-company-mode t)
(global-company-fuzzy-mode t)

;; eglot
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c++-mode . ("clangd" "--completion-style=detailed"))))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'prog-mode-hook 'linum-mode)
;; (add-hook 'eglot-managed-mode-hook (lambda ()
;;                                       (add-to-list 'company-backends
;;                                                    '(company-capf :with company-yasnippet))))
