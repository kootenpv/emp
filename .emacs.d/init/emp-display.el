(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq show-paren-style 'expression)

(setq show-trailing-whitespace t)

;; turn on parenthesis matching
(show-paren-mode t)
(setq show-paren-style 'mixed)
(setq show-paren-delay 0)

;;remove tutorial & visible
(setq inhibit-startup-message t)
(setq visible-bell t)

(delete-selection-mode t)

;; ;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; ; cursor as bar
(set-default 'cursor-type 'bar)

(set-frame-parameter (selected-frame) 'internal-border-width 10)

(setq frame-title-format '(buffer-file-name "%f" ("%b")))

(toggle-truncate-lines 1)

(load-theme 'kooten)

(powerline-reset)

(custom-set-faces
 '(fringe ((t (:foreground "#14151E")))))

;; it is used two times, also here and init.el for some reason
;; (setq ns-auto-hide-menu-bar t)
;; (set-frame-position nil 0 -21)
;; (tool-bar-mode 0)
;;

;; (set-frame-size nil 236 61)

;; (toggle-frame-maximized)

(setq company-tooltip-minimum-width 40)

(provide 'emp-display)
