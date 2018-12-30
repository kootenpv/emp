(setq ido-file-extensions-order '(".py" ".md" ".ts" ".html" ".r" ".tex" ".cpp" ".h" ".txt" ".el" ".js" ".rst"))

(setq yas/key-syntaxes '("w_" "w_." "^ "))

(delete-selection-mode 1)

(setq load-prefer-newer t)

(set-fill-column 100)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 70)
(setq recentf-max-menu-items 70)
(run-at-time nil (* 5 60) 'recentf-save-list)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(normal-erase-is-backspace-mode 1)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward uniquify-separator ":")


;;;;;;;;   Ignore certain extensions   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice completion--file-name-table (after
                                        ignoring-backups-f-n-completion
                                        activate)
  "Filter out results when they match `completion-ignored-extensions'."
  (let ((res ad-return-value))
    (if (and (listp res)
             (stringp (car res))
             (cdr res))                 ; length > 1, don't ignore sole match
        (setq ad-return-value
              (completion-pcm--filename-try-filter res)))))

(add-to-list 'completion-ignored-extensions '".nav")
(add-to-list 'completion-ignored-extensions '".log")
(add-to-list 'completion-ignored-extensions '".snm")
(add-to-list 'completion-ignored-extensions '".synctex.gz")
(add-to-list 'completion-ignored-extensions '".out")
(add-to-list 'ido-ignore-files '"*#*")
(setq ido-ignore-extensions t)
(add-to-list 'ido-ignore-buffers '"ESS")
(add-to-list 'ido-ignore-buffers '"Help")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; To solve visual bug on darwin
(if (eq system-type 'darwin)
    (setq ring-bell-function (lambda () (message "*wooooooooooooooooooooooooooooop*")))
  )

(defalias 'asc 'async-shell-command)

(setq dired-dwim-target t)


;; Change the display of the cursor when it can fire
(defun yasnippet-can-fire-p (&optional field)
  (interactive)
  (setq yas--condition-cache-timestamp (current-time))
  (let (templates-and-pos)
    (unless (and yas-expand-only-for-last-commands
                 (not (member last-command yas-expand-only-for-last-commands)))
      (setq templates-and-pos (if field
                                  (save-restriction
                                    (narrow-to-region (yas--field-start field)
                                                      (yas--field-end field))
                                    (yas--templates-for-key-at-point))
                                (yas--templates-for-key-at-point))))

  (set-cursor-color (if (and templates-and-pos (first templates-and-pos))
                        (face-attribute 'success :foreground)
                      (face-attribute 'font-lock-function-name-face :foreground)))))

(add-hook 'post-command-hook 'yasnippet-can-fire-p)

(set-default 'truncate-lines t)

(autoload 'comint-dynamic-complete-filename "comint" nil t)

(setenv "TMPDIR" "/tmp")

;; tramp use sudo: /sudo:mediqt:<enter>
(require 'tramp)
(setq tramp-default-method "ssh")
(tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "/etc/ssh_config")
                                 (tramp-parse-sconfig "~/.ssh/config")))
(add-to-list 'tramp-default-proxies-alist '(".*" "\`root\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))

(defadvice projectile-project-root (around ignore-remote first activate)
  (unless (file-remote-p default-directory) ad-do-it))

(setq compilation-always-kill t)

(defun tscbuild ()
 (when (or (eq major-mode 'typescript-mode) (eq major-mode 'web-mode))
 (start-process "tscbuild" nil "npm" "run" "build")))

(add-hook 'after-save-hook 'tscbuild)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-diff-options "-w")
(winner-mode)
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)

(defun ora-ediff-hook ()
  (ediff-setup-keymap)
  (define-key ediff-mode-map "j" 'ediff-next-difference)
  (define-key ediff-mode-map "k" 'ediff-previous-difference))

(add-hook 'ediff-mode-hook 'ora-ediff-hook)

;; Terminal buffer configuration.
(add-hook 'term-mode-hook 'my-term-mode-hook)
(defun my-term-mode-hook ()
  ;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=20611
  (setq bidi-paragraph-direction 'left-to-right))

(setq mouse-autoselect-window t)

(add-hook 'sh-mode-hook 'flycheck-mode)

(display-battery-mode 1)
(setq display-time-24hr-format t
      display-time-day-and-date t)

             (display-time)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; (defun minibuffer-complete ()
;;   (interactive)
;;   (ignore-errors (minibuffer-complete)))

;(setq debug-on-error t)

; ensure middle mouse button yanks at point and not where the mouse is located
(setq mouse-yank-at-point t)

(provide 'emp-misc-settings)

(setq js-indent-level 2)

(setq ivy-re-builders-alist
      '((ivy-switch-buffer . ivy--regex-plus)
        (t . ivy--regex-fuzzy)))
