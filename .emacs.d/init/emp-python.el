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



;; new pyenv virtualenv
;; pip install flake8 jedi pdir2 pytest autopep8
;; pip install scikit-learn==0.19.0 scipy==0.19.0 xtoy



(require 'python-mode)

(require 'python)

;; otherwise: pytest-run: Symbol’s value as variable is void: python-shell--interpreter-args
(setq python-shell--interpreter "python")
(setq python-shell--interpreter-args '(""))

(setq python-shell-interpreter-args "-i --simple-prompt")

(setq company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                          company-preview-frontend
                          company-echo-metadata-frontend))

;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt")

;; (setenv "VIRTUAL_ENV" "spacy")
(setenv "PYENV_VERSION" "")

;(setenv "PATH" "/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/pascal/.pyenv/shims:/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/pascal/.pyenv/shims:/home/pascal/bin:/home/pascal/python/bin:/home/pascal/.nvm/versions/node/v7.10.0/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/pascal/.bashhub/bin:/home/pascal/.gem/ruby/2.4.0/bin")
;(setenv "PATH" "/home/pascal/python/bin:/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/pascal/.pyenv/shims:/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/pascal/.pyenv/shims:/home/pascal/bin:/home/pascal/.nvm/versions/node/v7.10.0/bin:/opt/google-cloud-sdk/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/pascal/.bashhub/bin:/home/pascal/.gem/ruby/2.4.0/bin")
(setenv "PATH" "/home/pascal/.local/share/virtualenvs/mypython--KaCTqkX/bin:/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/pascal/.pyenv/shims:/opt/pyenv/plugins/pyenv-virtualenv/shims:/home/pascal/.pyenv/shims:/home/pascal/bin:/home/pascal/.nvm/versions/node/v7.10.0/bin:/opt/google-cloud-sdk/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/snapd/snap/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/pascal/.bashhub/bin:/home/pascal/.gem/ruby/2.4.0/bin")

(add-to-list 'exec-path "/home/pascal/.local/share/virtualenvs/mypython--KaCTqkX/bin")

;(setenv "PYTHONPATH" "")

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
    (setq python-shell-interpreter "ipython")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 6)
    (setq python-python-command "/home/pascal/intel/intelpython3/bin/ipython")
    (setq python-shell-interpreter "/home/pascal/intel/intelpython3/bin/ipython")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 2)
    (setq python-python-command "ipython2")
    (setq python-shell-interpreter "ipython2")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 3)
(setq python-python-command "/home/pascal/.local/share/virtualenvs/mypython--KaCTqkX/bin/ipython")
    (setq python-shell-interpreter "/home/pascal/.local/share/virtualenvs/mypython--KaCTqkX/bin/ipython")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 7)
    (setq python-python-command "/home/pascal/python/bin/ipython")
    (setq python-shell-interpreter "/home/pascal/python/bin/ipython")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  ;; remote
  (when (eq arg 8)
    (setq python-python-command "/home/pascal/.pyenv/versions/3.7.0/bin/ipython")
    (setq python-shell-interpreter "/home/pascal/.pyenv/versions/3.7.0/bin/ipython")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 4)
    (setq python-python-command "/usr/local/bin/ipython_fix")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (when (eq arg 5)
    (setq python-python-command "/home/pascal/.local/share/virtualenvs/mypython--KaCTqkX/bin/ipython")
    (setq python-shell-interpreter "/home/pascal/.pyenv/shims/ipython")
    (setq  pybuffname (concat "*IPython-*" (car (last (s-split "/" (getenv "VIRTUAL_ENV")))))))
  ;;pypy
  (when (eq arg 9)
    ;; make it so that pypy's ipython is linked to "ipypy" in your bin, yes.. ipypy is a new name,
    ;; e.g.: (setq python-python-command "/Users/pascal/Downloads/pypy-2.5.1-osx64/bin/ipython")
    (setq python-python-command "ipypy")
    (setq  pybuffname (concat "*IPyPy" (int-to-string arg) "*")))
  (when (not pybuffname)
    (setq python-python-command "/home/pascal/python/bin/ipython")
    (setq python-shell-interpreter "/home/pascal/python/bin/ipython")
    (setq  pybuffname (concat "*IPython" (int-to-string arg) "*")))
  (new-python-get-text)
  (if (eq arg 0)
      (shell-command (concat "echo \"" (s-replace "\"" "\\\"" (substring-no-properties (car kill-ring))) "\" | xclip -selection clipboard") nil))
  (if (get-buffer pybuffname)
      (switch-to-buffer-other-window pybuffname)
    (delete-other-windows)
    (if (not (string-match "pypy" python-python-command))
        (progn
          (py-shell nil t python-python-command pybuffname)
          (switch-to-buffer-other-window pybuffname)
          ;; on startup "hooks"
          (insert "def _get_modules(): return set([x for x in globals() if isinstance(globals()[x], ModuleType) and not x.startswith('_')]);")
          (comint-send-input)
          (insert "def run_asyncio(coro): asyncio.get_event_loop().run_until_complete(coro)")
          (comint-send-input)
          (insert "import pdir; import pandas as pd; pd.set_option('precision', 10); import imp; import sys; from types import ModuleType; _init_modules = _get_modules(); del sys; import asyncio;asyncio.run = run_asyncio")
          (comint-send-input))
      (split-window-right)
      (switch-window)
      (ansi-term "ipypy" (concat "IPyPy" (int-to-string arg)))))
  (end-of-buffer)
  (insert "%time %paste")
  (if (eq major-mode 'term-mode)
      (term-send-input)
    (comint-send-input)
    (comint-add-to-input-history (s-trim-right (substring-no-properties (car kill-ring)))))
  (setq kill-ring (cdr kill-ring))
  (sleep-for 0.01)
  (search-backward "%time %paste")
  (ignore-errors (delete-region (line-beginning-position) (+ 1 (line-end-position))))
  (end-of-buffer)
  (other-window -1))

