;; suppress warnings introduced in recent emacs versions
(setq ad-redefinition-action 'accept)

(require 'ffap)

(electric-pair-mode)
(require 'yasnippet)
(yas/load-directory (concat emacsd "snippets"))
(setq yas-snippet-dirs (concat emacsd "snippets"))
(yas-global-mode t)

(require 'multiple-cursors)

(require 'key-chord)
(key-chord-mode 1)

;; speeds up searching: C-x C-f for files,
(require 'ido)
(ido-mode t)
(ido-everywhere t)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(require 'navi)

(require 'imenu-anywhere)

;; enabling dynamic expansion
(setq dabbrev-abbrev-char-regexp "\\sw\\|\\s_\\|s.")
(setq dabbrev-case-fold-search t)

;; Represent undo-history as an actual tree (visualize with C-x u)
(setq undo-tree-mode-lighter "")
(require 'undo-tree)
(global-undo-tree-mode)

(require 'next-at-point) ;increment number or letter at point ,bound to C-+

(require 'smart)

(require 'switch-window)

;;(require 'emp-r)

(require 'tempbuf)

(add-hook 'help-mode-hook 'turn-on-tempbuf-mode)        ; Idle help closed
(add-hook 'find-file-hooks 'turn-on-tempbuf-mode)       ; Idle unedited files closed
(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)       ; Idle dired closed
;;(add-hook 'ess-help-mode-hook 'turn-on-tempbuf-mode)        ; Idle ESS help closed
(add-hook 'completion-list-mode-hook 'turn-on-tempbuf-mode) ; Idle completion closed
(add-hook 'vc-annotate-mode-hook 'turn-on-tempbuf-mode)     ; Idle VC annotate closed
(add-hook 'log-view-mode-hook 'turn-on-tempbuf-mode)        ; Idle VC change log closed
(add-hook 'diff-mode-hook 'turn-on-tempbuf-mode)        ; Idle VC diff closed

;; eldoc mode for lispy languages
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(autoload 'python-mode "emp-python" "" t)


;; folding

(add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
;;(add-hook 'ess-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)

(require 'etags-select)

(require 'tabbar-tweak)

;; (require 'init-cedet)  ; custom init

(defun yas/current-snippet-table (yas--get-snippet-tables))
(setq ac-auto-show-menu nil)


;; (require 'projectile)
;; (projectile-global-mode)

(require 'xml-parse)

;; (require 'frame-cmds)

(require 'json-reformat)

;; (require 'buffer-move)

(require 'dired-fixups)

;;; GROOVY

(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.ts$" . ts-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(require 'magit)

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      ;;(list "epylint" (list local-file))
      (list (concat emacsd "pyflymake.py") (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

(require 'flymake-cursor)

(require 'git-gutter)
(add-hook 'python-mode-hook 'git-gutter-mode)
(add-hook 'emacs-lisp-mode-hook 'git-gutter-mode)
(add-hook 'git-gutter:update-hooks 'magit-revert-buffer-hook)

(global-set-key (kbd "M-g M-s") 'git-gutter:stage-hunk)

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(require 'restclient)
(add-to-list 'auto-mode-alist '("\.rest$" . restclient-mode))


(require 'uniquify)

(require 'web-mode)

(setq web-mode-engines-alist
      '(("django"    . ".html"))
      )

(add-to-list 'auto-mode-alist '("\.html$" . web-mode))

(setq web-mode-enable-auto-pairing t)

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(defun elpy-add-import-on-save ()
  (elpy-importmagic-add-import "-")
  )

(add-hook 'python-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'elpy-add-import-on-save nil 'make-it-local)))

(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=99"))

(require 'flymake-easy)
(require 'flymake-jslint)
(add-hook 'javascript-mode-hook
          (lambda () (flymake-mode t)))

(require 'flycheck)
(require 'solidity-mode)

(require 'powerline)
(setq ns-use-srgb-colorspace nil)
(powerline-default-theme)


(require 'ag)

(require 'avy)

(provide 'emp-external-plugins)
