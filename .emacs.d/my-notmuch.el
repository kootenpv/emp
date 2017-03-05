(require 'notmuch)

(require 'notmuch-company)

(notmuch-company t)

(define-key notmuch-hello-mode-map (kbd "T") 'notmuch-goto-unread-tree)
(define-key notmuch-search-mode-map (kbd "M") '(lambda () (interactive) (notmuch-search-tag (list "-unread")) (next-line)))
(define-key notmuch-show-mode-map (kbd "X") '(lambda () (interactive) (notmuch-search-tag (list "-unread")) (kill-this-buffer)))
(define-key notmuch-show-mode-map (kbd "M") '(lambda () (interactive) (notmuch-search-tag (list "-unread")) (kill-this-buffer)))
(define-key notmuch-show-mode-map (kbd "U") '(lambda () (interactive) (notmuch-search-tag (list "+unread")) (kill-this-buffer)))
(define-key notmuch-tree-mode-map (kbd "X") '(lambda () (interactive) (notmuch-tree-tag (list "-unread")) (next-line)))
(define-key notmuch-tree-mode-map (kbd "M") '(lambda () (interactive) (notmuch-tree-tag (list "-unread")) (next-line)))
(define-key notmuch-tree-mode-map (kbd "U") '(lambda () (interactive) (notmuch-tree-tag (list "+unread")) (next-line)))
(define-key notmuch-tree-mode-map (kbd "S") '(lambda () (interactive) (notmuch-tree-tag (list "+spam")) (next-line)))
(define-key notmuch-search-mode-map (kbd "S") '(lambda () (interactive) (notmuch-search-tag (list "+spam"))))
(define-key notmuch-show-mode-map (kbd "S") '(lambda () (interactive) (notmuch-show-tag (list "+spam"))))

(defun notmuch-goto-unread-tree ()
  (interactive)
  (if (get-buffer "*notmuch-tree-tag:unread*")
      (switch-to-buffer (get-buffer "*notmuch-tree-tag:unread*"))
    (notmuch-tree "tag:unread"))
  (notmuch-tree-refresh-view))

(defun switch-to-notmuch ()
  (interactive)
  (elscreen-goto 5)
  (if (get-buffer "*notmuch-hello*")
      (notmuch-goto-unread-tree)
    (notmuch))
  (delete-other-windows))

;; Define two identities, "home" and "work"
(setq gnus-alias-identity-alist
      '(("home"
         nil ;; Does not refer to any other identity
         "Pascal van Kooten <kootenpv@gmail.com>" ;; Sender address
         nil ;; No organization header
         nil ;; No extra headers
         nil ;; No extra body text
         nil)
        ("work"
         nil
         "Pascal van Kooten <pvkooten@jibes.nl>"
         "Jibes Data Analytics BV"
         nil
         nil
         nil)))

(add-hook 'message-setup-hook 'gnus-alias-determine-identity)

;; Use "home" identity by default
(setq gnus-alias-default-identity "home")
;; Define rules to match work identity
(setq gnus-alias-identity-rules)
'(("work" ("any" "pvkooten@\\(jibes\\.nl\\|test\\.jibes.nl\\)" both) "work"))
;; Determine identity when message-mode loads
(add-hook 'message-setup-hook 'gnus-alias-determine-identity)

(defvar notmuch-hello-refresh-count 0)

(defun notmuch-hello-refresh-status-message ()
  (unless no-display
    (let* ((new-count
            (string-to-number
             (car (process-lines notmuch-command "count"))))
           (diff-count (- new-count notmuch-hello-refresh-count)))
      (cond
       ((= notmuch-hello-refresh-count 0)
        (message "You have %s messages."
                 (notmuch-hello-nice-number new-count)))
       ((> diff-count 0)
        (message "You have %s more messages since last refresh."
                 (notmuch-hello-nice-number diff-count)))
       ((< diff-count 0)
        (message "You have %s fewer messages since last refresh."
                 (notmuch-hello-nice-number (- diff-count)))))
      (setq notmuch-hello-refresh-count new-count))))

(add-hook 'notmuch-hello-refresh-hook 'notmuch-hello-refresh-status-message)
(setq notmuch-search-oldest-first nil)

(setq notmuch-multipart/alternative-discouraged '("text/plain" "text/html"))

(provide 'my-notmuch)
