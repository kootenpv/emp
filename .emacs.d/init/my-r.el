;;http://ess.r-project.org/refcard.pdf
(require 'ess-R-object-tooltip)

(setq-default inferior-R-args "--no-restore-history --no-save ")

(setq ess-default-style 'RRR)   ; Common R chosen

;; (setq inferior-R-program-name "c:/progra~1/R/R-2.15.2/bin/Rterm.exe")

;;(setq inferior-R-program-name "C:/R-2.15.2/bin/i386/Rterm.exe")

(setq ess-eval-visibly-p nil)

(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

(defun my-ess-start-R ()
  (interactive)
  (when (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
    (delete-other-windows)
    (setq w1 (selected-window))
    (setq w1name (buffer-name))
    (split-window w1 82 t)
    (setq w3 (split-window (next-window) 18))
    (R)
    (set-window-buffer w3 "*R*")
    (set-window-buffer w1 w1name)))

(defun my-ess-eval ()
  (interactive)
  (my-ess-start-R)
  (process-send-string "R" "tone <- proc.time()[1:3]")
  (let ((curwin (get-buffer-window)) )
    (select-window (get-buffer-window "*R*"))
    (inferior-ess-send-input)
    (select-window curwin)
    (ess-eval-region-or-line-and-step 1)
    (process-send-string "R" "ttwo <- proc.time()[1:3]; cat(paste(c(\"\", format(ttwo-tone)), c(\"user\", \"sys\", \"elapsed\", \"\n\")));")
    (select-window (get-buffer-window "*R*"))
    (inferior-ess-send-input)
    (goto-char (point-max))
    (select-window curwin)
    )
  )

(defun ess-timed-cc (vis)
  (interactive "P")
  (my-ess-start-R)
  (process-send-string "R" "tone <- proc.time()[1:3];")
  (let ((curwin (get-buffer-window)) )
    (select-window (get-buffer-window "*R*"))
    (inferior-ess-send-input)
    (select-window curwin)
    (ess-eval-region-or-function-or-paragraph-and-step vis)
    (process-send-string "R" "ttwo <- proc.time()[1:3]; cat(paste(c(\"\", format(ttwo-tone)), c(\"user\", \"sys\", \"elapsed\", \"\n\")));")
    (select-window (get-buffer-window "*R*"))
    (inferior-ess-send-input)
    (goto-char (point-max))
    (select-window curwin)
    )
  )

(add-hook 'ess-mode-hook
          '(lambda()
         ;;(define-key ess-mode-map (kbd "C-<return>") 'my-ess-eval)
         (define-key ess-mode-map (kbd "C-<return>") 'ess-timed-cc)
         (define-key ess-mode-map (kbd "M-p") 'parallel-activate)
         (define-key ess-mode-map (kbd "C-c C-c") 'ess-timed-cc) ))
(add-hook 'inferior-ess-mode-hook
          '(lambda()
             (local-set-key [C-up] 'comint-previous-input)
             (local-set-key [C-down] 'comint-next-input)))

;; (add-hook 'Rnw-mode-hook
;;           '(lambda()
;;       (key-chord-define Rnw-mode-map "jj" 'my-ess-eval)))

(require 'ess-site)

(add-hook 'ess-mode-hook
      (lambda ()
        (ess-set-style 'DEFAULT 'quiet)))

(fset 'pdf-run-line-dev
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217788 19 112 100 102 13 S-return 21 67108896 21 67108896 S-return 134217790 18 100 101 118 46 111 102 102 13 S-return 21 67108896 21 67108896 21 67108896] 0 "%d")) arg)))

(fset 'new-file-graphics
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([112 100 102 40 102 105 108 101 61 34 34 left f7 102 25 backspace 112 100 102 right right return return 100 101 118 46 111 102 102 40 up] 0 "%d")) arg)))

(define-key ess-mode-map (kbd "C-c j") 'pdf-run-line-dev)
(define-key ess-mode-map (kbd "C-c n") 'new-file-graphics)

(require 'r-autoyas)
(add-hook 'ess-mode-hook 'r-autoyas-ess-activate)

                    ;in a pop up information about the objects
(require 'ess-R-object-popup)

(setq-default ess-dialect "R")
(key-chord-define-global "vv" 'ess-R-object-popup)

(add-hook 'ess-noweb-mode-hook 'local-set-key "TAB" 'yas-expand)

                    ; better auto-pair behavior
(defadvice autopair-insert-opening (before autopair-ess-advise activate)
  (when (and (looking-at "[a-zA-Z0-9]") (looking-back "[a-z0-9A-Z]")) (eq major-mode 'ess-mode)
        (save-excursion
          (move-end-of-line 1) (insert "")))
  )


(defun ess-eval-sexp-at-point ()
  (interactive)
  (save-excursion
    (when (not (looking-at "\\<")) (backward-sexp))
    (mark-sexp)
    (exchange-point-and-mark)
    (if (looking-at "\\[") (search-forward "]"))
    (ess-eval-region (region-beginning) (region-end) nil))
  )

;;(define-key ess-mode-map (kbd "C-j") 'ess-eval-sexp-at-point)

(define-key ess-mode-map "(" nil)


(defun move-paren-further ()
  (interactive)
  (ignore-errors
    (backward-char 1)
    (search-forward ")")
    (forward-sexp)
    (delete-char -1)
    (insert ")")
    )
  )

(define-key ess-mode-map (kbd "C-(") 'move-paren-further)

(defvar my-ess-window nil)

(defun add-inferior-ess-keywords()
  "adds a few keywords for inferior-ess mode"
  (font-lock-add-keywords nil
              '(
                ("user.+" . 'font-lock-variable-name-face)
                ("Warning" . 'font-lock-variable-name-face)
                )
              )
  )

(add-hook 'inferior-ess-mode-hook 'add-inferior-ess-keywords)

(defun parallel-activate ()
  (interactive)
  (mark-paragraph)
  (setq parallel-job-count (+ 1 parallel-job-count))
  (let ((str (buffer-substring-no-properties
          (+ 1 (region-beginning)) (- (region-end) 1))))
    (let ((curbuf (current-buffer))
      (unlist (string-match "unlist=T" str))
      (job (int-to-string parallel-job-count))
      (varname (substring str 0 (string-match "[ ]*<-" str))))
      (ess-eval-region-or-line-and-step 1)
      (if unlist
      (setq unlist "unlist=T")
    (setq unlist "unlist=F"))
      (add-to-list 'parallel-timers (cons job (run-with-timer 1 5 'parallel-check-timer varname curbuf job unlist)))
      ))
  )

(defun parallel-check-timer (Rvar curbuf job unlist)
  (interactive)
  (switch-to-buffer (get-buffer "*R*"))
  (end-of-buffer)
  (process-send-string
   "R" (concat Rvar "<- nCollect(" Rvar ",job=c(" job ", \"" Rvar "\")," unlist ");"))
  (inferior-ess-send-input)
  (when  (ignore-errors (search-backward (concat "Parallel job " job " done")))
    (let ((tmr (loop for item in parallel-timers
             when (string-equal job (car item))
             return (cdr item))))
      (cancel-timer tmr)
      (setq parallel-timers (remove (cons job tmr) parallel-timers))))
  (end-of-buffer)
  (switch-to-buffer curbuf)
  )


(defvar parallel-timers (list))

(defvar parallel-job-count 0)


;;(cancel-timer (car timer-list)))

(defun cancel-parallel ()
  (interactive)
  (cancel-timer (car timer-list))
  )


(defun run-all-functions ()
  (interactive)
  (let ((a t))
    (while a
      (when (eq major-mode 'ess-mode)
    (setq a (search-forward-regexp "[-=] function" nil t)))
      (if a (ess-eval-function-or-paragraph-and-step t))
      (when (eq major-mode 'python-mode)
    (setq a (search-forward-regexp "^def " nil t))
    (if a (ess-eval-function-or-paragraph-and-step t))))
    )
  (goto-char (point-min))
  )

(provide 'emp-r)
