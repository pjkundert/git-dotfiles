;; Make use-package available
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize) ;; You might already have this line
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; All modes
(menu-bar-mode -1)
(global-auto-revert-mode t)
(delete-selection-mode 1)
(desktop-save-mode 1)

(setq frame-background-mode 'dark)

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

;(use-package expand-region
;  :bind (("<M-space>" . er/expand-region)))


(use-package flyspell
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))

;; org-mode configuration
(use-package org
  :config
  (setq org-src-fontify-natively t
        org-confirm-babel-evaluate nil)
  (add-hook 'org-mode-hook (lambda () (setq-local indent-tabs-mode nil))))

(use-package org-clock :after org :ensure nil)
;; Adjust the files ox-latex removes on LaTeX export; avoid the ToC related ones, .aux and .toc
;; - Export twice to generate ToC
(use-package ox-latex :after org :ensure nil
  :config
  (setq org-latex-logfiles-extensions
        '("bcf" "blg" "fdb_latexmk" "fls" "figlist" "idx"
          "log" "nav" "out" "ptc" "run.xml" "snm" "vrb" "xdv"))
  (setq org-latex-remove-logfiles t))

(defun org-dblock-write:weekly (params)
  (cl-flet ((fmttm (tm) (format-time-string (org-time-stamp-format t t) tm))
	    (format-hhmm (minutes)
              (format "%d:%02d"
                      (/ minutes 60)
                      (mod minutes 60))))
    (let ((file (or (plist-get params :file) (buffer-file-name)))
          (start (seconds-to-time
                  (org-matcher-time (plist-get params :tstart))))
          (end (seconds-to-time (org-matcher-time (plist-get params :tend)))))
      (while (time-less-p start end)
        (let ((next-week (time-add start
                                   (date-to-time "1970-01-08T00:00Z")))
              (week-begin (line-beginning-position))
              (week-minutes 0))
          (insert "\nWeekly Table from " (fmttm start) "\n")
          (insert "| Day of Week | Time |\n|-\n")
          (while (time-less-p start next-week)
            (let* ((next-day (time-add start (date-to-time "1970-01-02T00:00Z")))
                   (minutes
                    (with-current-buffer (find-file-noselect file)
                      (cadr (org-clock-get-table-data
                             file
                             (list :maxlevel 0
                                   :tstart (fmttm start)
                                   :tend (fmttm next-day)))))))
              (insert "|" (format-time-string "%a" start)
                      "|" (format-hhmm minutes)
                      "|\n")
              (org-table-align)
              (cl-incf week-minutes minutes)
              (setq start next-day)))
	  ;; Add weekly total row
          (when (> week-minutes 0)
            (insert "|-\n|*Total*|" (format-hhmm week-minutes) "|\n")
            (org-table-align))
          (when (equal week-minutes 0)
            (delete-region week-begin (line-beginning-position))))))))


;; org-mode babel configuration
(use-package ob-mermaid
  :after org
  :custom (ob-mermaid-cli-path "~/.nix-profile/bin/mmdc"))
(use-package ob-shell :after org :ensure nil)
(use-package jupyter :defer t)
(use-package ob-jupyter :after org :ensure jupyter)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)
   (shell . t)
   (python . t)
   (jupyter . t)))

(setq org-ditaa-jar-path "~/.nix-profile/lib/ditaa.jar")
(setq org-babel-ditaa-java-cmd "~/.nix-profile/bin/java")


;; Other mode configurations
(use-package company
  :ensure t
  :config
  (global-company-mode 1))

(use-package htmlize :defer t)
(use-package magit :defer t)
(use-package nix-mode :mode "\\.nix\\'")
(use-package rust-mode :defer t)
(use-package powershell :defer t)
(use-package rustic
  :init (setq rustic-format-on-save nil)
  :custom
  (rustic-cargo-use-last-stored-arguments t)
  (rustic-analyzer-command '("rustup" "run" "stable" "rust-analyzer"))
  (rustic-compile-command "make -C ... nix-test")
  (lsp-rust-analyzer-exclude-dirs ["node_modules/**", "target/**", "/nix/**", ".wasm_target/**" ])
  )

(use-package lsp-mode
  :defer t
  :config
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.wasm_target\\'")
  (setq lsp-enable-file-watchers nil))

(use-package ansi-color
  :ensure nil
  :config
  (defun colorize-compilation-buffer ()
    (let ((inhibit-read-only t))
      (ansi-color-apply-on-region (point-min) (point-max))))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer))

(load-theme 'wheatgrass t)

;; C-mode stuff
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

;; Javascript Mode.  2-space indent, use spaces only
(setq js-indent-level 2)
(defun my-js-mode-hook ()
  "Custom `js-mode' behaviours."
  (setq indent-tabs-mode nil))
(add-hook 'js-mode-hook 'my-js-mode-hook)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wheatgrass))
 '(fill-column 100)
 '(package-selected-packages
   '(codeium company htmlize jupyter lsp-mode magit nix-mode ob-mermaid org-inline-pdf powershell
	     rustic)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
