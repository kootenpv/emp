;;;;;;;;;;;;;;;;;
;;; Bookmarks ;;;
;;;;;;;;;;;;;;;;;

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(defun backward-delete-word ()
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive)
  (cond
   ((looking-back "\n")
    (backspace-blank-lines-or-char))
   ((looking-back "  ")
    (just-one-space))
   ((eq last-repeatable-command this-command)
    (delete-region (point) (progn (backward-word) (point))))
   (t
    (let ((case-fold-search nil))
      (delete-region (point) (search-backward-regexp "^\\|\\<\\|[A-Z]"))))))

(defun smart-backward-kill-word ()
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive)
  (kill-region (point) (progn (backward-word) (point)))
  (save-excursion
    (when  (looking-back "(")
      (append-next-kill)
      (kill-region (point) (progn (search-backward-regexp "[^(]" nil t) (+ (point) 1)))))
  )

(defun toggle-max-screen ()
  "Only for windows"
  (interactive)
  (w32-send-sys-command #xf030)
  )

(defun custom-lisp-executer ()
  (interactive)
  (save-excursion
    (mark-paragraph -1)
    (eval-region (region-beginning) (region-end ) t)
    (deactivate-mark)))

(defun kill-line-or-region ()
  (interactive)
  (cond
   ((region-active-p) (sp-kill-region (region-beginning) (region-end)))
   ((looking-at "[ ]*class")
    (py-kill-def-or-class))
   ((looking-at "[ ]*\\(def\\|async def\\)")
    (py-kill-paragraph))  ;; hack
   ((looking-at "[ ]*\\(for\\|if\\|elif\\|else\\|try\\|except\\|finally\\|while\\)")
    (next-line) ;; hack
    (py-kill-clause))
   ((looking-back "^[ ]*")
    (if (looking-at "[ ]*$")
        (delete-blank-lines)
      (back-to-indentation)
      (sp-kill-hybrid-sexp 1)))
   (t (sp-kill-sexp))))



(defun neq (obj1 obj2)
  (interactive)
  (not (eq obj1 obj2))
  )

(defun not-anymore ()
  "For overwriting wrong keybindings"
  (interactive)
  (message "not anymore")
  )

(global-set-key (kbd "C-x C-c") 'not-anymore)
(global-set-key (kbd "<insert>") 'not-anymore)

(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))

                  (set-window-buffer w1 b2)
                  (set-window-buffer w2 b1)
                  (set-window-start w1 s2)
                  (set-window-start w2 s1)
                  (setq i (1+ i))))))))

