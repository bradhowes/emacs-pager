;; emacs-pager -- defines function called from emacsclient to show contents of temp file.
;;

(provide 'emacs-pager)

(defvar emacs-pager-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "q") (function quit-window))
    map)
  "Keymap for emacs-pager-mode")

(defcustom emacs-pager-max-line-coloring 2000
  "Maximum number of lines to ansi-color a buffer."
  :group 'emacs-pager :type '(integer))

(defcustom emacs-pager-delete-file-after-load nil
  "If true, emacs-pager will delete the file given to it after reading into buffer."
  :group 'emacs-pager :type '(choice (const :tag "Yes" t)
                                     (const :tag "No" nil)
                                     (other :tag "Ask" ask)))

(define-derived-mode emacs-pager-mode fundamental-mode "Pager"
  "Mode for viewing data brought in by emacs-pager"
  ;;Treat buffer as read-only
  (setq-local backup-inhibited t
              view-read-only t)
  (buffer-disable-undo)
  (ansi-color-apply-on-region (goto-char (point-min))
                              (save-excursion
                                (forward-line emacs-pager-max-line-coloring)
                                (point)))
  (set-buffer-modified-p nil)
  (read-only-mode t))

;;###autoload
(defun emacs-pager (path)
  (find-file-other-window path)
  (emacs-pager-mode)
  (when emacs-pager-delete-file-after-load
    (if (or (eq emacs-pager-delete-file-after-load t)
            (y-or-n-p (format "Delete temporary file '%s'?" path)))
        (delete-file path)))
  (message "%s" "Press `q' to exit pager view."))
