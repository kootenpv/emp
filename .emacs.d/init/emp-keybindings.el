;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;        Keychords          ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(key-chord-define-global "SS" 'ido-switch-buffer)
(key-chord-define-global "BB" 'projectile-switch-to-buffer)

(key-chord-define-global "VV"    'avy-goto-char)
(key-chord-define-global "xq"   'kill-emacs)

(key-chord-define-global "L!"   '(lambda () (interactive) (shelly 1)))
(key-chord-define-global "L@"   '(lambda () (interactive) (shelly 2)))
(key-chord-define-global "L#"   '(lambda () (interactive) (shelly 3)))
(key-chord-define-global "L$"   '(lambda () (interactive) (shelly 4)))

;(key-chord-define-global "ME"   '(lambda () (interactive) (diredp-find-a-file "/home/pascal/egoroot")))
;(key-chord-define-global "MP"   '(lambda () (interactive) (diredp-find-a-file "/home/pascal")))

;; (key-chord-define-global "LA"   '(lambda () (interactive) (elscreen-goto 0)))
;; (key-chord-define-global "LS"   '(lambda () (interactive) (elscreen-goto 1)))
;; (key-chord-define-global "LD"   '(lambda () (interactive) (elscreen-goto 2)))
;; (key-chord-define-global "LF"   '(lambda () (interactive) (elscreen-goto 3)))

(key-chord-define-global "L%"   '(lambda () (interactive) (shelly 5)))
(key-chord-define-global "L^"   '(lambda () (interactive) (shelly 6)))
(key-chord-define-global "L&"   '(lambda () (interactive) (shelly 7)))
(key-chord-define-global "L*"   '(lambda () (interactive) (shelly 8)))

;; (key-chord-define-global "LQ"   '(lambda () (interactive) (elscreen-goto 4) (when (not (ignore-errors jabber-connections)) (jabber-connect-all)) (when (not (string-match "jabber" (buffer-name (current-buffer)))) (jabber-switch-to-roster-buffer))))
;; (key-chord-define-global "LW"   'switch-to-notmuch)

(defun goto-4-jabber-chat-with ()
  (interactive)
  (elscreen-goto 4)
  (call-interactively 'jabber-chat-with))



(key-chord-define-global "JW"   'goto-4-jabber-chat-with)
(key-chord-define-global "NM"   'notmuch)

(key-chord-define-global "LG" 'shelly-go)

(key-chord-define-global "MF"     'magit-file-log)

(key-chord-define emacs-lisp-mode-map "fd" 'find-function)

;;(key-chord-define ess-mode-map "vv" 'ess-R-object-popup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Pascal function keybindings ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(key-chord-define-global "hk"   'Navi-mode)

;; bookmark keybindings

(key-chord-define-global "WF" '(lambda () (interactive) (other-frame 1)))

(key-chord-define-global "PG" 'pgrep)


;; goto-line-with-feedback
;;(global-set-key (kbd "M-g M-g") 'goto-line-with-feedback)
(global-set-key (kbd "s-g s-g") 'goto-line-with-feedback)



;; (defadvice ido-find-file (before keyboard-escape-quit-ad activate)
;;   (ignore-errors (abort-recursive-edit)))

;(global-set-key (kbd "C-x f") 'ido-find-file)
;(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-unset-key (kbd "C-x C-f"))
(global-unset-key (kbd "C-x f"))
(global-set-key (kbd "C-o") 'ido-find-file)

(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-s") 'save-buffer)

(defun bind-ido-keys ()
  "Keybindings for ido mode."
  (define-key ido-completion-map (kbd "C-o") 'ido-fallback-command))

(add-hook 'ido-setup-hook 'bind-ido-keys)

(define-key dired-mode-map (kbd "C-o") 'ido-find-file)

(define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)

(global-set-key (kbd "C-z") 'undo-tree-undo)
(global-set-key (kbd "C-Z") 'undo-tree-redo)

(global-set-key (kbd "C-x C-d") '(lambda () (interactive) (dired ".")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Extension keybindings   ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; kill buffer instead of keyboard macro

;; (define-key key-translation-map (kbd "C-x k") (kbd "C-z k"))
(define-key key-translation-map (kbd "C-x C-k") (kbd "C-x k"))

(key-chord-define-global "qf" 'delete-other-windows)
                                        ;(global-set-key (kbd "M-2") 'split-window-below)
                                        ;(global-set-key (kbd "M-3") 'split-window-right)

;; shortcut to align-regexp
(global-set-key (kbd "C-x C-.") 'align-regexp)

;; buffer-extension.el
(global-set-key [f9] 'copy-buffer-file-name-as-kill)

;; expand-region
(global-set-key (kbd "C-'") 'er/expand-region)
(global-set-key (kbd "C-\"") 'sp-split-sexp)

(global-set-key (kbd "C-,") 'mark-previous-like-this)
(global-set-key (kbd "C-.") 'mark-next-like-this)
(global-set-key (kbd "C-*") 'mark-all-like-this)


;; multiple-cursors
(global-set-key (kbd "C->") 'mc/edit-lines)

(global-set-key [?\M-o] 'imenu-anywhere)
(global-set-key [?\s-o] 'imenu-anywhere)

(global-set-key [delete]  'delete-blank-lines-or-char)

(global-set-key [backspace]  'backspace-blank-lines-or-char)

(global-set-key (kbd "C-<backspace>") 'backward-delete-word)

(global-set-key [f11] 'fullscreen)

(global-set-key (kbd "C-h C-f") 'find-function)

(global-set-key (kbd "C-x C-e") 'custom-lisp-executer)

(global-set-key (kbd "C-x e") 'eval-last-sexp)

(global-set-key (kbd "C-S-g") 'minibuffer-keyboard-quit)

(global-set-key (kbd "C-v") 'smart-delete-or-restore-windows)

;(global-set-key (kbd "C-w") 'kill-this-buffer)
(global-set-key (kbd "C-w") 'xah-close-current-buffer)
(global-set-key (kbd "C-S-t") 'xah-open-last-closed) ; control+shift+t

(global-set-key "\r" 'newline-and-indent)

(global-set-key (kbd "M-SPC") 'one-or-zero-whitespace)
(global-set-key (kbd "s-SPC") 'one-or-zero-whitespace)

;;(global-set-key (kbd "C-c r") 'counsel-recentf)
(global-set-key (kbd "C-c r") 'ivy-switch-buffer)

(define-key isearch-mode-map [(backspace)] 'isearch-delete-char)

(define-key typescript-mode-map (kbd "C-c a") 'switch-angular)
(define-key web-mode-map (kbd "C-c a") 'switch-angular)

(define-key dired-mode-map [backspace] 'dired-up-directory)
(define-key dired-mode-map "o" 'dired-display-file)

(with-eval-after-load 'python-mode
  (define-key py-ipython-shell-mode-map (kbd "C-<return>") 'py-ipython-shell-paste))


(with-eval-after-load 'magit-log
  (define-key magit-mode-map (kbd "C-w") 'kill-this-buffer))

(global-unset-key '[C-down-mouse-1])

(global-unset-key (kbd "C-x k"))

(global-set-key (kbd "<XF86Back>") 'scroll-down)
(global-set-key (kbd "<XF86Forward>") 'scroll-up)

(global-set-key [(control meta return)] 'aj-toggle-fold)

(global-set-key [(control meta backspace)] 'delete-backwards-non-word)


(global-set-key (kbd "C-d") '(lambda () (interactive) (dired ".")))

(global-set-key (kbd "C-c t") 'hs-toggle-hiding)
(global-set-key (kbd "C-c h") 'hs-hide-all)
(global-set-key (kbd "C-c s") 'hs-show-all)

;; (defun kill-ring-save-exclude-space ()
;;   (interactive)
;;   (let ((s (region-beginning))
;;         (e (region-end))
;;         (i 0))
;;     (save-excursion
;;       (goto-char s)
;;       (while (looking-at " ")
;;         (right-char))
;;       (while (looking-back " ")
;;         (left-char)
;;         (setq i (+ i 1)))
;;       (goto-char e)
;;       (while (looking-back " ")
;;         (left-char)
;;         (setq e (- e 1))))
;;     (deactivate-mark)
;;     (kill-new
;;      (replace-regexp-in-string (concat "^" (make-string i ?\s)) "" (buffer-substring-no-properties s e)))))

;; (defun aware-yank ()
;;   (interactive)
;;   (let ((text (car kill-ring))
;;         (offset 0))
;;     (save-excursion
;;       (while (looking-back " ")
;;         (setq offset (+ offset 1))
;;         (left-char))
;;       (insert (replace-regexp-in-string "^" (make-string offset ?\s) text))
;;       (delete-horizontal-space))))

;; (replace-regexp-in-string (concat "^" (make-string i ?\s)) "" (buffer-substring-no-properties s e))

;; default meta in super
(global-set-key (kbd "s-w") 'kill-ring-save)
(global-set-key (kbd "s-x") 'execute-extended-command)
(global-set-key (kbd "C-s-f") 'sp-forward-sexp)
(global-set-key (kbd "C-s-b") 'sp-backward-sexp)
(global-set-key (kbd "s-<") 'beginning-of-buffer)
(global-set-key (kbd "s->") 'end-of-buffer)
(global-set-key (kbd "s-a") 'ag2)
(global-set-key (kbd "M-a") 'ag)
(global-set-key (kbd "s-y") 'yank-pop)
(global-set-key (kbd "C-s-x") 'eval-defun)
(global-set-key (kbd "C-s-/") 'hippie-expand)
(global-set-key (kbd "C-s-\\") 'smart-indent-region)
(global-set-key (kbd "s-t") 'transpose-words)
(global-set-key (kbd "s-c") 'capitalize-word)
(global-set-key (kbd "s-u") 'upcase-word)
(global-set-key (kbd "s-l") 'downcase-word)
(global-set-key (kbd "s-\\") 'delete-horizontal-space)
(global-set-key (kbd "s-i") 'yas-expand)
(global-set-key (kbd "s-.") 'elpy-goto-definition)
(global-set-key (kbd "C-s-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-s-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-s-<backspace>") 'py-straighten)
(global-set-key (kbd "s-q") 'fill-paragraph)


(global-set-key (kbd "C-M-m") 'magit-status)


(global-set-key (kbd "C-s-<return>") 'magit-status)

(global-set-key (kbd "<XF86LaunchA>") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "<XF86LaunchB>") 'kmacro-end-or-call-macro)

(define-key restclient-mode-map (kbd "C-<return>") 'restclient-http-send-current)

(global-unset-key (kbd "C-\\"))

(global-set-key (kbd "C-c d") 'elpy-doc)

(key-chord-define-global "WF" 'eashy-switch-or-create)

(key-chord-define-global "SF" 'avy-goto-word-0)




(global-set-key (kbd "M-DEL") 'kill-word)

(defun markdown-mode-config ()
  "Modify keymaps used by `markdown-mode'."
  (local-set-key  (kbd "M-<return>") 'magit-status)
  )

;; add to hook
(add-hook 'markdown-mode-hook 'markdown-mode-config)

(global-set-key (kbd "C-s-t") 'toggle-truncate-lines)

;;; Smart keybindings

(global-set-key " " 'smart-switcher) ; [space]


(global-set-key (kbd "C-:") 'smart-uncomment)

(global-set-key (kbd "C-;") 'smart-comment)

(global-set-key (kbd "C-a") 'smart-beginning-of-line)

(global-set-key (kbd "C-e") 'smart-end-of-line)

;;(global-set-key (kbd "<return>")  'autopair-newline) ; [enter]

(global-set-key (kbd "C-M-\\") 'smart-indent-region)

(global-set-key [delete] 'delete-blank-lines-or-char)

(global-set-key [backspace] 'backspace-blank-lines-or-char)


(defun embracer-test ()
  (interactive)
  (insert "()")
  (left-char 1)
  (let ((inc-variable 0))
    (ignore-errors
      (while (sp-slurp-hybrid-sexp)
        (setq inc-variable (+ inc-variable 1))))
    (message "%d" inc-variable)
    (while (> inc-variable 0)
      (ignore-errors (sp-slurp-hybrid-sexp))
      (setq inc-variable (- inc-variable 1))))
)

;; (global-set-key (kbd "C-(") 'sp-forward-barf-sexp)
(global-set-key (kbd "C-{") '(lambda () (interactive) (back-to-indentation) (insert "[") (move-end-of-line 1) (delete-horizontal-space) (insert "]") (backward-sexp)))
(global-set-key (kbd "C-(") 'embracer-test)
(global-set-key (kbd "C-)") 'sp-slurp-hybrid-sexp) ; sp-forward-slurp-sexp


(global-set-key (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
(global-set-key (kbd "C-M-<right>") 'sp-backward-barf-sexp)



(global-set-key (kbd "M-+") 'make-directory)

(global-set-key (kbd "M-J") 'join-lines)
(global-set-key (kbd "M-j") 'join-line)

(global-set-key (kbd "C-M-=") 'make-directory)
(global-set-key (kbd "s-+") 'make-directory)

(global-set-key (kbd "M-r") 'rename-current-buffer-file)
(global-set-key (kbd "s-r") 'rename-current-buffer-file)

(global-set-key (kbd "M-i") 'yas-expand)

(global-set-key "\M-]" 'comint-dynamic-complete-filename)

(global-set-key "\M-/" 'hippie-expand)
(global-set-key (kbd "s-/") 'hippie-expand)

(global-set-key (kbd "C-n") 'flycheck-next-error)
(global-set-key (kbd "C-p") 'flycheck-previous-error)

(global-set-key (kbd "C-x t") 'neotree-toggle)

(global-set-key (kbd "C-c C-f") 'reformat)

;(global-set-key (kbd "C-s") 'helm-swoop)

(global-set-key (kbd "C-M-c") 'compile)

(global-set-key (kbd "C-k") 'kill-region-or-modulous)
;;(global-set-key (kbd "C-k") 'kill-line-or-region)

(add-hook 'ag-mode-hook (lambda() (local-unset-key (kbd "C-o"))))

(provide 'emp-keybindings)