(add-hook 'python-mode-hook
          '(lambda()
             (define-key python-mode-map (kbd "C-<return>") 'new-python-eval)
             (define-key python-mode-map (kbd "C-M-<backspace>") 'py-straighten)
             (define-key python-mode-map (kbd "C-<") 'python-eval-upwards)
             (define-key python-mode-map (kbd "C-c C-l") '(lambda () (interactive) (importmagic-mode) (ignore-errors (importmagic-fix-symbol-at-point)) (importmagic-mode -1)))
             ;(define-key python-mode-map (kbd "<tab>") 'indent-for-tab-command)
             (define-key python-mode-map (kbd "C->") 'python-eval-buffer)))

(define-key python-mode-map (kbd "C-c c") 'python-send-my-buffer)

(define-key python-mode-map (kbd "<tab>") 'py-shift-right)
(define-key python-mode-map [backtab] 'py-shift-left)

(define-key python-mode-map (kbd "C-<backspace>") 'backward-delete-word)
(define-key py-ipython-shell-mode-map (kbd "C-<backspace>") 'backward-delete-word)

(define-key python-mode-map [backspace] 'backspace-blank-lines-or-char)
(define-key python-mode-map [delete] 'delete-blank-lines-or-char)

(define-key comint-mode-map (kbd "s-r") 'comint-history-isearch-backward-regexp)

(defun add-inferior-python-keywords()
  "adds a few keywords for inferior-python mode"
  (font-lock-add-keywords nil
                          '(
                            ("time:.+" . 'font-lock-variable-name-face)
                            )
                          )
  )

(add-hook 'comint-mode-hook 'add-inferior-python-keywords)
;(add-hook 'comint-mode-hook 'smartparens-mode)



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

;(setenv "PYTHONPATH" "/Users/pascal/watson/WEX/API/")

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

(elpy-enable)

(add-hook 'python-mode-hook
          '(lambda ()
             (progn
               ;(elpy-enable)
               (setq-local flymake-start-syntax-check-on-newline t)
               (setq elpy-rpc-python-command "python")
               ;;(elpy-use-ipython "/home/pascal/python/bin/ipython")
               ;; (setq elpy-rpc-backend "company")
               (setq elpy-rpc-backend "jedi")
               ;;(setq elpy-syntax-check-command (concat emacsd "pyflymake.py"))
               (setq elpy-syntax-check-command "flake8")
               ;;(setq elpy-syntax-check-command "pylint")
               ;; (jedi:ac-setup)
               (setq python-check-command "pylint")
               ;;(setq elpy-syntax-check-command "pylint")
               (pyvenv-workon "mypython--KaCTqkX")
               (define-key elpy-mode-map (kbd "C-<return>") 'new-python-eval)
               (define-key elpy-mode-map (kbd "M-<left>") nil)
               (define-key elpy-mode-map (kbd "M-<right>") nil)
               (setq elpy-test-runner 'elpy-test-pytest-runner)
                                        ;(add-hook 'before-save-hook (lambda () (when (eq major-mode 'python-mode)) 'elpy-format-code))
               ;(add-hook 'before-save-hook (lambda () (when (eq major-mode 'python-mode)) 'elpy-format-code))
               )))

(company-mode 1)

(add-hook 'python-mode-hook
          (lambda ()
            (flycheck-mode t)
            (define-key python-mode-map (kbd "C-p") 'python-makecurrent)))

(require 'blacken)

(setq blacken-line-length 100)
(setq blacken-allow-py36 t)
(setq blacken-fast-unsafe t)
(setq blacken-skip-string-normalization t)

(defun toggle-blacken ()
  (interactive)
  (if (eq blacken-line-length 88)
      (setq blacken-line-length 100)
    (setq blacken-line-length 88))
  (message "length: %s" blacken-line-length))

(add-hook 'python-mode-hook 'blacken-mode)

;(add-hook 'python-mode-hook #'(lambda () (setq flycheck-checker 'python-pylint)))

; (remove-hook 'elpy-modules 'elpy-module-flymake)

;; (add-hook 'elpy-mode-hook
;;           '(lambda ()
;;              (progn
;;                (add-to-list 'flymake-err-line-patterns '("\\([^|]+\\)| \\([^:]+\\):\\([0-9]+\\)$" 2 3 nil 1))
;;                 (set (make-local-variable 'flymake-warning-predicate) "^.[^EF]")
;;                 )))

(add-hook 'elpy-mode-hook
          '(lambda ()
             (progn
               (define-key elpy-mode-map (kbd "C-<return>") 'new-python-eval)
               (company-mode 1)
               (define-key elpy-mode-map (kbd "C-<right>") 'right-word)
               (define-key elpy-mode-map (kbd "C-<left>") 'left-word)
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
            (local-set-key "\C-ct" 'pytest-all)
            (local-set-key "\C-c0" 'pytest-pdb-one)
            (local-set-key "\C-cm" 'pytest-module)))

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

(defun python-find-arg-bounds (arg)
  (interactive "p")
  (let ((start (save-excursion (search-backward-regexp "[,(]" 0 t)))
        (end (save-excursion (search-forward-regexp "[,)]" (point-max) t))))
    (delete-region (+ 1 start) (- end 1))
    (delete-horizontal-space)))

(require 'importmagic)
;; (add-hook 'python-mode-hook 'importmagic-mode)


(add-hook 'post-command-hook
          (lambda ()
            (if (s-contains? "entis" (or (buffer-file-name) ""))
                (progn (setq blacken-line-length 88)
                       (setq blacken-skip-string-normalization nil))
              (setq blacken-line-length 100)
              (setq blacken-skip-string-normalization t))))


(defun python-eval-upwards (arg)
  (interactive "p")
  (save-excursion
    (set-mark-command nil)
    (beginning-of-buffer)
    (new-python-eval arg)))

(defun python-eval-buffer (arg)
  (interactive "p")
  (save-excursion
    (beginning-of-buffer)
    (set-mark-command nil)
    (end-of-buffer)
    (new-python-eval arg)))



(require 'cl)
(require 'tramp)

;; (defun c5-enable-x-forward (methods)
;;   (let ((ssh-method (find-if (lambda (x) (string-equal (car x) "ssh"))methods)))
;;      (pushnew (list "-Y") (second (assoc 'tramp-login-args (cdr ssh-method)))
;;               :test 'equal)))

;; (c5-enable-x-forward tramp-methods)


;; (defun c6-enable-x-forward (methods)
;;    (let ((ssh-method (find-if (lambda (x) (string-equal (car x) "scp"))
;; methods)))
;;      (pushnew (list "-Y") (second (assoc 'tramp-login-args (cdr
;; ssh-method)))
;;               :test 'equal)))


;; (c6-enable-x-forward tramp-methods)





(global-set-key (kbd "C-M-k") 'py-kill-def-or-class)
(global-set-key (kbd "M-d") 'elpy-goto-definition)


(defun py-reload-all ()
  (interactive)
  (switch-to-buffer-other-window pybuffname)
  (insert "import sys; import pandas as pd; pd.set_option('precision', 10); del pd;_ = [imp.reload(globals()[x]) for x in _get_modules() - _init_modules if x in sys.modules]; print('Reloaded.')")
  (comint-send-input))

(defun flip-boolean ()
  (interactive)
  (search-forward-regexp "\\(False\\|True\\)")
  (if (string-equal (substring-no-properties (match-string 0)) "False")
      (message (replace-match "True"))
    (message (replace-match "False"))))

(global-set-key (kbd "C-b") 'flip-boolean)

;; ipython3 version 5 fix
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")

(require 'smartparens-python)

;;comint-preoutput-filter-functions

;;(remove-hook 'comint-preoutput-filter-functions 'comintyd)

;; (defun python-shell-comint-end-of-output-p (output)
;;   "Return non-nil if OUTPUT is ends with input prompt."
;;   (let ((debug-on-error t))
;;       (string-match
;;                  ;; XXX: It seems on macOS an extra carriage return is attached
;;                  ;; at the end of output, this handles that too.
;;                  (concat
;;                   "\r?\n?"
;;                   ;; Remove initial caret from calculated regexp
;;                   (replace-regexp-in-string
;;                    (rx string-start ?^) ""
;;                    python-shell--prompt-calculated-input-regexp)
;;                   (rx eos))
;;                  output)))

;; (when (require 'flycheck nil t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))


;(global-set-key "\"" '(lambda () (interactive) (smartparens-mode -1) (insert "\"") (smartparens-mode 1)))

(defun set-python-virtual-env (arg env)
  (interactive "P\nsVirtual env name: ")
  (setenv "VIRTUAL_ENV" env)
  (message "Set env to '%s'" env))

;; (add-hook 'python-mode-hook
;;           '(lambda ()
;;           (define-key python-mode-map "\"" '(lambda () (interactive) (insert "\"") (smartparens-mode -1) (let ((rb (region-beginning))
;;        (re (+ 1 (region-end)))) (goto-char rb) (insert "\"") (goto-char re) (insert "\"") (smartparens-mode 1))))))



;; (add-to-list 'display-buffer-alist
;;              `(,(rx bos "*" "pdb " (+? nonl) "*" eos)
;;                (display-buffer-in-side-window)
;;                (reusable-frames . visible)
;;                (side            . right)
;;                (slot            . 1)
;;                (window-width    . 0.5)))

(defun cb-gud--setup-realgud-windows (&optional buffer)
  (interactive)
  (let* ((buffer (or buffer (current-buffer)))
          (src-buffer (realgud-get-srcbuf buffer))
          (cmd-buffer (realgud-get-cmdbuf buffer)))
    (display-buffer cmd-buffer)
    (select-window (display-buffer src-buffer))))

(with-eval-after-load 'realgud
  (defalias 'realgud-window-src-undisturb-cmd #'cb-gud--setup-realgud-windows))

(require 'subr-x)

(defun cb-gud--realgud-command-for-mode (mode)
  (pcase mode
    (`python-mode
      (lambda ()
        (let* ((file (shell-quote-argument (file-relative-name (buffer-file-name))))
               (args (list "ipdb3" file)))
          (realgud:run-process "ipdb" (buffer-file-name) args 'realgud:pdb-minibuffer-history))))))

(defun realgud ()
  (interactive)
  (let ((buf (current-buffer)))
    (unless (or (realgud-get-cmdbuf) (realgud-get-current-srcbuf))
      (if-let (command (cb-gud--realgud-command-for-mode major-mode))
          (funcall command)
        (error "No realgud support for %s" major-mode)))
    (cb-gud--setup-realgud-windows buf)
    (define-key realgud:shortkey-mode-map [mouse-1]  'realgud:tooltip-eval)
    (buf-move-left)))



(defun testblack ()
  (interactive)
 (let ((url-request-method        "POST")
          (url-request-extra-headers `(("X-Line-Length" . "100")))
          (url-request-data          (buffer-string)))
   (let ((buffer (url-retrieve-synchronously "http://localhost:45484" nil))
         (tmpfuck "")
         (oldpoint (point)))
     (with-current-buffer buffer
       (setq tmpfuck (s-join "\n\n" (cdr (s-split "\n\n" (buffer-string) 1)))))
     (message "ok %s" tmpfuck)
     (when (not (string-equal tmpfuck ""))
         (erase-buffer)
     (insert tmpfuck)
     (goto-char oldpoint)))))
