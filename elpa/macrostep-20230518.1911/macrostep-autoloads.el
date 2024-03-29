;;; macrostep-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "macrostep" "macrostep.el" (0 0 0 0))
;;; Generated autoloads from macrostep.el

(autoload 'macrostep-mode "macrostep" "\
Minor mode for inline expansion of macros in Emacs Lisp source buffers.

If called interactively, enable Macrostep mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\\<macrostep-mode-map>Progressively expand macro forms with \\[macrostep-expand], collapse them with \\[macrostep-collapse],
and move back and forth with \\[macrostep-next-macro] and \\[macrostep-prev-macro].  Use \\[macrostep-collapse-all] or collapse all
visible expansions to quit and return to normal editing.

\\{macrostep-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'macrostep-expand "macrostep" "\
Expand the macro form following point by one step.

Enters `macrostep-mode' if it is not already active, making the
buffer temporarily read-only.  If `macrostep-mode' is active and the
form following point is not a macro form, search forward in the
buffer and expand the next macro form found, if any.

With a prefix argument, the expansion is displayed in a separate
buffer instead of inline in the current buffer.  Setting
`macrostep-expand-in-separate-buffer' to non-nil swaps these two
behaviors.

\(fn &optional TOGGLE-SEPARATE-BUFFER)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "macrostep" '("macrostep-")))

;;;***

;;;### (autoloads nil "macrostep-c" "macrostep-c.el" (0 0 0 0))
;;; Generated autoloads from macrostep-c.el

(autoload 'macrostep-c-mode-hook "macrostep-c" nil nil nil)

(add-hook 'c-mode-hook #'macrostep-c-mode-hook)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "macrostep-c" '("macrostep-c-")))

;;;***

;;;### (autoloads nil nil ("macrostep-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; macrostep-autoloads.el ends here
