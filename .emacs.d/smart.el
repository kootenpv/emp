;; FIX:
;; smart delete  and  smart backspace
;; integrate smart pairs

;; smart.el --- Pascal Van Kooten <kootenpv@gmail.com>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; This variable will be used for repeating commands.

(defvar smart-last-command 0)


;; (defun smart-yas ()
;;   (interactive)
;;   (if (not (looking-at "\\s-*("))
;;       (yas-expand)
;;     (yas-expand)
;;     (save-excursion
;;       (search-forward ")")
;;       (delete-char -1)
;;       (end-of-line)
;;       (search-backward ")" nil t)
;;       (insert ")")))
;;   )

(defvar smart-number-counter 1)

(defadvice set-mark-command (before rest-smart-number activate)
  (setq smart-numbers (list (point))
        smart-number-counter 1)
  )

(defun smart-switcher ()
  (interactive)
  (if (region-active-p)
      (cond
       ((> smart-number-counter 2)
        (setq smart-numbers (append smart-numbers (list (point))))

        ;; To make sure we end up at the last called place.
        (goto-char (nth 3 smart-numbers))

        (setq smart-numbers (sort smart-numbers '<))

        (save-excursion
          (let ((first (apply 'min smart-numbers))
                (second (nth 1 smart-numbers))
                (third (nth 2 smart-numbers))
                (fourth (apply 'max smart-numbers)))

            (let ((firsttext (buffer-substring-no-properties first second))
                  (secondtext (buffer-substring-no-properties third fourth)))

              (delete-region first second)
              (goto-char (- third (- second first)))

              (insert firsttext)
              (delete-region third fourth)
              (goto-char first)
              (insert secondtext)))

          (setq smart-number-counter 0)))

       (t
        (setq smart-numbers (append smart-numbers (list (point))))
        (incf smart-number-counter)))
    (setq smart-number-counter 0)
    (insert " "))
  )

;; (set-cursor-color (if (and templates-and-pos (first templates-and-pos))
;;                       "green" "red"))))

(defun smart-comment ()
  (interactive)
  (cond
   ((smart-when-repeat-command 4 'sc-move-back-to-insert-extra-comment))
   ((smart-when-repeat-command 3 'sc-undo-comments-then-insert-three-comments))
   ((smart-when-repeat-command 2 'sc-undo-comments-then-mark-and-comment-paragraph))
   ((smart-when-repeat-command 1 'sc-move-back-to-insert-extra-comment))
   (t (sc-when-no-repeat) (setq smart-last-command 0))
   )
  (incf smart-last-command)
  )

(defun smart-when-repeat-command (number function)
  (if (and (eq last-repeatable-command this-command) (>= smart-last-command number))
      (progn (funcall function) t)
    nil)
  )

(defun sc-when-no-repeat ()
  (cond
   ((region-active-p) (comment-region (region-beginning) (region-end)))
   ((or (bobp) (looking-back "\\\\")) (insert comment-start))
   ((or (bolp) (looking-back comment-start)) (insert comment-start " "))
   ((looking-at comment-start) (skip-chars-forward comment-start) (insert comment-start))
   (t (end-of-line) (just-one-space) (insert comment-start " ")))
  )

(defun sc-move-back-to-insert-extra-comment ()
  (backward-char 1)  (insert comment-start) (forward-char 1)
  )

(defun sc-undo-comments-then-mark-and-comment-paragraph ()
  (save-excursion
    (delete-char -3)
    (mark-paragraph -1)
    (comment-region (region-beginning) (region-end)))
  )

(defun sc-undo-comments-then-insert-three-comments ()
  (save-excursion
    (mark-paragraph -1)
    (uncomment-region (region-beginning) (region-end)))
  (insert comment-start comment-start comment-start " ")
  )

(defun smart-uncomment ()
  (interactive)
  (save-excursion
    (when (eq last-repeatable-command 'smart-uncomment)
      (undo)
      (mark-paragraph -1))
    (or
     (if (region-active-p)
         (uncomment-region (region-beginning) (region-end))
       (back-to-indentation)
       nil)
     (if (looking-at comment-start)
         (sc-check-start)
       (sc-end)))))

(defun sc-check-start ()
  (while (looking-at comment-start)
    (delete-char 1))
  (indent-for-tab-command)
  )

(defun sc-end ()
  (search-forward comment-start nil t)
  (backward-char 1)
  (kill-line)
  )


(defun smart-beginning-of-line ()
  (interactive)
  (if (bolp)
      (beginning-of-line-text)
    (move-beginning-of-line 1))
  )

(defun smart-end-of-line ()
  (interactive)
  (if (not (eolp))
      (end-of-line)
    (move-beginning-of-line 1)
    (let ((whitespace-and-comment (concat " \t" comment-start)))
      (skip-chars-forward whitespace-and-comment)
      (if (search-forward comment-start (line-end-position) t)
          (skip-chars-backward whitespace-and-comment)
        (end-of-line)
        (search-backward-regexp "[)};]" (line-beginning-position) t)
        (goto-char (1+ (point)))))
    )
  )

;; Smart hooks

(defadvice autopair-skip-close-maybe (before smart-advice-close activate)
  (when (looking-back " \\{2,\\}")
    (just-one-space)
    (delete-char -1))
  )

(defadvice forward-paragraph (after smart-center activate)
  (recenter))


(provide 'smart)

;;; smart.el ends here


(defvar smart-frame-save nil)


(defun smart-delete-or-restore-windows ()
  (interactive)
  (if (one-window-p)
      (jump-to-register smart-frame-save)
    (frame-configuration-to-register smart-frame-save)
    (delete-other-windows)
    )
  )

(defun smart-find-at-point ()
  (interactive)

  (cond

   ((ffap-guess-file-name-at-point)
    (find-file-at-point)
    t)

   ((and (symbol-at-point) (boundp (symbol-at-point)))
    (describe-variable (symbol-at-point)))

   ((function-called-at-point)
    (delete-other-windows)
    (describe-function (function-called-at-point))
    (other-window 1)
    (toggle-max-screen)
    (split-window-vertically)
    (find-function (function-called-at-point))
    (other-window -1)
    (call-interactively 'minibuffer-keyboard-quit))

   (t
    (call-interactively 'describe-variable)))

  )

(defun delete-blank-lines-or-char ()
  (interactive)
  (cond
   ((region-active-p) (delete-region (region-beginning) (region-end)))
   ((looking-at "\n\n") (delete-blank-lines))
   ((looking-at "\\s-*\n[\\s-]*") (just-one-space) (delete-char 1) (just-one-space))
   ((looking-at "  ") (just-one-space))
   (t (delete-char 1)))
  )

(defun backspace-blank-lines-or-char ()
  (interactive)
  (cond
   ((region-active-p) (delete-region (region-beginning) (region-end)))
   ((smart-delete-pairs-around))
   ((looking-back "\n\n\\s-+")
    (while (or (looking-back "\\s-") (looking-back "\n"))
      (delete-char -1))
    (insert "\n\n")
    (indent-for-tab-command))
   ((looking-back "\n\n\n") (previous-line) (delete-blank-lines) (next-line))
   ((looking-back "\n\n") (previous-line) (delete-blank-lines))
   ((looking-back "\n\\s-+") (just-one-space) (delete-char -2) (just-one-space))
   (t (backward-delete-char 1)))
  )



(defun smart-indent-region ()
  (interactive)
  (save-excursion
    (if (not (region-active-p))
        (mark-paragraph))
    (indent-region (region-beginning) (region-end)))
  )

(defun tgrep (str)
  (interactive "sgrep for: ")
  (let ((fname (file-name-nondirectory (buffer-file-name))))
    (async-shell-command
     (concat "grep -rsnH \"" str "\" . --include=\""
             (if (cl-search "." (file-name-nondirectory (buffer-file-name))) "*." "")
             (car (last (split-string fname "\\."))) "\"")))
  )

(defun ggrep (str)
  (interactive "sgrep for: ")
  (async-shell-command (concat "grep -rsnH \"" str "\" ."))
  )



(defun smart-delete-pairs-around ()
  ;; problem so far is the need for extra division between backspace and del
  (setq smart-skipper nil)
  (let (value
        (count 0))
    (dotimes (number (length smart-pair-alist) value)
      (cond
       ((and (looking-back (regexp-quote (car (nth count smart-pair-alist))))
             (looking-at (regexp-quote (cdr (nth count smart-pair-alist)))))
        (delete-char 1) (delete-char -1)
        (setq smart-skipper t))

       ((and (eq this-command 'backspace-blank-lines-or-char)
             (looking-back (regexp-quote
                            (concat (car (nth count smart-pair-alist))
                                    (cdr (nth count smart-pair-alist))))))
        (delete-char -2)
        (setq smart-skipper t))
       ((and (eq this-command 'delete-blank-lines-or-char)
             (looking-at (regexp-quote
                          (concat (car (nth count smart-pair-alist))
                                  (cdr (nth count smart-pair-alist))))))
        (delete-char 2)
        (setq smart-skipper t))

       ;; ((looking-at (regexp-quote (car (nth count smart-pair-alist))))
       ;;  (save-excursion
       ;;    (forward-list)
       ;;    (delete-char -1))
       ;;  (delete-char 1)
       ;;  (setq smart-skipper t))
       )

      (setq count (1+ count)))
    )
  smart-skipper
  )



(defadvice delete-blank-lines-or-char (around smart-delete-parenthesis activate)
  (cond
   ((and (or (eq major-mode 'ess-mode) (eq major-mode 'python-mode)) (looking-at "(") (looking-back "[a-z0-9]"))
    (delete-region (point) (scan-sexps (point) -1))
    ;;(delete-region (point) (scan-lists (point) -1 1))
    (looking-at "(")
    (save-excursion
      (forward-list 1)
      (delete-char -1))
    (delete-char 1))
   ((looking-at ")")
    (save-excursion
      (forward-char 1)
      (backward-list 1)
      (delete-char 1))
    (delete-char 1))
   ((looking-at "(")
    (save-excursion (ignore-errors (forward-list 1) (delete-char -1)))
    (delete-char 1))
   (t ad-do-it))
  )



(defadvice backspace-blank-lines-or-char (around smart-backspace-parenthesis activate)
  (cond
   ((looking-back "(")
    (save-excursion
      (ignore-errors (backward-char 1) (forward-list 1) (delete-char -1)))
    (delete-char -1))
   ((looking-back ")")
    (save-excursion
      (ignore-errors (backward-list 1))
      (if (looking-at "(") (delete-char 1)))
    (delete-char -1))
   (t ad-do-it))
  )



;;  GENERAL MODE

(setq smart-pair-alist
      '(("(" . ")")             ; key 0
        ("[" . "]")             ; key 1
        ("{" . "}")             ; key 2
        ("'" . "'")
        ("\"" . "\"")
        ("<" . ">")
        ))



(setq smart-pair-closers '(41 ;; )
                          93 ;; ]
                          39 ;; '
                          34 ;; "
                          125 ;; }
                          62 ;; >
                          ))

(defun smart-expand-pair (closing-char)
  (interactive)
  (when (not (member (following-char) 'smart-pair-closers))
      (search-forward closing-char)
      (left-char))
  (let ((ec (following-char)))
    (delete-char 1)
    (ignore-errors (forward-sexp))
    (insert-char ec)
    (left-char)))

(defun smart-expand-pair-paren()
  (interactive)
  (smart-expand-pair ")"))

(defun smart-expand-pair-bracket()
  (interactive)
  (smart-expand-pair ")"))

(defun smart-shrink-pair (closing-char)
  (interactive)
  (when (not (member (following-char) 'smart-pair-closers))
      (search-forward closing-char)
      (left-char))
  (let ((ec (following-char)))
    (delete-char 1)
    (ignore-errors (backward-sexp))
    (ignore-errors (backward-sexp))
    (ignore-errors (forward-sexp))
    (insert-char ec)
    (left-char))
  )

(defun smart-shrink-pair-paren()
  (interactive)
  (smart-shrink-pair "]"))

(defun smart-shrink-pair-bracket()
  (interactive)
  (smart-shrink-pair "]"))
