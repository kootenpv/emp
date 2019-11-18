;; Navi Mode
(define-minor-mode Navi-mode
  "Probably similar to Vim's normal mode."
  ;; Init value.
  nil
  ;; The indicator for the mode line.
  " Navi"

  ;; The minor mode keymap
  `(
    ;; Find files/buffers

    (,(kbd "f d") . (lambda () (interactive)
                      (find-file (concat empinit "emp-display.el")) (Navi-mode -1)))

    (,(kbd "f c") . (lambda () (interactive)
                      (find-file (concat empinit "emp-c++.el")) (Navi-mode -1)))

    (,(kbd "f m") . (lambda () (interactive)
                      (find-file (concat empinit "emp-misc-functions.el")) (Navi-mode -1)))

    (,(kbd "f e") . (lambda () (interactive)
                      (find-file (concat empinit "emp-external-plugins.el")) (Navi-mode -1)))

    (,(kbd "f E") . (lambda () (interactive)
                      (find-file (concat empinit "emp-external-packages.el")) (Navi-mode -1)))

    (,(kbd "f a") . (lambda () (interactive)
                      (find-file (concat empinit "emp-external-packages.el")) (Navi-mode -1)))

    (,(kbd "f N") . (lambda () (interactive)
                      (find-file (concat emacsd "my-notmuch.el")) (Navi-mode -1)))

    (,(kbd "f k") . (lambda () (interactive)
                      (find-file (concat empinit "emp-keybindings.el")) (Navi-mode -1)))

    (,(kbd "f i") . (lambda () (interactive)
                      (find-file (concat emacsd "init.el")) (Navi-mode -1)))

    (,(kbd "f S") . (lambda () (interactive)
                      (find-file "/home/pascal/.ssh/config") (Navi-mode -1)))

    (,(kbd "f s") . (lambda () (interactive)
                      (switch-to-buffer "*scratch*") (Navi-mode -1)))

    (,(kbd "f P") . (lambda () (interactive)
                      (find-file (concat empinit "emp-python.el")) (Navi-mode -1)))

    (,(kbd "f p") . (lambda () (interactive)
                      (find-file (concat emacsd "Navi-empty/empty.py")) (Navi-mode -1)))

    (,(kbd "f n") . (lambda () (interactive)
                      (find-file (concat empinit "navi.el")) (Navi-mode -1)))

    (,(kbd "f .") . (lambda () (interactive)
                      (find-file "~/.emacs") (Navi-mode -1)))

    (,(kbd "f L") . (lambda () (interactive)
                      (find-file (concat empinit "emp-latex.el")) (Navi-mode -1)))

    (,(kbd "f R") . (lambda () (interactive)
                      (find-file (concat empinit "emp-r.el")) (Navi-mode -1)))

    )
  :global t

  )

; Adding Navi to the syntax highlighting of emacs mode.
(make-face 'font-lock-Navi-face)
(set-face-foreground 'font-lock-Navi-face "cyan")

(make-face 'font-lock-success-face)
(set-face-attribute 'font-lock-success-face nil :foreground "green" :weight 'bold)

(defun add-custom-keywords()
  "adds a few keywords for emacs mode"
                    ;
  (font-lock-add-keywords nil
                          '(
                            ("Navi\\|navi" . 'font-lock-Navi-face)
                            ("\\s-nil\\s-\\|\\s-nil)\\|\\s-nil\n" . 'font-lock-warning-face)
                    ;("\\s"\\s\\s"" . 'font-lock-warning-face)
                            ("\\s-t\\s-\\|\\s-t)\\|\\s-t\n" . 'font-lock-success-face)
                            )
                          )
  )

                    ; hooks
(add-hook 'emacs-lisp-mode-hook 'add-custom-keywords)

(add-hook 'minibuffer-setup-hook (lambda () (Navi-mode -1)))

                    ; set variable for find-files associated with navi-mode

(defun go-bookmark-last (arg)
  (interactive "P")
  (require 'bookmark)
  ;;  (load "D:/emacs-24.1/site-lisp/ess1209/lisp/ess-site")
  (load "/home/pascal/GDrive/.emacs.d/init-kooten/emp-r")
  (bookmark-maybe-load-default-file)
  (bookmark-jump (concat "last" (int-to-string arg)))
  (message (concat "Went to most recent bookmark " (int-to-string arg) "."))
  )

(defun save-bookmark-as-last (arg)
  (interactive "P")
  (bookmark-set (concat "last" (int-to-string arg)))
  (message (concat "Saved as most recent bookmark: q" (int-to-string arg) "."))
  )


(provide 'navi)
