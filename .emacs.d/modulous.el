(defvar assign-char "=")

(defun find-assign-char ()
  (interactive)
  (search-backward assign-char 0 t)
  (right-char)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    (call-interactively 'sp-kill-hybrid-sexp))
  (just-one-space 1))

(defun get-paragraph-small ()
  (interactive)
  (mark-paragraph)
  (next-line))

(defun kill-paragraph-modulous ()
  (interactive)
  (get-paragraph-small)
  (kill-region (region-beginning) (region-end)))

(defun delete-paragraph-modulous ()
  (interactive)
  (get-paragraph-small)
  (delete-region (region-beginning) (region-end)))

;; brackets
(defun modulous-test-bracket (n p)
  (ignore-errors
    (search-backward "[" 0 t n)
    (forward-sexp)
    (> (point) p)))

(defun modulous-kill-brackets-priv (n)
  (let ((p (point)))
    (if (and (< n 5) (not (modulous-test-bracket n p)))
        (modulous-kill-brackets-priv (+ n 1))
      (kill-sexp -1)
      (insert "[]")
      (left-char))))

(defun modulous-kill-brackets ()
  (interactive)
  (modulous-kill-brackets-priv 1))

;; parens
(defun modulous-find-pair (start n p)
  (ignore-errors
    (search-backward start 0 t n)
    (forward-sexp)
    (> (point) p)))

(defun modulous-pair (start end kill inner n)
  (let ((p (point)))
    (if (and (< n 5) (not (modulous-find-pair start n p)))
        (modulous-pair start end (+ n 1))
      (mark-sexp -1)
      (when inner
        (left-char)
        (exchange-point-and-mark)
        (right-char))
      (if kill
          (kill-region (region-beginning) (region-end))
        (delete-region (region-beginning) (region-end))))))



(defun modulous-kill-parens ()
  (interactive)
  (modulous-pair "(" ")" t nil 1))

(defun modulous-kill-inner-parens ()
  (interactive)
  (modulous-pair "(" ")" t t 1))

(defun modulous-delete-parens ()
  (interactive)
  (modulous-pair "(" ")" nil nil 1))

(defun modulous-delete-inner-parens ()
  (interactive)
  (modulous-pair "(" ")" nil t 1))


;; doublequote
(defun modulous-kill-inner-doublequote ()
  (interactive)
  (modulous-pair "\"" "\"" t t 1))

(defun modulous-delete-inner-doublequote ()
  (interactive)
  (modulous-pair "\"" "\"" nil t 1))

;; singlequote
(defun modulous-kill-inner-singlequote ()
  (interactive)
  (modulous-pair "'" "'" t t 1))

(defun modulous-delete-inner-singlequote ()
  (interactive)
  (modulous-pair "'" "'" nil t 1))



(define-prefix-command 'modulous-kill-map)
(define-prefix-command 'modulous-delete-map)

(global-set-key (kbd "C-k") 'modulous-kill-map)
(global-set-key (kbd "M-d") 'modulous-delete-map)


(define-key modulous-kill-map (kbd "=") 'find-assign-char)
(define-key modulous-kill-map (kbd "w") 'kill-whole-line)
(define-key modulous-kill-map (kbd "e") 'kill-line)
(define-key modulous-kill-map (kbd "C-e") 'kill-line)
(define-key modulous-kill-map (kbd "k") 'kill-region)
(define-key modulous-kill-map (kbd "p") 'kill-paragraph-modulous)
(define-key modulous-kill-map (kbd "[") 'modulous-kill-brackets)
(define-key modulous-kill-map (kbd "'") 'modulous-kill-singlequotes)
(define-key modulous-kill-map (kbd "b") 'py-kill-block)
(define-key modulous-kill-map (kbd "c") 'py-kill-class)
(define-key modulous-kill-map (kbd "f") 'py-kill-def)
(define-key modulous-kill-map (kbd "u") 'undo-tree-undo)


(define-key modulous-kill-map (kbd "9") 'modulous-kill-inner-parens)
(define-key modulous-kill-map (kbd "(") 'modulous-kill-parens)
(define-key modulous-kill-map (kbd "\"") 'modulous-kill-inner-doublequote)
(define-key modulous-kill-map (kbd "'") 'modulous-kill-inner-singlequote)

(define-key modulous-delete-map (kbd "9") 'modulous-delete-inner-parens)
(define-key modulous-delete-map (kbd "(") 'modulous-delete-parens)
(define-key modulous-delete-map (kbd "\"") 'modulous-delete-inner-doublequote)
(define-key modulous-delete-map (kbd "'") 'modulous-delete-inner-singlequote)

(define-key modulous-delete-map (kbd "w") '(lambda () (interactive) (delete-region (line-beginning-position) (line-end-position))))

(define-key modulous-delete-map (kbd "p") 'delete-paragraph-modulous)
(define-key modulous-delete-map (kbd "b") 'py-delete-block)
(define-key modulous-delete-map (kbd "c") 'py-delete-class)
(define-key modulous-delete-map (kbd "f") 'py-delete-def)
(define-key modulous-delete-map (kbd "u") 'undo-tree-undo)

(provide 'modulous)
