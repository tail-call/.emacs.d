;;; rjsx-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rjsx-mode" "rjsx-mode.el" (0 0 0 0))
;;; Generated autoloads from rjsx-mode.el

(autoload 'rjsx-mode "rjsx-mode" "\
Major mode for editing JSX files.

\(fn)" t nil)

(autoload 'rjsx-minor-mode "rjsx-mode" "\
Minor mode for parsing JSX syntax into an AST.

\(fn &optional ARG)" t nil)

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rjsx-mode" '("rjsx-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rjsx-mode-autoloads.el ends here
