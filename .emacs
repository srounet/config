;; dependencies
(add-to-list 'load-path "~/.emacs.d/cl-lib")

;; themes
(add-to-list 'load-path "~/.emacs.d/themes/color-theme")
(add-to-list 'load-path "~/.emacs.d/themes/emacs-color-theme-solarized")

;; plugins
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-flymake")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-nav")

;; Init color themes and set color-theme-solarized-dark to default
(require 'color-theme)
(require 'color-theme-solarized)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-solarized-dark)))

;; Make Ctrl + Arrow work under a tmux-session
(global-set-key "\M-[1;5C"    'forward-word)      ; Ctrl+right   => forward word
(global-set-key "\M-[1;5D"    'backward-word)     ; Ctrl+left    => backward word

;; Remove trailing whitespace
(require 'whitespace)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(setq whitespace-line-column 80
  whitespace-style '(tabs trailing lines-tail))

;; colorize whitespace
(set-face-attribute 'whitespace-line nil
  :background "red1"
  :foreground "yellow"
  :weight 'bold)
(set-face-attribute 'whitespace-tab nil
  :background "red1"
  :foreground "yellow"
  :weight 'bold)

;; bind whitespace to python-mode
(add-hook 'python-mode-hook 'whitespace-mode)

;; load yasnippet and make it global
(require 'cl-lib)
(require 'yasnippet)
;; load custom snippets
(setq yas-snippet-dirs
      '("~/.emacs.d/plugins/yasnippet-custom/snippets"  ;; custom snippets
        "~/.emacs.d/plugins/yasnippet/snippets" ;; the default collection
        ))
(yas-global-mode 1)

;; Configure flymake
;; Let's run 8 checks at once instead.
(setq flymake-max-parallel-syntax-checks 8)
;; I want to see all errors for the line.
(setq flymake-number-of-errors-to-display nil)
;; Yes, I want my copies in the same dir as the original.
(setq flymake-run-in-place t)

;; load flymake
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

(add-hook 'find-file-hook 'flymake-find-file-hook)

;; load and configure nav-mode
(require 'nav)
(nav-disable-overeager-window-splitting)
(global-set-key (kbd "<f8>") 'nav-toggle)

(defface nav-hl-line
  '((t :background "#777777")) ; change to what suits best your theme
  "Custom face for highlighting the current line in nav mode."
  :version "22.1"
  :group 'hl-line)

;; This allows global-hl-line be disabled for certain buffers (nav in our case)
(make-variable-buffer-local 'global-hl-line-mode)

(defun nav-mode-hl-hook ()
  (setq global-hl-line-mode nil)
  (set (make-local-variable 'hl-line-face) 'nav-hl-line)
  (hl-line-mode t)
  (local-set-key (kbd "<right>") 'nav-open-file-under-cursor)
  (local-set-key (kbd "<left>")  'nav-go-up-one-dir))

(add-hook 'nav-mode-hook 'nav-mode-hl-hook)