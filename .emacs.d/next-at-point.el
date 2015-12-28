
(defun next-at-point ()
  (interactive)
  (cond
   ((looking-back "[a-zA-Z]" (- (point) 1))
    (let ((kill-ring nil))
      (kill-backward-chars 1)
      (let ((letters (list "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "a" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "A"  )))
        (insert (nth 1 (member (substring-no-properties (car kill-ring)) letters)))))
    (message "Replaced letter"))

   ((skip-chars-backward "0123456789")
    (looking-at "[0123456789]+")
    (replace-match (number-to-string (1+ (string-to-number (match-string 0)))))
    (message "Replaced number"))

   (t
    (error "No number or letter at point")))
  )

(global-set-key (kbd "C-+") 'next-at-point)

(provide 'next-at-point)
