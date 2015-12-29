;; Terrible module, but the best I have for now

(defvar eashy-buffer-counter 0)

(defvar eashy-shell-list (list))

(defvar eashy-last-buf nil)

(defun eashy-create ()
  (interactive)
  (setq eashy-buffer-counter (+ eashy-buffer-counter 1))
  (let ((new-shell (shell (format "shell-%d." eashy-buffer-counter))))
    (add-to-list 'eashy-shell-list new-shell)
    (setq eashy-shell-list eashy-shell-list))
  )

(defun eashy-switch-or-create ()
  (interactive)
  (if (eq major-mode 'shell-mode)
      (eashy-create)
    (when (not (eashy-goto-shell))
      (eashy-create))
    (setq eashy-last-buf (current-buffer))))

(defun eashy-goto-shell ()
  (interactive)
  (let (new-eash (list))
    (dolist (elt (buffer-list) new-eash)
      (when (string-match "shell" (buffer-name elt))
        (switch-to-buffer elt)
        (return t)))))


(provide 'eashy)
