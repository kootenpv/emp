(setq ido-file-extensions-order '(".py" ".r" ".tex" ".cpp" ".h" ".txt" ".el"))

(setq yas/key-syntaxes '("w_" "w_." "^ "))

(delete-selection-mode 1)

(set-fill-column 100)

(recentf-mode 1)
(setq recentf-max-saved-items 70)
(setq recentf-max-menu-items 70)


(normal-erase-is-backspace-mode 1)

(require 'uniquify)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")


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

(provide 'emp-misc-settings)
