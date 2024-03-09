(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ae7aede615d12f126a7b6b0d8c1e0af2af1ab63fb21d80a130a5f701fdbb23fe" "4c326abbf8b85c85e114691d3892cbbfe889b2b064dadd284cf5eccca3eecbff" "7819a530936ad2204a35340498da6341f66d816a92b8c71af138f73814b269ec" "91fed8cade0d85d1f5a5621e72ac6e720945be79493465a79f020e673f7e2d24" "c49f79bfea991ed384cc0dc33328c8d812c413bf27cff0bc24ad58af2cdbccb4" "a73cd17e5b490a5558a0ca13186cccb85ff74b2160f77e65ff36024bc66089b4" "e546768f3da4b394adc8c460106a7d220af130a3a2a0518d265c832d015a4385" "46a843168cc83b28b740735516e6eea4f97769d848c79b5acab32f7a278f793a" "28d5b595e4724ad44b52eb1ab9bd6fbf1cca747109e2dc5ff4073a07d1b50946" "ca934a76aae4ff950288e082be75a68eb7bac6e8d3dd58b28649993540412ed6" "01aef17f41edea53c665cb57320bd80393761f836be5ab0bd53292afc94bd14d" "73c55f5fd22b6fd44f1979b6374ca7cc0a1614ee8ca5d4f1366a0f67da255627" "5e05db868f138062a3aedcccefe623eee18ec703ae25d4e5aebd65f892ac5bcc" "5f92b9fc442528b6f106eaefa18bb5e7bfa0d737164e18f1214410fef2a6678d" "8ea6a46120abb34bf6a664b76d78014e0dd1f2b740a0976ec41313612421712f" "7d10494665024176a90895ff7836a8e810d9549a9872c17db8871900add93d5c" "38cb7d03fec58c860d5e92ee756aa80bdb2d78ef7ac726317e78c5c844e04f3a" "4de156ea6aa06640e3d16da41dfbdee85aea2fb969f620e601a982c6e237b396" "65809263a533c5151d522570b419f1a653bfd8fb97e85166cf4278e38c39e00e" "65af8e8d704bcd9745a4f191db756995de6b1fdd15cf2eb41befaae75f7b045d" "67a0f6cdf628610987cf7f0d38f0ae68ed3a5ab6816ff3da5f66d7b09d03f470" "205bb9accecaf0ae5e8cb5f09773be4f1175aca71322ba4fd44b539cd48463b6" "c73ce0e82bfbf5f186756001eeaaf26f0b461851a8b421d1ff5ec35e10f300ed" "704f75d46620d87bb246e2ec1abb129437764b0e84ac0fff6b968311cc046918" "7dc1c6210efe106a8c6cd47009a2ffd0069826b550dda379e8e4ef6105384cba" "a6a979c8b7ccb1d4536f4fa74a6e47674a3ce65feea3fecdf1d9dc448fac47e0" "7a259016d8fe61ef450895a01d842c4353dabc873ee46e250c933995f7f004cf" "df42062cdd672acecac9b5a1229c45f74c0cc2bc0362f9ad41054af6ac355021" "7ca04d620046f5807d0740f265844d45e53b864138c246f48f663bea8fba5c5d" "b0b29575dda28e1948e31f40e7693fa8483d7a9b1b7aff069fa8a1b7193cd1ab" "a44e2d1636a0114c5e407a748841f6723ed442dc3a0ed086542dc71b92a87aee" "b1acc21dcb556407306eccd73f90eb7d69664380483b18496d9c5ccc5968ab43" "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd" "e9d47d6d41e42a8313c81995a60b2af6588e9f01a1cf19ca42669a7ffd5c2fde" default))
 '(delete-selection-mode nil)
 '(org-agenda-files
   '("/home/beromer/notes/titans.org" "/home/beromer/notes/one-on-one-2024.org" "/home/beromer/notes/general.org" "/home/beromer/notes/fury/fury.org" "/home/beromer/notes/planner-2024.org" "/home/beromer/notes/tnburn/tnburn.org" "/home/beromer/notes/whisk/whisk.org"))
 '(org-agenda-restore-windows-after-quit t)
 '(org-agenda-window-setup 'current-window)
 '(package-selected-packages
   '(pdf-tools company-auctex auctex-latexmk tex vterm-toggle ef-themes yaml-mode company yasnippet cyberpunk-theme yasnippet-snippets which-key vterm treemacs python-mode projectile org-bullets neotree markdown-mode magit lua-mode git-gutter-fringe doom-themes dashboard company-fuzzy cmake-mode cdlatex auctex all-the-icons))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "nil" :slant normal :weight medium :height 111 :width normal)))))

