;; dependencies
(add-to-list 'load-path "~/.emacs.d/cl-lib")

;; themes
(add-to-list 'load-path "~/.emacs.d/themes/color-theme")
(add-to-list 'load-path "~/.emacs.d/themes/emacs-color-theme-solarized")

;; plugins
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-flymake")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-nav")
(add-to-list 'load-path "~/.emacs.d/plugins/fill-column-indicator")
(add-to-list 'load-path "~/.emacs.d/plugins/php-mode")

;; Emacs globals
;; displays column number
(setq column-number-mode t)
;; Make Ctrl + Arrow work under a tmux-session
(global-set-key "\M-[1;5C"    'forward-word)      ; Ctrl+right   => forward word
(global-set-key "\M-[1;5D"    'backward-word)     ; Ctrl+left    => backward word

;; Init color themes and set color-theme-solarized-dark to default
(require 'color-theme)
(require 'color-theme-solarized)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-solarized-dark)))

;; column-marker
(require 'fill-column-indicator)
(setq fci-rule-width 1)
(setq fci-rule-color "purple")
(setq fci-rule-column 80)
(global-set-key (kbd "<f9>") 'fci-mode)

;; php-mode
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; whitespace-mode
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
;; Remove trailing whitespace
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
;; bind whitespace to python-mode
(add-hook 'python-mode-hook 'whitespace-mode)

;; load yasnippet and make it global
(require 'cl-lib)
(require 'yasnippet)
;; load custom snippets
(setq yas-snippet-dirs
  '("~/.emacs.d/plugins/yasnippet-custom/snippets"  ;; custom snippets
    "~/.emacs.d/plugins/yasnippet/snippets")) ;; the default collection
(yas-global-mode 1)

;; Configure flymake
;; load and configure flymake
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init)))
;; Let's run 8 checks at once instead.
(setq flymake-max-parallel-syntax-checks 8)
;; I want to see all errors for the line.
(setq flymake-number-of-errors-to-display nil)
;; Yes, I want my copies in the same dir as the original.
(setq flymake-run-in-place t)
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; load and configure nav-mode
(require 'nav)
(defface nav-hl-line
  '((t :background "#777777")) ; change to what suits best your theme
  "Custom face for highlighting the current line in nav mode."
  :version "22.1"
  :group 'hl-line)
;; This allows global-hl-line be disabled for certain buffers (nav in our case)
(defun nav-mode-hl-hook ()
  (setq global-hl-line-mode nil)
  (set (make-local-variable 'hl-line-face) 'nav-hl-line)
  (hl-line-mode t)
  (local-set-key (kbd "<right>") 'nav-open-file-under-cursor)
  (local-set-key (kbd "<left>")  'nav-go-up-one-dir))
(nav-disable-overeager-window-splitting)
(global-set-key (kbd "<f8>") 'nav-toggle)
(make-variable-buffer-local 'global-hl-line-mode)
(add-hook 'nav-mode-hook 'nav-mode-hl-hook)