;;;; /usr/local/bin/ipython_fix
;; export DISPLAY="localhost:10.0"
;; echo 'DISPLAY="localhost:10.0" ipython3 --simple-prompt -i' > /usr/local/bin/ipython_fix && chmod +x /usr/local/bin/ipython_fix
;; SHELL
;; yum install / apt-get install xclip
;; pip3 install pylint
;; .BASHRC
;; export LC_ALL=en_US.UTF-8
;; export LANG=en_US.UTF-8


;; pip install ipython[notebook] && apt-get install python-matplotlib && ipython notebook --ip=0.0.0.0
;; ein:notebooklist-open
;; ein:connect-to-buffer

;; ELPY YAPF NEEDS TO BE IN RECENT RELEASE
;; IMPORTMAGIC UPGRADE


;; Read: http://elpy.readthedocs.org/en/latest/ide.html

;; PYFLYMAKE.PY
;; This could be quite more optimized, since I would never used other than Pylint!!!
;; Try to convert it to a raw one, speed up is 10%
;; pyflakes: too light
;; pycheckers: evals a module; not good
;; pep8: done by autosave

;;; consider reimplementing the wrap shifting


(require 'python-mode)

(require 'python)

(defun s-trim-right (s)
  "Remove whitespace at the end of S."
  (if (string-match "[ \t\n\r]+\\'" s)
      (replace-match "" t t s)
    s))

(defun new-python-eval (arg)
  ;; NOTE THAT I CHANGED IPYTHON's
  ;; /Library/Python/2.7/site-packages/ipython-2.0.0_dev-py2.7.egg/IPython/core/magics/execution.py
  ;; /Library/Python/2.7/site-packages/ipython-2.0.0_dev-py2.7.egg/IPython/terminal/interactiveshell.py
  ;; IN ORDER TO PREVENT SILLY PRINTING
  (interactive "p")
  (when (eq arg 0)
    (setq python-python-command "ipython")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 2)
    (setq python-python-command "ipython2")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 3)
    (setq python-python-command "ipython3")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  ;; remote
  (when (eq arg 4)
    (setq python-python-command "/usr/local/bin/ipython_fix")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  ;;pypy
  (when (eq arg 9)
    ;; make it so that pypy's ipython is linked to "ipypy" in your bin, yes.. ipypy is a new name,
    ;; e.g.: (setq python-python-command "/Users/pascal/Downloads/pypy-2.5.1-osx64/bin/ipython")
    (setq python-python-command "ipypy")
    (setq  pybuffname (concat "*IPyPy" (int-to-string arg) "*")))
  (new-python-get-text)
  (if (string-equal python-python-command "/usr/local/bin/ipython_fix")
      (shell-command (concat "echo \"" (s-replace "\"" "\\\"" (substring-no-properties (car kill-ring))) "\" | xclip -selection clipboard") nil))
  (if (get-buffer pybuffname)
      (switch-to-buffer-other-window pybuffname)
    (delete-other-windows)
    (if (not (string-match "pypy" python-python-command))
        (progn
          (py-shell nil t python-python-command pybuffname)
          (switch-to-buffer-other-window pybuffname))
      (split-window-right)
      (switch-window)
      (ansi-term "ipypy" (concat "IPyPy" (int-to-string arg)))
      ))
  (end-of-buffer)
  (insert "%time %paste")
  (if (eq major-mode 'term-mode)
      (term-send-input)
    (comint-send-input)
    (comint-add-to-input-history (s-trim-right (substring-no-properties (car kill-ring)))))
  (setq kill-ring (cdr kill-ring))
  (sleep-for 0.01)
  (search-backward "%time %paste")
  (delete-region (line-beginning-position) (+ 1 (line-end-position)))
  (end-of-buffer)
  (other-window -1))

(defun new-python-eval2 (arg)
  ;; NOTE THAT I CHANGED IPYTHON's
  ;; /Library/Python/2.7/site-packages/ipython-2.0.0_dev-py2.7.egg/IPython/core/magics/execution.py
  ;; /Library/Python/2.7/site-packages/ipython-2.0.0_dev-py2.7.egg/IPython/terminal/interactiveshell.py
  ;; IN ORDER TO PREVENT SILLY PRINTING
  (interactive "p")
  (when (eq arg 0)
    (setq python-python-command "ipython")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 2)
    (setq python-python-command "ipython2")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 3)
    (setq python-python-command "ipython3")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 9)
    ;; make it so that pypy's ipython is linked to "ipypy" in your bin, yes.. ipypy is a new name,
    ;; e.g.: (setq python-python-command "/Users/pascal/Downloads/pypy-2.5.1-osx64/bin/ipython")
    (setq python-python-command "ipypy")
    (setq  pybuffname (concat "*IPyPy" (int-to-string arg) "*")))
  (new-python-get-text)
  (if (get-buffer pybuffname)
      (switch-to-buffer-other-window pybuffname)
    (delete-other-windows)
    (if (not (string-match "pypy" python-python-command))
        (progn
          (py-shell nil t python-python-command pybuffname)
          (switch-to-buffer-other-window pybuffname))
      (split-window-right)
      (switch-window)
      (ansi-term "ipypy" (concat "IPyPy" (int-to-string arg)))
      ))
  (end-of-buffer)
  (insert (car kill-ring))
  (if (eq major-mode 'term-mode)
      (term-send-input)
    (comint-send-input t))
  (accept-process-output (get-buffer-process (current-buffer)))
  (setq kill-ring (cdr kill-ring))
  (end-of-buffer)
  (comint-send-input nil t)
  (end-of-buffer)
  (comint-goto-process-mark)
  (other-window -1))


(defun python-send-buffer2 ()
  (interactive)
  (switch-to-buffer "*Python*")
  (ignore-errors (process-kill-without-query (get-buffer-process (current-buffer))))
  (kill-buffer "*Python*")
  (delete-other-windows)
  (python-send-buffer)
  (split-window-right)
  (other-window 1)
  (switch-to-buffer "*Python*")
  (other-window -1))

(add-hook 'python-mode-hook
          '(lambda()
             (define-key python-mode-map (kbd "C-<return>") 'new-python-eval)
             (define-key python-mode-map (kbd "C-M-<backspace>") 'py-straighten)))

(define-key python-mode-map (kbd "C-c c") 'python-send-my-buffer)

(define-key python-mode-map (kbd "<tab>") 'py-shift-right)
(define-key python-mode-map [backtab] 'py-shift-left)

(define-key python-mode-map (kbd "C-<backspace>") 'backward-delete-word)
(define-key py-ipython-shell-mode-map (kbd "C-<backspace>") 'backward-delete-word)

(define-key python-mode-map [backspace] 'backspace-blank-lines-or-char)
(define-key python-mode-map [delete] 'delete-blank-lines-or-char)

(defun add-inferior-python-keywords()
  "adds a few keywords for inferior-python mode"
  (font-lock-add-keywords nil
                          '(
                            ("time:.+" . 'font-lock-variable-name-face)
                            )
                          )
  )

(add-hook 'comint-mode-hook 'add-inferior-python-keywords)

(define-key python-mode-map (kbd "C-c p") 'shell-this-file)

(defun shell-this-file ()
  (interactive)
  (save-buffer)
  (when (eq major-mode 'python-mode)
    (when (< (count-windows) 2)
      (split-window-horizontally))
    (let ((buf (buffer-file-name) ))
      (other-window 1)
      (eshell)
      (insert (concat "python3.5 " buf)))
    (eshell-send-input)
    (other-window 1)))

(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq python-indent 4)))

(defun run-all-functions ()
  (interactive)
  (let ((a t))
    (while ay
      (when (eq major-mode 'ess-mode)
        (setq a (search-forward-regexp "[-=] function" nil t)))
      (if a (ess-eval-function-or-paragraph-and-step t))
      (when (eq major-mode 'python-mode)
        (setq a (search-forward-regexp "^def " nil t))
        (if a (ess-eval-function-or-paragraph-and-step t))))
    )
  (goto-char (point-min))
  )

(defun set-exec-path-from-shell-PATH ()
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

(defun python-send-my-buffer (arg)
  (interactive "p")
  (if (not (eq arg 1))
      (setq smart-eval-ess-expression (replace-regexp-in-string "\[[0-9]+\]" (concat "[" (int-to-string arg) "]") smart-eval-ess-expression)))
  (save-buffer)
  (py-execute-buffer)
  (switch-to-buffer-other-window "*IPython*")
  (comint-interrupt-subjob)
  (my-clear)
  (other-window -1)
  (smart-eval-ess-executer)
  )

(defun new-python-get-start ()
  (interactive)
  (ignore-errors
    (while (looking-at "[ ]*$")
      (next-line)
      ))
  (move-end-of-line 1)
  (search-backward-regexp "^[@a-zA-Z0-9#\[\{]" 0 t)
  (when (or (looking-at "else") (looking-at "elif") (looking-at "except") (looking-at "finally"))
    (search-backward-regexp "^if\\|^try" 0 t)
    )
  (ignore-errors
    (previous-line)
    (while (looking-at "[@a-zA-Z]")
      (previous-line))
    (next-line)
    )
  (point)
  )

(defun new-python-get-end ()
  (interactive)
  (ignore-errors
    (while (looking-at "^[@a-zA-Z0-9#\[\{]")
      (next-line)))
  (if (search-forward-regexp "^[@a-zA-Z0-9#\[\{]" (point-max) t)
      (progn (move-beginning-of-line 1)
             (when (or (looking-at "elif") (looking-at "else"))
               (search-forward-regexp "^else" (point-max) t)
               (search-forward-regexp "^[@a-zA-Z0-9#\[\{]" (point-max) t)
               (left-char 1))
             (when (or (looking-at "except"))
               (search-forward-regexp "^except" (point-max) t)
               (search-forward-regexp "^[@a-zA-Z0-9#\[\{]" (point-max) t)
               (left-char 1))
             (when (or (looking-at "finally"))
               (search-forward-regexp "^finally" (point-max) t)
               (search-forward-regexp "^[@a-zA-Z0-9#\[\{]" (point-max) t)
               (left-char 1))
             (point))
    (point-max))
  )

(defun new-python-get-text ()
  (interactive)
  (cond
   ((region-active-p) (kill-ring-save (region-beginning) (region-end)))
   (t (ignore-errors
    (let ((start (new-python-get-start))
          (end (new-python-get-end)))
      (when (eq (point-max) end)
        (goto-char end))
      (kill-ring-save start end)
      )))))

(setenv "LC_CTYPE" "UTF-8")

(setenv "PYTHONPATH" "/Users/pascal/watson/WEX/API/")

(defun pgrep (str)
  (interactive "sgrep for: ")
  (shell-command (concat "grep -rsnH \"" str "\" . --include=\"*.py\"&"))
  )

(defun phgrep (str)
  (interactive "sgrep for: ")
  (shell-command (concat "grep -rsnH \"" str "\" ~/egoroot --include=\"*.py\"&"))
  )


;; ("\\<\\(object\\|str\\|else\\|except\\|finally\\|try\\|\\)\\>" 0 py-builtins-face)
(font-lock-add-keywords 'python-mode '(("\\<[\\+-]?[0-9]+\\(.[0-9]+\\)?\\>" 0 'font-lock-constant-face)
                                       ("\\([][{}()~^<>:=,.\\+*/%-]\\)" 0 'font-lock-constant-face)))

(defun python-makecurrent ()
  (interactive)
  (let ((buffname (file-name-directory (buffer-file-name))))
    (other-window -1)
    (insert (concat "import os; os.chdir('" buffname "')\n"))
    (comint-send-input)
    (other-window -1)
    )
  )

(require 'sphinx-doc)
(add-hook 'python-mode-hook 'sphinx-doc-mode)

(add-hook 'python-mode-hook
          '(lambda ()
             (progn
               (elpy-enable)
               (elpy-mode)
               ;;(setq-local flymake-start-syntax-check-on-newline t)
               (setq elpy-rpc-python-command "python3")
               (elpy-use-ipython)
               ;;(setq elpy-rpc-backend "jedi")
               ;;(jedi:ac-setup)
               (setq python-check-command (concat emacsd "pyflymake.py"))
               (define-key elpy-mode-map (kbd "C-<return>") 'new-python-eval)
               (define-key elpy-mode-map (kbd "M-<left>") nil)
               (define-key elpy-mode-map (kbd "M-<right>") nil)
               (setq elpy-test-runner 'elpy-test-pytest-runner)
               ;(add-hook 'before-save-hook (lambda () (when (eq major-mode 'python-mode)) 'elpy-format-code))
               )))

(add-hook 'python-mode-hook
          (lambda () (flycheck-mode t)))

(add-hook 'elpy-mode-hook
          '(lambda ()
             (progn
               (add-to-list 'flymake-err-line-patterns '("\\([^|]+\\)| \\([^:]+\\):\\([0-9]+\\)$" 2 3 nil 1))
                (set (make-local-variable 'flymake-warning-predicate) "^.[^EF]")
                )))

(require 'expand-region)
(require 'python-mode-expansions)

(setq py--imenu-create-index-p t)
(setq py-split-windows-on-execute-function (quote split-window-horizontally))
;;(py-exception-name-face ((t (:foreground "#94bff3"))))

(require 'linum)
(require 'pycoverage)

(defun my-coverage ()
  (interactive)
  (when (derived-mode-p 'python-mode)
    (progn
      (linum-mode t)
      (pycoverage-mode))))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key "\C-ca" 'pytest-pdb-all)
            (local-set-key "\C-cC-a" 'pytest-pdb-all)
            (local-set-key "\C-c0" 'pytest-pdb-one)))

(provide 'emp-python)

(defun pycoverage-line-format (linenum)
  (cond
   ((member linenum pycoverage-data)
    (propertize " " 'face '(:background "#FF7177" :foreground "#FF7177")))
   (pycoverage-data
    ;; covered data
    (propertize " " 'face '(:background "#181a26" :foreground "#14151E")))))

(defun py-straighten ()
  (interactive)
  (when (not (bolp)) (beginning-of-line))
  (backspace-blank-lines-or-char)
  (newline-and-indent))

(defun py-ipython-shell-paste ()
  (interactive)
  (end-of-buffer)
  (insert "%time %paste")
  (if (eq major-mode 'term-mode)
      (term-send-input)
    (comint-send-input)
    (comint-add-to-input-history (s-trim-right (substring-no-properties (car kill-ring)))))
  )



(company-mode 1)

(require 'cl)
(require 'tramp)

(defun c5-enable-x-forward (methods)
   (let ((ssh-method (find-if (lambda (x) (string-equal (car x) "ssh"))
methods)))
     (pushnew (list "-Y") (second (assoc 'tramp-login-args (cdr
ssh-method)))
              :test 'equal)))

(c5-enable-x-forward tramp-methods)


(defun c6-enable-x-forward (methods)
   (let ((ssh-method (find-if (lambda (x) (string-equal (car x) "scp"))
methods)))
     (pushnew (list "-Y") (second (assoc 'tramp-login-args (cdr
ssh-method)))
              :test 'equal)))


(c6-enable-x-forward tramp-methods)




(global-set-key (kbd "C-M-k") 'py-kill-def-or-class)
(global-set-key (kbd "M-d") 'elpy-goto-definition)






;;comint-preoutput-filter-functions

;;(remove-hook 'comint-preoutput-filter-functions 'comintyd)
