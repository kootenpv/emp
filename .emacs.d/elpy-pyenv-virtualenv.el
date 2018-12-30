
(defun pyenv-mode-versions ()
  "List installed python versions."
  (let ((versions (shell-command-to-string "pyenv versions --bare")))
    (cons "system" (split-string versions))))

(defun pyenv-mode-read-version ()
  "Read virtual environment from user input."
  (completing-read "Pyenv: " (pyenv-mode-versions)))

;;;###autoload
(defun pyenv-mode-set (version)
  "Set python shell VERSION."
  (interactive (list (pyenv-mode-read-version)))
  (pythonic-activate (pyenv-mode-full-path version))
  (setenv "PYENV_VERSION" version)
  (force-mode-line-update))

;; pyenv virtualenv 3.6.2 brightml
;; pyenv local brightml
;; pip install ipython flake8 autopep8 jedi pdir pytest
;; pip install .
