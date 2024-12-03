
(menu-bar-mode -1)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; Alternatives for <C-return>, <S-return> and <C-S-return>, which are
;; unavailable on OS-X.  The following bindings cannot be triggered
;; directly via the terminal
;;
;; key             org-mode binding                         iTerm sends
;; ----------      ---------------------------------------  -----------
;; <C-return>      org-insert-heading-respect-content       Esc+[CR
;; <C-S-return>    org-insert-todo-heading-respect-content  Esc+[CSR
;; <M-S-return>    org-insert-todo-heading
;; <S-return>      prelude-insert-empty-line                Esc+[SR
;;
;; In iTerm Preferences Profiles, Keys, add control-return,
;; shift-return and control-shift-return to Send Escape Sequences:
(define-key key-translation-map (kbd "ESC [ C R")   (kbd "<C-return>"))
(define-key key-translation-map (kbd "ESC [ S R")   (kbd "<S-return>"))
(define-key key-translation-map (kbd "ESC [ C S R") (kbd "<C-S-return>"))

;; Historically, C-SPC has been set-mark; use ESC-SPC or M-SPC to expand-region
(global-set-key (kbd "C-@")             'set-mark-command)
(global-set-key (kbd "<M-space>")	'er/expand-region)

;; Navigation between multiframe-windows
(global-set-key (kbd "C-x p")           'previous-multiframe-window )
(global-set-key (kbd "C-x n")           'next-multiframe-window )

;; My bindings for next/previous error, and goto line (was M-g n/p/g)
(global-set-key (kbd "M-g")             'goto-line )
(global-set-key (kbd "C-x C-e")         'compile )
(global-set-key (kbd "C-x C-n")         'next-error )
(global-set-key (kbd "C-x C-p")         'previous-error )

;; Rectangles
(global-set-key (kbd "C-M-k")           'kill-rectangle)        ;; also C-x r k
(global-set-key (kbd "C-M-y")           'yank-rectangle)        ;; also C-x r y

(defun my-c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
  (c-set-offset 'substatement-open 0)
  ;; other customizations can go here

  (setq c++-tab-always-indent t)
  (setq c-basic-offset 4)                  ;; Default is 2
  (setq c-indent-level 4)                  ;; Default is 2

  ;;(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
  (setq tab-width 8)
  (setq indent-tabs-mode t)                ;; use spaces only if nil
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(global-auto-revert-mode t)

;; Bring in org-mode and configure
(require 'org)
(setq org-src-fontify-natively t)
(setq org-confirm-babel-evaluate nil)

;; Adjust the files ox-latex removes on LaTeX export; avoid the ToC related ones, .aux and .toc
;; - Export twice to generate ToC
(require 'ox-latex)
(setq org-latex-logfiles-extensions (quote ("bcf" "blg" "fdb_latexmk" "fls" "figlist" "idx" "log" "nav" "out" "ptc" "run.xml" "snm" "vrb" "xdv")))
(setq org-latex-remove-logfiles t)

;;(setq python-shell-interpreter "/usr/local/bin/python3")
;; Use ipython as default python interpreter for emacs-jupyter
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;;(setq org-babel-python-command "/usr/local/bin/ipython")

(require 'jupyter)
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (ditaa . t)
   (shell . t)
   (python . t)
   (jupyter . t)
   )
)

(setq org-ditaa-jar-path "/usr/local/opt/libexec/ditaa-0.11.0-standalone.jar")

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wheatgrass))
 '(fill-column 100)
 '(package-selected-packages
   '(org-inline-pdf jupyter gnu-elpa-keyring-update htmlize magit nix-mode rust-mode f s ob-mermaid))
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; replace selected text
(delete-selection-mode 1)

;; Mermaid in Org-Mode
(require 'ob-mermaid)
(setq ob-mermaid-cli-path "/usr/local/bin/mmdc")

;; Shell in Org-Mode
(require 'ob-shell)

;; Javascript Mode.  2-space indent, use spaces only
(setq js-indent-level 2)
(defun my-js-mode-hook ()
  "Custom `js-mode' behaviours."
  (setq indent-tabs-mode nil))
(add-hook 'js-mode-hook 'my-js-mode-hook)

(setq frame-background-mode 'dark)

(desktop-save-mode 1)
