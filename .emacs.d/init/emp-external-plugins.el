;; suppress warnings introduced in recent emacs versions
(setq ad-redefinition-action 'accept)

;; needs to be early
(elscreen-start)
(setq elscreen-display-tab nil)

(elscreen-create)
(elscreen-create)
(elscreen-create)
(elscreen-create)
(elscreen-create)
(elscreen-create)
(elscreen-create)
(elscreen-create)
(elscreen-create)

;;(elscreen-separate-buffer-list-mode)

;(require 'ffap)

;(electric-pair-mode)<
(require 'yasnippet)
(yas/load-directory (concat emacsd "snippets"))
(setq yas-snippet-dirs (cons (concat emacsd "snippets") (yas-snippet-dirs)))
(yas-global-mode t)



(require 'multiple-cursors)

(require 'key-chord)
(key-chord-mode 1)

;; speeds up searching: C-x C-f for files,
;; (require 'ido)
;; (ido-mode t)
;; (ido-everywhere t)

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

;; ;;(require 'emp-r)

(require 'tempbuf)

(add-hook 'help-mode-hook 'turn-on-tempbuf-mode)        ; Idle help closed
;;(add-hook 'find-file-hooks 'turn-on-tempbuf-mode)       ; Idle unedited files closed
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

; (require 'tabbar-tweak)

;; (require 'init-cedet)  ; custom init

(defun yas/current-snippet-table (yas--get-snippet-tables))
(setq ac-auto-show-menu nil)


;; (require 'projectile)
;; (projectile-global-mode)

(require 'xml-parse)

;; (require 'frame-cmds)

(require 'json-reformat)
(defalias 'reformat-json 'json-reformat-region)

;; (require 'buffer-move)
(require 'dired+)
(require 'dired-x)
(require 'dired-fixups)

;; ;;; GROOVY

(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

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
(add-hook 'solidity-mode-hook 'git-gutter-mode)
(add-hook 'typescript-mode-hook 'git-gutter-mode)
(add-hook 'git-gutter:update-hooks 'magit-revert-buffer-hook)

(global-set-key (kbd "M-g M-s") 'git-gutter:stage-hunk)

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(require 'restclient)
(add-to-list 'auto-mode-alist '("\.rest$" . restclient-mode))


(require 'uniquify)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.gsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(setq web-mode-engines-alist
      '(("django"    . ".html"))
      )

(add-hook 'web-mode-hook 'rainbow-mode)

(add-hook 'web-mode-hook
          (lambda ()
            (define-key web-mode-map [tab]  '(lambda () (interactive) (jinja2-mode) (indent-for-tab-command) (web-mode)))
            (define-key web-mode-map [return]  '(lambda () (interactive) (jinja2-mode) (newline-and-indent) (web-mode)))))


(add-to-list 'auto-mode-alist '("\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\.tmpl$" . web-mode))

(setq web-mode-enable-auto-pairing t)

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; (defun elpy-add-import-on-save ()
;;   (elpy-importmagic-add-import "-")
;;   )

;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (add-hook 'after-save-hook 'elpy-add-import-on-save nil 'make-it-local)))

(require 'flymake-easy)
(require 'flymake-jslint)
(add-hook 'javascript-mode-hook (lambda () (flymake-mode t)))

(add-hook 'json-mode-hook (lambda () (flycheck-mode t)))
(add-hook 'yaml-mode-hook (lambda () (flycheck-mode t)))
(add-hook 'emacs-lisp-mode-hook (lambda () (flycheck-mode t)))

(require 'solidity-mode)
;; (require 'flymake-solidity)

(require 'flycheck)

(add-to-list 'auto-mode-alist '("\\.sol\\'" . solidity-mode))
(add-hook 'solidity-mode-hook '(lambda () (flycheck-mode t) (flycheck-set-checker-executable "/usr/local/bin/solc")))

;;(add-hook 'solidity-mode-hook (lambda () (c-set-style "awk")))

;; (add-hook 'markdown-mode-hook '(lambda () (flyspell-mode 1)))
;; (set-face-attribute 'flyspell-incorrect nil :underline "line")
;; (set-face-attribute 'flyspell-duplicate nil :underline "line")

;; (setq flyspell-duplicate-distance 0)

(require 'powerline)
(setq ns-use-srgb-colorspace nil)
(powerline-default-theme)

(require 'eashy)

(require 'ag)
(setq ag-ignore-list (list "node_modules" "*cache" "*.json" "*archive-contents"))

(require 'avy)

;; If use bundled typescript.el,
(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

;; sample config
(add-hook 'typescript-mode-hook
          (lambda ()
            (tide-setup)
            (flycheck-mode +1)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode +1)
            ;; company is an optional dependency. You have to
            ;; install it separately via package-install
            (require 'company)
            (company-mode-on)))

;; (require 'py-autopep8)
;; (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
;; (setq py-autopep8-options '("--max-line-length=99"))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(add-to-list 'auto-mode-alist '("\\.puml\\'" . puml-mode))
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . puml-mode))

(setq projectile-keymap-prefix (kbd "M-p"))
(projectile-global-mode)
(setq projectile-enable-caching t)

;ARCH_TODO
;(setq projectile-completion-system 'ivy)
;(add-to-list 'projectile-globally-ignored-directories "__pycache__")
;(add-to-list 'projectile-globally-ignored-files "*.pyc")
;(add-to-list 'projectile-globally-ignored-files "*cache")

;(add-to-list 'projectile-other-file-alist '("component.html" "component.ts"))
;(add-to-list 'projectile-other-file-alist '("component.ts" "component.html"))

;;(setq magit-completing-read-function 'ivy-completing-read)
(setq ivy-re-builders-alist
     '((ivy-switch-buffer . ivy--regex-plus)
       (t . ivy--regex-fuzzy)))
(setq ivy-initial-inputs-alist nil)

;(require 'realgud)

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Terminal notifier
;; requires 'brew install terminal-notifier'
;; stolen from erc-notifier

(defvar terminal-notifier-command (executable-find "terminal-notifier") "The path to terminal-notifier.")

; (terminal-notifier-notify "Emacs notification" "Something amusing happened")

(defun terminal-notifier-notify (title message)
  "Show a message with
terminal-notifier-command
."
  (start-process "terminal-notifier"
                 "terminal-notifier"
                 terminal-notifier-command
                 "-title" title
                 "-message" message
                 "-activate" "org.gnu.Emacs"))

(defun timed-notification (time msg)
  (interactive "sNotification when (e.g: 2 minutes, 60 seconds, 3 days): \nsMessage: ")
  (run-at-time time nil (lambda (msg) (terminal-notifier-notify "Emacs" msg)) msg))

;(require 'my-notmuch)

;(require 'my-elfeeds)

(provide 'emp-external-plugins)

(with-eval-after-load "persp-mode-autoloads"
  (setq wg-morph-on nil) ;; switch off animation
  (setq persp-autokill-buffer-on-remove 'kill-weak)
  (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))

(with-eval-after-load "persp-mode-autoload"
  (with-eval-after-load "dired"
    (def-auto-persp "dired"
      :parameters '((dont-save-to-file . t))
      :mode 'dired-mode
      :dyn-env '(after-switch-to-buffer-functions ;; prevent recursion
                 (persp-add-buffer-on-find-file nil)
                 persp-add-buffer-on-after-change-major-mode)
      :hooks '(after-switch-to-buffer-functions)
      :switch 'window)))


;; (defvar config-layouts-after-find-file-hook nil)
;; (def-auto-persp "projectile"
;;   :parameters '((dont-save-to-file . t))
;;   :hooks '(config-layouts-after-find-file-hook)
;;   :switch 'frame
;;   :predicate
;;   (lambda (_buffer)
;;     (when (and (buffer-file-name) (projectile-project-p))

;;       t))
;;   :get-name-expr
;;   (lambda ()
;;     (abbreviate-file-name (projectile-project-root))))

(add-hook 'haskell-mode-hook 'intero-mode)
(add-hook 'haskell-mode-hook '(lambda () (interactive-haskell-mode 1)))
(add-hook 'haskell-mode-hook 'hi2-mode)
(add-hook 'haskell-mode-hook 'eldoc-mode)

(setq pytest-cmd-flags "--cov")

;(require 'json-snatcher)

; (diredp-toggle-find-file-reuse-dir 1)

(require 'dired-aux)

(defalias 'dired-do-create-files 'lawlist-dired-do-create-files)

(defun lawlist-dired-do-create-files (op-symbol file-creator operation arg
  &optional marker-char op1 how-to)
"(1) If the path entered by the user in the mini-buffer ends in a trailing
forward slash /, then the code assumes the path is a directory -- to be
created if it does not already exist.; (2) if the trailing forward slash
is omitted, the code prompts the user to specify whether that path is a
directory."
  (or op1 (setq op1 operation))
  (let* (
      skip-overwrite-confirmation
      (fn-list (dired-get-marked-files nil arg))
      (rfn-list (mapcar (function dired-make-relative) fn-list))
      (dired-one-file  ; fluid variable inside dired-create-files
        (and (consp fn-list) (null (cdr fn-list)) (car fn-list)))
      (target-dir
         (if dired-one-file
           (dired-get-file-for-visit) ;; filename if one file
           (dired-dwim-target-directory))) ;; directory of multiple files
      (default (and dired-one-file
              (expand-file-name (file-name-nondirectory (car fn-list))
              target-dir)) )
      (defaults (dired-dwim-target-defaults fn-list target-dir))
      (target (expand-file-name ; fluid variable inside dired-create-files
        (minibuffer-with-setup-hook (lambda ()
          (set (make-local-variable 'minibuffer-default-add-function) nil)
          (setq minibuffer-default defaults))
          (dired-mark-read-file-name
             (concat (if dired-one-file op1 operation) " %s to: ")
             target-dir op-symbol arg rfn-list default))))
      (unmodified-initial-target target)
      (into-dir (cond ((null how-to)
        (if (and (memq system-type '(ms-dos windows-nt cygwin))
           (eq op-symbol 'move)
           dired-one-file
           (string= (downcase
               (expand-file-name (car fn-list)))
              (downcase
               (expand-file-name target)))
           (not (string=
           (file-name-nondirectory (car fn-list))
           (file-name-nondirectory target))))
            nil
          (file-directory-p target)))
       ((eq how-to t) nil)
       (t (funcall how-to target)))))
    (if (and (consp into-dir) (functionp (car into-dir)))
        (apply (car into-dir) operation rfn-list fn-list target (cdr into-dir))
      (or into-dir (setq target (directory-file-name target)))
      ;; create new directories if they do not exist.
      (when
          (and
            (not (file-directory-p (file-name-directory target)))
            (file-exists-p (directory-file-name (file-name-directory target))))
        (let ((debug-on-quit nil))
          (signal 'quit `(
            "A file with the same name as the proposed directory already exists."))))
      (when
          (and
            (not (file-exists-p (directory-file-name (expand-file-name target))))
            (or
              (and
                (null dired-one-file)
                (not (string-match "\\(.*\\)\\(/$\\)" unmodified-initial-target)))
              (not (file-directory-p (file-name-directory target)))
              (string-match "\\(.*\\)\\(/$\\)" unmodified-initial-target)) )
        (let* (
            new
            list-of-directories
            list-of-shortened-directories
            string-of-directories-a
            string-of-directories-b
            (max-mini-window-height 3)
            (expanded (directory-file-name (expand-file-name target)))
            (try expanded) )
          ;; Find the topmost nonexistent parent dir (variable `new')
          (while (and try (not (file-exists-p try)) (not (equal new try)))
            (push try list-of-directories)
            (setq new try
            try (directory-file-name (file-name-directory try))))
          (setq list-of-shortened-directories
              (mapcar
                (lambda (x) (concat "..." (car (cdr (split-string x try)))))
                list-of-directories))
          (setq string-of-directories-a
            (combine-and-quote-strings list-of-shortened-directories))
          (setq string-of-directories-b (combine-and-quote-strings
            (delete (car (last list-of-shortened-directories))
              list-of-shortened-directories)))
          (if
              (and
                (not (string-match "\\(.*\\)\\(/$\\)" unmodified-initial-target))
                ;; (cdr list-of-directories)
                dired-one-file
                (file-exists-p dired-one-file)
                (not (file-directory-p dired-one-file)))
            (if (y-or-n-p
                (format "Is `%s` a directory?" (car (last list-of-directories))))
              (progn
                (or (y-or-n-p (format "@ `%s`, create:  %s" try string-of-directories-a))
                    (let ((debug-on-quit nil))
                      (signal 'quit `("You have exited the function."))))
                (make-directory expanded t)
                (setq into-dir t))
              (if (equal (file-name-directory target) (file-name-directory dired-one-file))
                (setq new nil)
                (or (y-or-n-p
                      (format "@ `%s`, create:  %s" try string-of-directories-b))
                    (let ((debug-on-quit nil))
                      (signal 'quit `("You have exited the function."))))
                (make-directory (car (split-string
                  (car (last list-of-directories))
                  (concat "/" (file-name-nondirectory target)))) t)
                (setq target (file-name-directory target))
                (setq into-dir t) ))
            (or (y-or-n-p (format "@ `%s`, create:  %s" try string-of-directories-a))
                (let ((debug-on-quit nil))
                  (signal 'quit `("You have exited the function."))))
            (make-directory expanded t)
            (setq into-dir t) )
          (when new
            (dired-add-file new)
            (dired-move-to-filename))
          (setq skip-overwrite-confirmation t) ))
      (lawlist-dired-create-files file-creator operation fn-list
        (if into-dir      ; target is a directory
          (function (lambda (from)
            (expand-file-name (file-name-nondirectory from) target)))
          (function (lambda (_from) target)))
       marker-char skip-overwrite-confirmation ))))

(defun lawlist-dired-create-files (file-creator operation fn-list name-constructor
          &optional marker-char skip-overwrite-confirmation)
  (let (dired-create-files-failures failures
  skipped (success-count 0) (total (length fn-list)))
    (let (to overwrite-query overwrite-backup-query)
      (dolist (from fn-list)
        (setq to (funcall name-constructor from))
        (if (equal to from)
            (progn
              (setq to nil)
              (dired-log "Cannot %s to same file: %s\n"
                         (downcase operation) from)))
        (if (not to)
            (setq skipped (cons (dired-make-relative from) skipped))
          (let* ((overwrite (file-exists-p to))
                 (dired-overwrite-confirmed ; for dired-handle-overwrite
                  (and overwrite (not skip-overwrite-confirmation)
                       (let ((help-form '(format "\
Type SPC or `y' to overwrite file `%s',
DEL or `n' to skip to next,
ESC or `q' to not overwrite any of the remaining files,
`!' to overwrite all remaining files with no more questions." to)))
                         (dired-query 'overwrite-query
                                      "Overwrite `%s'?" to))))
                 ;; must determine if FROM is marked before file-creator
                 ;; gets a chance to delete it (in case of a move).
                 (actual-marker-char
                  (cond  ((integerp marker-char) marker-char)
                         (marker-char (dired-file-marker from)) ; slow
                         (t nil))))
            (let ((destname (file-name-directory to)))
              (when (and (file-directory-p from)
                         (file-directory-p to)
                         (eq file-creator 'dired-copy-file))
                (setq to destname))
        ;; If DESTNAME is a subdirectory of FROM, not a symlink,
        ;; and the method in use is copying, signal an error.
        (and (eq t (car (file-attributes destname)))
       (eq file-creator 'dired-copy-file)
       (file-in-directory-p destname from)
       (error "Cannot copy `%s' into its subdirectory `%s'"
        from to)))
            (condition-case err
                (progn
                  (funcall file-creator from to dired-overwrite-confirmed)
                  (if overwrite
                      ;; If we get here, file-creator hasn't been aborted
                      ;; and the old entry (if any) has to be deleted
                      ;; before adding the new entry.
                      (dired-remove-file to))
                  (setq success-count (1+ success-count))
                  (message "%s: %d of %d" operation success-count total)
                  (dired-add-file to actual-marker-char))
              (file-error    ; FILE-CREATOR aborted
               (progn
                 (push (dired-make-relative from)
                       failures)
                 (dired-log "%s `%s' to `%s' failed:\n%s\n"
                            operation from to err))))))))
    (cond
     (dired-create-files-failures
      (setq failures (nconc failures dired-create-files-failures))
      (dired-log-summary
       (format "%s failed for %d file%s in %d requests"
    operation (length failures)
    (dired-plural-s (length failures))
    total)
       failures))
     (failures
      (dired-log-summary
       (format "%s failed for %d of %d file%s"
    operation (length failures)
    total (dired-plural-s total))
       failures))
     (skipped
      (dired-log-summary
       (format "%s: %d of %d file%s skipped"
    operation (length skipped) total
    (dired-plural-s total))
       skipped))
     (t
      (message "%s: %s file%s"
         operation success-count (dired-plural-s success-count)))))
  (dired-move-to-filename))

(setq web-mode-enable-current-element-highlight t)

;(require 'smartparens-config)
;(smartparens-global-mode t)
;(show-smartparens-global-mode -1)
(show-smartparens-global-mode t)

(add-hook 'nxml-mode-hook '(lambda() (show-smartparens-global-mode -1)))

(setq sp-escape-quotes-after-insert nil
      sp-escape-wrapped-region nil)

(require 'wgrep)

(define-key wgrep-mode-map (kbd "C-,") 'mc/mark-previous-like-this)
(define-key wgrep-mode-map (kbd "C-.") 'mc/mark-next-like-this)
(define-key wgrep-mode-map (kbd "C-*") 'mc/mark-all-like-this)

(add-hook 'ag-mode-hook 'turn-on-tempbuf-mode)

(require 'smartparens-config)

(require 'smartparens-python)

(require 'modulous)

(require 'counsel)

(require 'howdoi)

(electric-pair-mode 1)

(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)
(setq wgrep-enable-key "e")


(ido-sort-mtime-mode 1)
(setq ido-sort-mtime-tramp-files-at-end nil)
(setq ido-sort-mtime-dot-at-beginning t)
(setq ido-show-dot-for-dired nil)

(setq ido-use-filename-at-point nil)

(add-to-list 'auto-mode-alist '(".crontab\\'" . crontab-mode))

(defun crontab-mode-key-hook ()
  (define-key crontab-mode-map (kbd "C-x C-s") 'crontab-save-and-apply)
  (define-key crontab-mode-map (kbd "C-x s") 'crontab-save-and-apply))

(add-hook 'crontab-mode-hook 'crontab-mode-key-hook)

(defun smart-reformat-json ()
  (interactive)
  (when (not (region-active-p))
    (mark-whole-buffer))
  (reformat-json (region-beginning) (region-end)))

(setq nim-nimsuggest-path "/home/pascal/.nimble/Nim/bin/nimsuggest")
;; Currently nimsuggest doesn't support nimscript files, so only nim-mode...
(add-hook 'nim-mode-hook 'nimsuggest-mode)
;; if you installed company-mode (optional)
(add-hook 'nim-mode-hook 'company-mode)
(add-hook 'nimscript-mode-hook 'company-mode)

(require 'f)
(defun log-find-visits ()
  (when (and buffer-file-name (not (eq last-command "xah-close-current-buffer")))
      (f-append-text (concat (int-to-string (float-time)) "," buffer-file-name "\n") 'utf-8 "/home/pascal/egoroot/emp/log-find-visits.txt")))

(add-hook 'find-file-hook 'log-find-visits)

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))



(defun xml-pretty-print (beg end &optional arg)
  "Reformat the region between BEG and END.
    With optional ARG, also auto-fill."
  (interactive "*r\nP")
  (let ((fill (or (bound-and-true-p auto-fill-function) -1)))
    (sgml-mode)
    (when arg (auto-fill-mode))
    (sgml-pretty-print beg end)
    (nxml-mode)
    (auto-fill-mode fill)))

(persistent-scratch-autosave-mode 1)
(setq initial-major-mode 'markdown-mode)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(defun dictwrap ()
  (interactive)
  (mark-paragraph)
  (sp-wrap-with-pair "{")
  (smart-indent-region))

(require 'realgud)
