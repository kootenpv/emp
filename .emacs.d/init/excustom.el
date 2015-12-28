(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(abbrev-file-name (concat emacsd "abbrev_defs"))
 '(custom-safe-themes
   (quote
    ("20e98f30034dabb3ed0f0f94bc13349c8ac14d51d9f7cfa30019269d03a1f013" "eb704796fc4edac3ab1ac7ed43c0eeabbb286457b20ab4ce648dcb1e2b83eb90" "224ca2e641aaf631a06b03f7ee8964368c3fde0eb1e24d85807e0d9fbb54254b" "614d92e2a3af6a08bfe6ff68a59875f987271415c3bda7bec1216b80f5db741d" "b71f088057342614a34df320aa231648b944c7f37f887b2ab240d2484fe2c32f" "63b3c71af4135dfd2d01ad45b002803031ed4e4b1589267f324e41358a9cd34e" "08520ce888c525b45943bc158d1fc49ca0498c1f2aab6a2e25b8ea019d4f7455" "12a53a93c11a548377dfb4b511153e66fa583fb7c40920b30386bea5c8403feb" "7a5f3895f84a1223416f8fafca1d7fa4e986fdff8f2ba5b5363fe4b4c8a5ff3b" "f795380126ffe8272334a561b11f461ca7cad6239f17a0738747b4675757d61f" "331dd0541de573984b7a9f2b2360b6597acdda543aad91b94ad7e002b183208c" "422d796d432f9f579376ad5ee7a7586db10e6d0d3d5cf0306d9498d17095fd56" "7e39bb1def96d46d7612ac2bd04e164f4716d835e7b3a0dd61d1ca7765f0f9b7" "aba5fa44ec764b953a613cf0765c728d4ffd95a9b7836f4298e8ee9ae82f4303" "439c056d775b26703786d0208a05d62c6a49bccd6cad54e8c4cfc711f206de12" "88e551b5d5da43c68f1c6be744c2f0d61a54115589be5b0cbded4925e0092a6a" "5cf73208d94a5eb0794fa7bbfb160d0400b74f83bfc92845fa32e6f9c6249e4d" "27ef078fbf041ead703825c0bcb2b929c186d59e41cfac9ab8321e9d8b35ba07" "35c0c8ef90e577b1db326e0242b4274f379cd9c31e841ca97353aeb7f2a88482" "29c99748df59785fecf4eb80de88de5a2d27f19ef94ea0464cf88561428f49cc" "4edf22caf617fd6aacfa763a993a1ac93856a8da025ed869a74a988fc0a78bd2" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "f342c60b631fed7c9db7921d1215f901b856e5c48d05f782856931ae97f5d5c5" "bbdec2b8e75bb8378d4be4d8e96631acc0a4a62836b079ae71b1386dc07f97db" "60538eb9bfc7a3cc6f06ba8758b3da22cea8559bde92d3a79bd24cde3f2ae7e9" "9a0297e03451fa744981ff93d75e02eeba99ec7b2d4d4a078ded6f21adf4ace8" "f024aea709fb96583cf4ced924139ac60ddca48d25c23a9d1cd657a2cf1e4728" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "6e92ca53a22d9b0577ad0b16e07e2e020c8b621197e39fec454048e51b7954cb" "60f04e478dedc16397353fb9f33f0d895ea3dab4f581307fbf0aa2f07e658a40" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "42378bf40f4a7b407accdd8f001fd75e4e70e080c61b5dc732fcd4745fff5463" default)))
 '(elscreen-mode-to-nickname-alist
   (quote
    (("^dired-mode$" lambda nil
      (format "Dired(%s)" dired-directory))
     ("^Info-mode$" lambda nil
      (format "Info(%s)"
              (file-name-nondirectory Info-current-file)))
     ("^mew-draft-mode$" lambda nil
      (format "Mew(%s)"
              (buffer-name
               (current-buffer))))
     ("^mew-" . "Mew")
     ("^irchat-" . "IRChat")
     ("^liece-" . "Liece")
     ("py$" lambda nil
      (format "py-(%s)"
              (buffer-name
               (current-buffer)))))))
 '(package-archives
   (quote
    (("melpa" . "http://melpa.milkbox.net/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(py-imenu-create-index-p t)
 '(py-pylint-command "/usr/local/bin//pylint")
 '(py-split-windows-on-execute-function (quote split-window-horizontally))
 '(python-mode-hook
   (quote
    (turn-on-eldoc-mode
     (lambda nil
       (key-chord-define python-mode-map "jj"
                         (quote my-python-eval)))
     er/add-python-mode-expansions hs-minor-mode)) t)
 '(python-python-command "python")
 '(recentf-max-menu-items 70)
 '(recentf-max-saved-items 69)
 '(tabbar-separator (quote (0.5)))
 '(whitespace-style (quote (face lines newline indentation))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(py-exception-name-face ((t (:foreground "#94bff3")))))
