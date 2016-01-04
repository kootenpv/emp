;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;        Keychords          ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(key-chord-define-global "SS" 'ido-switch-buffer)

(key-chord-define-global "VV"    'avy-goto-char)
(key-chord-define-global "xq"   'kill-emacs)

(key-chord-define-global "MF"     'magit-file-log)

(key-chord-define emacs-lisp-mode-map "fd" 'find-function)

;;(key-chord-define ess-mode-map "vv" 'ess-R-object-popup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Pascal function keybindings ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(key-chord-define-global "hk"   'Navi-mode)

;; bookmark keybindings

(key-chord-define-global "DF" 'dabbrev-expand)

(key-chord-define-global "WF" '(lambda () (interactive) (other-frame 1)))

(key-chord-define-global "PG" 'pgrep)


;; goto-line-with-feedback
(global-set-key (kbd "M-g M-g") 'goto-line-with-feedback)

(global-set-key "\C-xf" 'smart-find-at-point)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Extension keybindings   ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(key-chord-define-global "qf" 'delete-other-windows)
                                        ;(global-set-key (kbd "M-2") 'split-window-below)
                                        ;(global-set-key (kbd "M-3") 'split-window-right)

;; shortcut to align-regexp
(global-set-key (kbd "C-x C-.") 'align-regexp)

;; buffer-extension.el
(global-set-key [f9] 'copy-buffer-file-name-as-kill)

;; expand-region
(global-set-key (kbd "C-'") 'er/expand-region)
(global-set-key (kbd "C-\"") 'neg-expand-region)

;; mark-more-like-this
(global-set-key (kbd "C-,") 'mark-previous-like-this)
(global-set-key (kbd "C-.") 'mark-next-like-this)
(global-set-key (kbd "C-*") 'mark-all-like-this)

;; multiple-cursors
(global-set-key (kbd "C->") 'mc/edit-lines)

(global-set-key [?\M-o] 'imenu-anywhere)

(global-set-key [delete]  'delete-blank-lines-or-char)

(global-set-key [backspace]  'backspace-blank-lines-or-char)

(global-set-key (kbd "C-<backspace>") 'backward-delete-word)

(global-set-key [f11] 'fullscreen)

(global-set-key (kbd "C-h C-f") 'find-function)

(global-set-key (kbd "C-x C-e") 'custom-lisp-executer)

(global-set-key (kbd "C-x e") 'eval-last-sexp)

(global-set-key (kbd "C-k") 'kill-line-or-region)

(global-set-key (kbd "C-S-g") 'minibuffer-keyboard-quit)

(global-set-key (kbd "C-o") 'smart-delete-or-restore-windows)

(global-set-key (kbd "C-w") 'kill-buffer)

(global-set-key "\r" 'newline-and-indent)

(global-set-key (kbd "s-SPC") 'just-one-space)

(global-set-key (kbd "C-c r") 'recentf-open-files)

(define-key isearch-mode-map [(backspace)] 'isearch-delete-char)

(global-unset-key '[C-down-mouse-1])

(global-set-key (kbd "<XF86Back>") 'scroll-down)
(global-set-key (kbd "<XF86Forward>") 'scroll-up)

(global-set-key [(control meta return)] 'aj-toggle-fold)

(global-set-key [(control meta backspace)] 'delete-backwards-non-word)

(global-set-key (kbd "C-d") 'delete-blank-lines-or-char)

(global-set-key (kbd "C-c t") 'hs-toggle-hiding)
(global-set-key (kbd "C-c h") 'hs-hide-all)
(global-set-key (kbd "C-c s") 'hs-show-all)

(global-set-key (kbd "C-M-m") 'magit-status)

(define-key restclient-mode-map (kbd "C-<return>") 'restclient-http-send-current)

(global-unset-key (kbd "C-\\"))

(global-set-key (kbd "C-c d") 'elpy-doc)

(key-chord-define-global "WF" 'eashy-switch-or-create)

(global-set-key (kbd "M-<left>") 'tabbar-backward)
(global-set-key (kbd "M-<right>") 'tabbar-forward)

(key-chord-define-global "SF" '(lambda () (interactive) (switch-to-buffer eashy-last-buf)))

(global-set-key (kbd "M-<right>") 'tabbar-forward)


(global-set-key (kbd "M-f") 'flymake-goto-next-error)

(global-set-key (kbd "M-DEL") 'smart-backward-kill-word)

(defun markdown-mode-config ()
  "Modify keymaps used by `markdown-mode'."
  (local-set-key  (kbd "M-<return>") 'magit-status)
  )

;; add to hook
(add-hook 'markdown-mode-hook 'markdown-mode-config)

(global-set-key (kbd "C-S-t") 'toggle-truncate-lines)

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
(global-set-key (kbd "C-)") 'smart-expand-pair)

(global-set-key (kbd "C-(") 'smart-shrink-pair)


(provide 'emp-keybindings)