(defun cleanup-buffer-safe ()
  "Perform a bunch of safe operations on the whitespace content of a buffer.
Does not indent buffer, because it is used for a before-save-hook, and that
might be bad."
  (interactive)
  (when (not (string-match-p (regexp-quote "akefile") (buffer-file-name)))
    (untabify (point-min) (point-max))
    (delete-trailing-whitespace)
    (set-buffer-file-coding-system 'utf-8)))

;; Various superfluous white-space. Just say no.
(add-hook 'before-save-hook 'cleanup-buffer-safe)

(defun s-trim-left (s)
  "Remove whitespace at the beginning of S."
  (if (string-match "\\`[ \t\n\r]+" s)
      (replace-match "" t t s)
    s))



(defun delete-current-buffer-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(global-set-key (kbd "M-k") 'delete-current-buffer-file)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (when buffer-file-name
              (add-hook 'after-save-hook
                        'check-parens
                        nil t))))



(defun switch-to-previousbuffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(defun isearch-yank-selection ()
  "Put selection from buffer into search string."
  (interactive)
  (when (region-active-p)
    (deactivate-mark))
  (isearch-yank-internal (lambda () (mark))))


(defun delete-backwards-non-word ()
  (interactive)
  (while (not (looking-back "[a-zA-Z]"))
    (delete-char -1))
  )

(defun toggle-case ()
  (interactive)
  (when (region-active-p)
    (let ((i 0)
          (return-string "")
          (input (buffer-substring-no-properties (region-beginning) (region-end))))
      (while (< i (- (region-end) (region-beginning)))
        (let ((current-char (substring input i (+ i 1))))
          (if (string= (substring input i (+ i 1)) (downcase (substring input i (+ i 1))))
              (setq return-string
                    (concat return-string (upcase (substring input i (+ i 1)))))
            (setq return-string
                  (concat return-string (downcase (substring input i (+ i 1)))))))
        (setq i (+ i 1)))
      (delete-region (region-beginning) (region-end))
      (insert return-string))))



(setq linenumhere nil)

(defun linenumdif ()
  (interactive)
  (cond
   ((region-active-p)
    (message (concat "Lines: " (int-to-string (count-lines (region-beginning) (region-end))))))
   (linenumhere
    (message (concat "Lines: " (int-to-string (+ 1 (abs (- linenumhere (line-number-at-pos))))))))
   (t
    (setq linenumhere nil)
    (setq linenumhere (line-number-at-pos)))
   )
  )


(defun transpose-windows ()
  (interactive)
  (let ((this-buffer (window-buffer (selected-window)))
        (other-buffer (prog2
                          (other-window +1)
                          (window-buffer (selected-window))
                        (other-window -1))))
    (switch-to-buffer other-buffer)
    (switch-to-buffer-other-window this-buffer)
    (other-window -1)))

(defun my-clear ()
  (interactive)
  (if (eq major-mode eshell-mode)
      (let ((inhibit-read-only t))
        (erase-buffer)
        (eshell-send-input))
    (let ((comint-buffer-maximum-size 0))
      (comint-truncate-buffer)))
  )




(defun copy-buffer-file-name-as-kill(choice)
  "Copy the buffer-file-name to the kill-ring"
  (interactive "cCopy Buffer Name (F) Full, (D) Directory, (N) Name")
  (let ((new-kill-string)
        (name (if (eq major-mode 'dired-mode)
                  (dired-get-filename)
                (or (buffer-file-name) ""))))
    (cond ((eq choice ?f)
           (setq new-kill-string name))
          ((eq choice ?d)
           (setq new-kill-string (file-name-directory name)))
          ((eq choice ?n)
           (setq new-kill-string (file-name-nondirectory name)))
          (t (message "Quit")))
    (when new-kill-string
      (message "%s copied" new-kill-string)
      (kill-new new-kill-string))))



(defun all-over-the-screen ()
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (balance-windows)
  (follow-mode t))


(defun insert-file-name (filename &optional args)
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive `(,(ido-read-file-name "File Name: ")
                 ,current-prefix-arg))
 (insert (expand-file-name filename)))


(defun all-over-the-screen ()
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (balance-windows)
  (follow-mode t))


(defun reformat-xml ()
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (xml-reformat-tags))
  )

(defun grip ()
  (interactive)
  (compile (concat "grip " (buffer-file-name)))
  (browse-url "http://localhost:6419")
  )

(defun my-flyspell-save-word ()
  (interactive)
  (let ((current-location (point))
         (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word) current-location (cadr word) (caddr word) current-location))))

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(defun find-file-angular (arg)
  (find-file-existing (concat (file-name-sans-extension (buffer-file-name)) "." arg)))

(defun switch-angular ()
  (interactive)
  (cond
   ((string-equal (file-name-extension (buffer-file-name)) "ts") (find-file-angular "html"))
   ((string-equal (file-name-extension (buffer-file-name)) "html") (find-file-angular "ts"))))

(defun kooten-dired-zip-file ()
  "ZIP the current file and all subdir's; or unZIP if already a ZIP."
  (interactive)
  (let* ((fn (dired-get-filename)) (nd (file-name-nondirectory fn)) cmd msg)
    (cond ((and (string-match ".zip$" fn)
                (y-or-n-p (format "unzip %s? " fn)))
           (setq msg "unZIPing file %s..." cmd (concat "unzip " nd)))
          ((and (or (string-match ".tgz$" fn) (string-match ".tar.gz$" fn))
                (y-or-n-p (format "tar xfz `%s'? " fn)))
           (setq msg "unTAR/GZIPing file %s..." cmd (concat "tar xfz " nd)))
          ((and (or (string-match ".tbz2$" fn) (string-match ".tar.bz2$" fn))
                (y-or-n-p (format "tar xfj `%s'? " fn)))
           (setq msg "unTAR/BZIPing file %s..." cmd (concat "tar xfj " nd)))
          ((and (string-match ".tar$" fn)
                (y-or-n-p (format "tar xf `%s'? " fn)))
           (setq msg "unTARing file %s..." cmd (concat "tar xf " nd)))
          ((and (string-match ".rar$" fn)
                (y-or-n-p (format "unrar x `%s'? " fn)))
           (setq msg "unRARing file %s..." cmd (concat "unrar x " nd)))
          ((and (file-directory-p fn)
                (y-or-n-p (format "zip -rv9 `%s'? " fn)))
           (setq msg "ZIPing directory %s..."
                 cmd (concat "zip -rv9 " nd ".zip " nd)))
          ((y-or-n-p "(un?)compress? ") (dired-do-compress)))
    (when cmd
      (message msg fn)
      (shell-command (concat "cd " (file-name-directory fn) " && " cmd))
      (revert-buffer))))
(define-key dired-mode-map "Z" 'kooten-dired-zip-file)

(defun join-lines (arg)
  (interactive "p")
  (end-of-line)
  (delete-char 1)
  (delete-horizontal-space)
  (insert " "))

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let* ((name (buffer-name))
        (filename (buffer-file-name))
        (basename (file-name-nondirectory filename)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " (file-name-directory filename) basename nil basename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(provide 'emp-misc-functions)
