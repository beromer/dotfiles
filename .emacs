;; MELPA
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; (eval-and-compile
;;   (setq use-package-always-ensure t
;;         use-package-expand-minimally t))
(require 'use-package)
;; tell use-package to install a package if it's not already installed
(setq use-package-always-ensure t)



;; APPEARANCE
;; (load-theme 'misterioso t)

;; (unless (package-installed-p `solarized-theme) (package-install `solarized-theme))
;; (setq solarized-distinct-fringe-background t)
;; (setq solarized-high-contrast-mode-line t)
;; (setq solarized-scale-org-headlines nil)
;; (load-theme 'solarized-dark t)

(load-theme 'doom-solarized-dark-high-contrast t)

;; (load-theme 'wombat t)

;; (setq modus-themes-bold-constructs t
;;       modus-themes-mode-line '(borderless accented)
;;       modus-themes-paren-match 'intense
;;       modus-themes-syntax '(green-strings)
;;       modus-themes-completions nil)
;; (load-theme 'modus-vivendi t)

;; only change the font size
;; (set-face-attribute 'default nil :height 140)
(set-face-attribute 'default nil :family "Fira Code" :height 160)

(if (display-graphic-p)
    (progn
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
))
;; (setq display-line-numbers-type 'relative)
;; (global-display-line-numbers-mode t)
;; don't automatically adjust window width as line numbers increase
;; (setq-default display-line-numbers-width 3)
;; (global-linum-mode t)
;; use line-numbers only in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(global-tab-line-mode)

(setq display-line-numbers-width-start 3)

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
(setq
 mac-command-modifier 'super
 mac-option-modifier 'meta
 )
(global-set-key [remap dabbrev-expand] 'hippie-expand)

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
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; always save everything when compiling
(setq compilation-ask-about-save nil)

;; set default compile command
(setq compile-command "ninja -C build/")
(setq compilation-scroll-output t)

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
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode))
(use-package magit
  :bind (("C-x g" . magit)))
(use-package lua-mode)
(use-package python-mode)

;; org mode
(require 'org-mouse)
(add-hook 'org-mode-hook #'turn-on-org-cdlatex)
(setq org-num-max-level 2
      org-num-skip-tags t
      org-num-skip-commented t
      org-num-skip-footnotes t)
(add-hook 'org-mode-hook #'org-indent-mode)
(add-hook 'org-mode-hook #'org-bullets-mode)
;; don't put the w3 validation link when exporting to html from org
(setq org-html-validation-link nil)
;; RETURN will follow links in org-mode files
(setq org-return-follows-link  t)

;; ;; yasnippet
;; (yas-global-mode t)
(use-package yasnippet
  :config
  (use-package yasnippet-snippets)
  (yas-global-mode t)
  (yas-reload-all))

;; latex
(unless (package-installed-p `auctex) (package-install `auctex))
(unless (package-installed-p `cdlatex) (package-install `cdlatex))
(add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'TeX-interactive-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'linum-mode)
(setq reftex-plug-into-AUCTeX t)

(use-package git-gutter
  :ensure git-gutter-fringe
  ;; :after magit
  :init
  (setq-default left-fringe-width 20)
  :hook
  (prog-mode . git-gutter-mode)
  (magit-post-refresh . git-gutter:update-all-windows))

;; ;; company mode
;; (global-company-mode t)
;; (global-company-fuzzy-mode t)
(unless (package-installed-p `company) (package-install `company))
(unless (package-installed-p `company-fuzzy) (package-install `company-fuzzy))
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'global-company-fuzzy-mode)

;; ;; eglot
;; (with-eval-after-load 'eglot
;;   (add-to-list 'eglot-server-programs
;;                '(c++-mode . ("clangd" "--completion-style=detailed"))))
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'c++-mode-hook 'eglot-ensure)
;; ;; (add-hook 'eglot-managed-mode-hook (lambda ()
;; ;;                                       (add-to-list 'company-backends
;; ;;                                                    '(company-capf :with company-yasnippet))))

(use-package all-the-icons)

(use-package projectile
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("M-p" . projectile-command-map)))

(use-package dashboard
;;   :after (all-the-icons dashboard-hackernews helm-system-packages)
  :ensure t
  :init
  (dashboard-setup-startup-hook)

  :custom
  ;; (dashboard-banner-logo-title "Let's get stuff done!")
  (dashboard-startup-banner 'logo)
  (dashboard-center-content t)
  (dashboard-set-navigator t)
;;   (dashboard-navigator-buttons '((("⤓" " Install system package" " Install system package" (lambda (&rest _) (helm-system-packages))))))
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-items '((projects . 10)
                     (recents . 15)
                     ;; (hackernews . 5)
                     )))
;; (use-package dashboard-hackernews)

(use-package which-key
     :ensure t
     :custom
     (which-key-idle-delay 2)
     :config
     (which-key-mode))

;; Outline-minor-mode key map Source: https://www.emacswiki.org/emacs/OutlineMinorMode
(define-prefix-command 'cm-map nil "Outline-")
; HIDE
(define-key cm-map "q" 'hide-sublevels)    ; Hide everything but the top-level headings
(define-key cm-map "t" 'hide-body)         ; Hide everything but headings (all body lines)
(define-key cm-map "o" 'hide-other)        ; Hide other branches
(define-key cm-map "c" 'hide-entry)        ; Hide this entry's body
(define-key cm-map "l" 'hide-leaves)       ; Hide body lines in this entry and sub-entries
(define-key cm-map "d" 'hide-subtree)      ; Hide everything in this entry and sub-entries
;; SHOW
(define-key cm-map "a" 'show-all)          ; Show (expand) everything
(define-key cm-map "e" 'show-entry)        ; Show this heading's body
(define-key cm-map "i" 'show-children)     ; Show this heading's immediate child sub-headings
(define-key cm-map "k" 'show-branches)     ; Show all sub-headings under this heading
(define-key cm-map "s" 'show-subtree)      ; Show (expand) everything in this heading & below
;; MOVE
(define-key cm-map "u" 'outline-up-heading)                ; Up
(define-key cm-map "n" 'outline-next-visible-heading)      ; Next
(define-key cm-map "p" 'outline-previous-visible-heading)  ; Previous
(define-key cm-map "f" 'outline-forward-same-level)        ; Forward - same level
(define-key cm-map "b" 'outline-backward-same-level)       ; Backward - same level
(global-set-key (kbd "C-c o") cm-map)
