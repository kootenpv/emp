(setq jabber-account-list '( ("pvkooten@jibes.nl" (:password . "vrzkxmhwboiesonu") (:network-server . "talk.google.com") (:connection-type . ssl))
                             ("kootenpv@gmail.com" (:password . "!Ae7eb8739bccf6e6b9d8a348f1b72db") (:network-server . "talk.google.com") (:connection-type . ssl))))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(jabber-auto-reconnect t)
 '(jabber-avatar-verbose nil)
 '(jabber-vcard-avatars-retrieve nil)
 '(jabber-chat-buffer-format "*-jabber-%n-*")
 '(jabber-history-enabled t)
 '(jabber-use-global-history nil)
 '(jabber-backlog-number 40)
 '(jabber-backlog-days 30)
 '(jabber-mode-line-mode t)
 '(jabber-roster-buffer "*-jabber-*")
 '(jabber-roster-line-format " %c %-25n %u %-8s (%r)")
 '(jabber-show-offline-contacts nil))

(setq my-chat-prompt "[%t] %n>\n")
(when (featurep 'jabber)
  (setq
   jabber-chat-foreign-prompt-format my-chat-prompt
   jabber-chat-local-prompt-format my-chat-prompt
   jabber-groupchat-prompt-format my-chat-prompt
   jabber-muc-private-foreign-prompt-format "[%t] %g/%n>\n"
   )
  )

(defun notify-jabber-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via notify.el"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (notify (format "(PM) %s"
                       (jabber-jid-displayname (jabber-jid-user from)))
               (format "%s: %s" (jabber-jid-resource from) text)))
      (terminal-notifier-notify (format "%s" (jabber-jid-displayname from))
             text)))

(add-hook 'jabber-alert-message-hooks 'notify-jabber-notify)

(provide 'my-jabber)
