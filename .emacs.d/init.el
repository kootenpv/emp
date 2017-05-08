;;; .emacs - Pascal van Kooten <kootenpv@gmail.com>

;; DEFAULT-DIRECTORY SHOULD BE ONLY ONE NECCESSARY
(setq default-directory user-emacs-directory)

(setq emacsd (concat user-emacs-directory ".emacs.d/"))

(setq empinit (concat emacsd "init/"))

(setq custom-file (concat empinit "emp-custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq custom-theme-directory (concat emacsd "themes/"))

;;;;;;;; LOAD-PATHS: .emacs.d and all it's first level subdirecties.
(add-to-list 'load-path emacsd)
(dolist (f (directory-files emacsd))
  (let ((name (concat emacsd "/" f)))
    (when (and (file-directory-p name)
               (not (equal f ".."))
               (not (equal f ".")))
      (add-to-list 'load-path name))))

(message (concat emacsd "pkd"))

;; load external packages
(load (concat emacsd "package-loader.el"))

(setq backup-by-copying t
      backup-directory-alist `(("." . ,(concat default-directory "backups/")))
      delete-old-versions t
      kept-new-versions 10
      kept-old-versions 10
      version-control t)

(setq auto-save-file-name-transforms `((".*" ,(concat default-directory "auto-saves") t)))

;;; mode associations
(add-to-list 'auto-mode-alist '("\\.snippet\\'" . snippet-mode))

(add-to-list 'auto-mode-alist '("\\.gsp\\'" . html-mode))

(add-to-list 'auto-mode-alist '("\\.\\(pl\\|pro\\|lgt\\)" . prolog-mode))

(add-to-list 'auto-mode-alist '("\\.sol\\'" . solidity-mode))

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

;;; ensure bashrc is loaded in emacs
(when window-system (set-exec-path-from-shell-PATH))

(require 'server)
(or (server-running-p)
    (server-start))

;; (setq explicit-bash-args '("--noediting" "--login" "-i"))


(require 'emp-external-plugins)

(require 'emp-display)

(require 'emp-keybindings)

(require 'emp-misc-functions)

(require 'emp-misc-settings)

(require 'emp-c++)

(require 'emp-dired)

(setq default-directory (concat user-emacs-directory ".."))

(provide 'emp-init)
