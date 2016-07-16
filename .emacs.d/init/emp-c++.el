;;;; c++
(add-hook 'c++-mode-hook 'emp-c++-mode-hook)

(defun emp-c++-mode-hook ()

  (setq auto-mode-alist
    (append '(("\\.h$" . c++-mode)) auto-mode-alist))

  (setq auto-mode-alist
    (append '(("\\.c$" . c-mode)) auto-mode-alist))

  (setq auto-mode-alist
    (append '(("\\.cpp$" . c++-mode)) auto-mode-alist))

  (setq auto-mode-alist
    (append '(("\\.fs$" . c++-mode)) auto-mode-alist))

  )

(add-hook 'c++-mode-hook (lambda () (flymake-mode t)))

(defvar flymake-additional-compilation-flags nil)
(put 'flymake-additional-compilation-flags 'safe-local-variable 'listp)

;; no need to arrange Makefile
(defun flymake-cc-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name)))
         (common-args (append (list "-Wall" "-W" "-fsyntax-only" local-file)
                              flymake-additional-compilation-flags)))
    (list "g++" common-args)))

(loop for ext in '("\\.c$" "\\.h$" "\\.cc$" "\\.cpp$" "\\.hh$")
      do
      (push `(,ext flymake-cc-init) flymake-allowed-file-name-masks))

(add-hook 'c-mode-hook (lambda () (flymake-mode t)))
(add-hook 'c++-mode-hook (lambda () (flymake-mode t)))

(provide 'emp-c++)