;; MELPA
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;; ;; (eval-and-compile
;; ;;   (setq use-package-always-ensure t
;; ;;         use-package-expand-minimally t))
;; (require 'use-package)
;; ;; tell use-package to install a package if it's not already installed
(setq use-package-always-ensure t)

;; APPEARANCE
;; (load-themel 'misterioso t)

;; (unless (package-installed-p `solarized-theme) (package-install `solarized-theme))
;; (setq solarized-distinct-fringe-background t)
;; (setq solarized-high-contrast-mode-line t)
;; (setq solarized-scale-org-headlines nil)
;; (load-theme 'solarized-dark t)

;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   (load-theme 'doom-solarized-dark-high-contrast t)
;;   )

;; (load-theme 'wombat t)
;; (load-theme 'cyberpunk t)
(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-night t)
  (setq ef-themes-to-toggle '(ef-night ef-day))
  (global-set-key [f7] 'ef-themes-toggle)
  )


;; (setq modus-themes-bold-constructs t
;;       modus-themes-mode-line '(accented)
;;       ;; modus-themes-mode-line '(borderless accented)
;;       ;; modus-themes-paren-match 'intense
;;       modus-themes-syntax '(green-strings)
;;       modus-themes-completions nil)
;; (load-theme 'modus-operandi t)
;; (load-theme 'modus-vivendi t)
;; (global-set-key [f7] 'modus-themes-toggle)
;; (global-set-key (kbd "C-c y") 'modus-themes-toggle)

;; only change the font size
;; (set-face-attribute 'default nil :height 140)
;; (set-face-attribute 'default nil :family "Fira Code" :height 160)

(if (display-graphic-p)
    (progn
;; disable menu-bar on non-mac
;; (unless (memq window-system '(mac ns))
;;   (menu-bar-mode -1))
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
(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; Mac keybindings
(setq mac-command-modifier 'super
      mac-option-modifier 'meta)
;; (setq mac-option-modifier nil
;;       mac-command-key-is-meta t
;;       mac-command-modifier 'meta
;;       mac-option-modifier 'super
;;       )

;; DIRED
(setq dired-isearch-filenames t
      dired-kill-when-opening-new-dired-buffer t)

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
      ;; custom-file (expand-file-name "custom.el" user-emacs-directory)
      )


(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "/backups/"))))
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
(use-package neotree
    :bind (("C-c t" . neotree-toggle)))


;; org mode
(require 'org-mouse)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
(setq org-num-max-level 2
      org-num-skip-tags t
      org-num-skip-commented t
      org-num-skip-footnotes t)
(add-hook 'org-mode-hook #'turn-on-org-cdlatex)
(add-hook 'org-mode-hook #'org-indent-mode)
;; (add-hook 'org-mode-hook #'org-bullets-mode)
(add-hook 'org-mode-hook #'visual-line-mode)
;; (use-package org
;;   :hook (org-mode . (lambda () (visual-line-mode))))
  
;; (use-package org-bullets
;;   :hook(( org-mode ) . org-bullets-mode))

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
(use-package yasnippet
  :config
  (use-package yasnippet-snippets)
  (yas-global-mode t)
  (yas-reload-all))

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

(use-package company-auctex
  :pin melpa
  :after tex
  :init
  (company-auctex-init))

;; (unless (package-installed-p `auctex) (package-install `auctex))
;; (unless (package-installed-p `cdlatex) (package-install `cdlatex))
;; (add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)
;; (add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'LaTeX-mode-hook 'TeX-interactive-mode)
;; (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (add-hook 'LaTeX-mode-hook 'linum-mode)
;; (setq reftex-plug-into-AUCTeX t)

(use-package git-gutter
  :ensure git-gutter-fringe
  ;; :after magit
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

;; ;; company mode
;; (global-company-mode t)
;; (global-company-fuzzy-mode t)
(unless (package-installed-p `company) (package-install `company))
(unless (package-installed-p `company-fuzzy) (package-install `company-fuzzy))
;; (add-hook 'after-init-hook 'global-company-mode)
;; (add-hook 'after-init-hook 'global-company-fuzzy-mode)

;; eglot
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c++-mode . ("clangd"
                             "--completion-style=detailed"
                             "-j=4"
                             "--background-index"
                             "--header-insertion=never"))))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'company-mode)
;; (add-hook 'eglot-managed-mode-hook (lambda ()
;;                                       (add-to-list 'company-backends
;;                                                    '(company-capf :with company-yasnippet))))

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

(use-package cmake-mode
  :ensure t
  )

(use-package which-key
     :ensure t
     :custom
     (which-key-idle-delay 2)
     :config
     (which-key-mode))

;; ;; Outline-minor-mode key map Source: https://www.emacswiki.org/emacs/OutlineMinorMode
;; (define-prefix-command 'cm-map nil "Outline-")
;; ; HIDE
;; (define-key cm-map "q" 'hide-sublevels)    ; Hide everything but the top-level headings
;; (define-key cm-map "t" 'hide-body)         ; Hide everything but headings (all body lines)
;; (define-key cm-map "o" 'hide-other)        ; Hide other branches
;; (define-key cm-map "c" 'hide-entry)        ; Hide this entry's body
;; (define-key cm-map "l" 'hide-leaves)       ; Hide body lines in this entry and sub-entries
;; (define-key cm-map "d" 'hide-subtree)      ; Hide everything in this entry and sub-entries
;; ;; SHOW
;; (define-key cm-map "a" 'show-all)          ; Show (expand) everything
;; (define-key cm-map "e" 'show-entry)        ; Show this heading's body
;; (define-key cm-map "i" 'show-children)     ; Show this heading's immediate child sub-headings
;; (define-key cm-map "k" 'show-branches)     ; Show all sub-headings under this heading
;; (define-key cm-map "s" 'show-subtree)      ; Show (expand) everything in this heading & below
;; ;; MOVE
;; (define-key cm-map "u" 'outline-up-heading)                ; Up
;; (define-key cm-map "n" 'outline-next-visible-heading)      ; Next
;; (define-key cm-map "p" 'outline-previous-visible-heading)  ; Previous
;; (define-key cm-map "f" 'outline-forward-same-level)        ; Forward - same level
;; (define-key cm-map "b" 'outline-backward-same-level)       ; Backward - same level
;; (global-set-key (kbd "C-c o") cm-map)
