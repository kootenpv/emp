;; Z can now unzip
;; z can add files to a .zip folder

(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
                '("\\.zip\\'" ".zip" "unzip")))

(eval-after-load "dired"
  '(define-key dired-mode-map "z" 'dired-zip-files))

(defun dired-zip-files (zip-file)
  "Create an archive containing the marked files."
  (interactive "sEnter name of zip file: ")

  ;; create the zip file
  (let ((zip-file (if (string-match ".zip$" zip-file) zip-file (concat zip-file ".zip"))))
    (shell-command
     (concat "zip "
             zip-file
             " "
             (concat-string-list
              (mapcar
               '(lambda (filename)
                  (file-name-nondirectory filename))
               (dired-get-marked-files))))))

  (revert-buffer)

  ;; remove the mark on all the files  "*" to " "
  ;; (dired-change-marks 42 ?\040)
  ;; mark zip file
  ;; (dired-mark-files-regexp (filename-to-regexp zip-file))
  )

(defun concat-string-list (list)
  "Return a string which is a concatenation of all elements of the list separated by spaces"
  (mapconcat '(lambda (obj) (format "%s" obj)) list " "))



;; Make sizes human-readable by default, sort version numbers
;; correctly, and put dotfiles and capital-letters first.
(setq-default dired-listing-switches "-alhv")
;;Normally, when I try to copy a directory, dired asks me if I really want to do a recursive copy. I always want to do this, and even if I didn't, the cost of accidentally starting a recursive copy isn't really all that bad. This stops dired from prompting me:
(setq dired-recursive-copies 'always)
;; Allow running multiple async commands simultaneously
(defadvice shell-command (after shell-in-new-buffer (command &optional output-buffer error-buffer))
  (when (get-buffer "*Async Shell Command*")
    (with-current-buffer "*Async Shell Command*"
      (rename-uniquely))))
(ad-activate 'shell-command)

(defun emp-dired-mode-hook ()
  ;; Let us have a key that puts the dired buffer into interactive renaming mode
  (local-set-key (kbd "C-c e") 'wdired-change-to-wdired-mode)
  (local-set-key (kbd "C-c C-e") 'wdired-change-to-wdired-mode)
  )

(setq dired-use-ls-dired nil)

(add-hook 'dired-mode-hook
          'emp-dired-mode-hook)

(provide 'emp-dired)
