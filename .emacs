;; MELPA
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(setq use-package-always-ensure t)

;; APPEARANCE
(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-night t)
  (setq ef-themes-to-toggle '(ef-night ef-day))
  (global-set-key [f7] 'ef-themes-toggle)
  )

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
;; use line-numbers only in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-width-start 3)
;; (global-tab-line-mode)
(global-tab-line-mode 1)

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
(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; Mac keybindings
;; if swapping opt and cmd
;; (setq mac-command-modifier 'super
;;       mac-option-modifier 'meta)
;; if not swapping opt and cmd
(setq mac-option-modifier nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'super
      )

;; DIRED
(setq dired-isearch-filenames t
      dired-kill-when-opening-new-dired-buffer t)

;; MINIBUFFER
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

;; use modifier only once for repetitive commands
(repeat-mode 1)

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
      )

;; don't litter
(setq backup-inhibited t
      auto-save-default nil
      create-lockfiles nil)
;; (setq backup-directory-alist
;;       `(("." . ,(concat user-emacs-directory "/backups/"))))
;; (setq auto-save-file-name-transforms
;;       `(("." ,(concat user-emacs-directory "/backups/") t )))


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

;; location data
(setq calendar-latitude 35.88)
(setq calendar-longitude -106.32)
(setq calendar-location-name "Los Alamos, NM")

;; MACHINE CONFIG
;; load machine specific init file
;; it looks for a file names <hostname>.el and loads it if present
;; use it for require-ing different configs for each machine you use
(setq gilesp-local-filename (concat system-name ".el"))
(setq gilesp-local-file (expand-file-name gilesp-local-filename user-emacs-directory))
(when (file-readable-p gilesp-local-file)
  (load-file gilesp-local-file))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory)
      )

;; Custom functions
(define-minor-mode sticky-buffer-mode
  "Make the current window always display this buffer."
  nil " sticky" nil
  (set-window-dedicated-p (selected-window) sticky-buffer-mode))

;; PACKAGES

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode))
(use-package magit
  :bind (("C-x g" . magit)))
(use-package lua-mode)
(use-package python-mode)
(use-package cmake-mode)
(use-package clang-format)


;; org mode
(use-package org-bullets
  :hook(( org-mode ) . org-bullets-mode))

(require 'org-mouse)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
(setq org-num-max-level 2
      org-num-skip-tags t
      org-num-skip-commented t
      org-num-skip-footnotes t)
(add-hook 'org-mode-hook #'turn-on-org-cdlatex)
(add-hook 'org-mode-hook #'org-indent-mode)
(add-hook 'org-mode-hook #'org-bullets-mode)
(add-hook 'org-mode-hook #'visual-line-mode)
;; (use-package org
;;   :hook (org-mode . (lambda () (visual-line-mode))))
;; don't put the w3 validation link when exporting to html from org
(setq org-html-validation-link nil)
;; RETURN will follow links in org-mode files
(setq org-return-follows-link  t)

;; org keybinds
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(setq org-default-notes-file "~/notes/general.org")

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/notes/general.org" "Tasks")
         "* TODO %?\n%i")
        ("j" "Journal" entry (file+datetree "~/notes/journal.org")
         "* %?\n%i")))
(setq org-refile-targets '((nil :maxlevel . 9)
                                (org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "M-n") #'org-next-link)
  (define-key org-mode-map (kbd "M-p") #'org-previous-link))

;; yasnippet
;; (yas-global-mode t)
;; (use-package yasnippet
;;   :config
;;   (use-package yasnippet-snippets)
;;   (yas-global-mode t)
;;   (yas-reload-all))

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-tools-modes)
  :custom
  (pdf-view-display-size 'fit-width)
  (pdf-annot-activate-created-annotations t)
  :config
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (define-key pdf-view-mode-map (kbd "C-r") 'isearch-backward))

;; latex
(use-package tex
  :defer t
  :ensure auctex
  :mode ("\\.tex\\$" . latex-mode)
  :custom
  (TeX-auto-save t)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-method 'synctex)
  (TeX-parse-self t)
  (LaTeX-electric-left-right-brace t)
  (reftex-plug-into-AUCTeX t)
  (TeX-source-correlate-start-server t)
  (TeX-interactive-mode t)
  (TeX-master nil)
  (TeX-view-program-selection '((output-pdf "PDF Tools")))
  :config
  (defun save-and-compile ()
    (interactive)
    (let (TeX-save-query) (TeX-save-document (TeX-master-file)))
    (TeX-command-run-all nil))
  (bind-key "<f5>" 'save-and-compile)
   (progn
    (pdf-loader-install)
    ;; Update PDF buffers after successful LaTeX runs
    (add-hook 'TeX-after-compilation-finished-functions
	      #'TeX-revert-document-buffer)
    (yas-reload-all)
    (add-hook 'LaTeX-mode-hook
	      (lambda ()
		(reftex-mode t)
		(flyspell-mode t)
		(company-mode t)
		;; (yas-minor-mode t)
		(LaTeX-math-mode t)
		(tex-fold-mode 1)
                (visual-line-mode t)
                (display-line-numbers-mode t)
                (cdlatex-mode t)
                )))
  )
(use-package cdlatex
  :ensure t)

(use-package git-gutter
  :ensure git-gutter-fringe
  :after magit
  :init
  (setq-default left-fringe-width 20)
  :hook
  (prog-mode . git-gutter-mode)
  (magit-post-refresh . git-gutter:update-all-windows))

(use-package vterm
  :init
  (setq-default vterm-max-scrollback 100000)
  (setq vterm-clear-scrollback-when-clearing t)
  (setq vterm-kill-buffer-on-exit t)
  (setq vterm-copy-exclude-prompt t)
  ;; (setq vterm-buffer-name-string "vterm %s")
  :config
  (define-key vterm-mode-map (kbd "C-q") #'vterm-send-next-key)
  )

;; add this to .bashrc
;; if [[ "$INSIDE_EMACS" = 'vterm' ]] \
;;     && [[ -n ${EMACS_VTERM_PATH} ]] \
;;     && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh ]]; then
;;     source ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh
;;     find_file() {
;;         vterm_cmd find-file "$(realpath "${@:-.}")"
;;     }
;; fi

;; eglot
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c++-mode . ("clangd"
                             "--completion-style=detailed"
                             "-j=4"
                             "--background-index"
                             "--header-insertion=never"))))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(use-package corfu
  ;; Optional customizations
  :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match 'separator)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  ;; (setq completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  (setq text-mode-ispell-word-completion nil)

  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (setq read-extended-command-predicate #'command-completion-default-include-p))

(use-package projectile
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("M-p" . projectile-command-map)))

(use-package dashboard
  :ensure t
  :init
  (dashboard-setup-startup-hook)

  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-center-content t)
  (dashboard-set-navigator t)
  (dashboard-set-heading-icons nil)
  (dashboard-set-file-icons nil)
  (dashboard-display-icons-p nil)
  (dashboard-items '((projects . 5)
                     (recents . 5)
                     (bookmarks . 5)
                     (agenda    . 5)

                     )))

(use-package which-key
     :ensure t
     :custom
     (which-key-idle-delay 2)
     :config
     (which-key-mode))

(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
