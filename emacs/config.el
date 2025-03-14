;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))
(set-fontset-font "fontset-default" 'hangul (font-spec :family "NanumGothicCoding" :size 15))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;;
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;; Connect with system clipboard
(setq select-enable-clipboard t)

(setq initial-frame-alist
      '((top . 50)
        (left . 50)
        (width . 160)
        (height . 500)))

(defun my/connect-desktop ()
  "Connect to desktop via SSH"
  (interactive)
  (find-file "/ssh:donglelinux:"))

(global-set-key (kbd "C-c r") 'my/connect-desktop)

(after! projectile
 (setq projectile-project-search-path '("~/"))
 (setq projectile-auto-discover t)
 (setq projectile-track-known-projects-automatically t))

(after! treemacs
  (setq treemacs-width 22)
  (setq treemacs-width-is-initially-locked t)
  (setq treemacs-follow-after-init t
        treemacs-project-follow-cleanup t
        treemacs-project-follow-into-home t)
  (treemacs-follow-mode t)
  (treemacs-load-theme "nerd-icons"))

(map! :after treemacs
      :map treemacs-mode-map
      "[" #'treemacs-decrease-width
      "]" #'treemacs-increase-width)


(add-hook! 'window-setup-hook #'treemacs)

;company settings
(global-company-mode +1)
(after! company
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2
        company-show-numbers t
        company-tooltip-limit 10
        company-tooltip-align-annotations t
        company-require-match nil))

(map! :map company-active-map
      "TAB"      #'company-complete-selection
      "<tab>"    #'company-complete-selection
      "RET"      #'company-complete-selection
      "<return>" #'company-complete-selection)


(after! company
  (setq company-backends
        '(company-capf
          company-files
          (company-dabbrev-code company-keywords)
          company-dabbrev))
  (setq company-global-modes '(not eshell-mode shell-mode)))
