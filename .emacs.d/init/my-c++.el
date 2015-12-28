;;;; c++

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(defun my-c++-mode-hook ()

  (setq auto-mode-alist
    (append '(("\\.h$" . c++-mode)) auto-mode-alist))

  (setq auto-mode-alist
    (append '(("\\.c$" . c-mode)) auto-mode-alist))

  (setq auto-mode-alist
    (append '(("\\.cpp$" . c++-mode)) auto-mode-alist))

  (setq auto-mode-alist
    (append '(("\\.fs$" . c++-mode)) auto-mode-alist))

  (defun g-compile-run ()
    (interactive)
    (save-buffer)
    (shell-command (concat "g++ -std=c++11 " (buffer-file-name)
               " -o " (substring (buffer-file-name) 0 -4)))
    (shell-command (substring (buffer-file-name) 0 -4))
    )

  (defun g-compile-so ()
    (interactive)
    (save-buffer)
    (let ((filename (concat "g++ -shared -fPIC " (buffer-file-name)
                " -o " (file-name-directory (buffer-file-name))
                "lib" (substring (buffer-name) 0 -4) ".so")))
      (shell-command filename)
      (message filename))
    )

  (defun c++-semi-colon ()
    (interactive)
    (end-of-line)
    (insert ";")
    )

  (define-key c++-mode-map (kbd "C-c c") 'g-compile-run)
  (define-key c++-mode-map (kbd ";") 'c++-semi-colon)
  (define-key c++-mode-map (kbd "C-c n") 'next-error)

  )

(provide 'my-c++)
