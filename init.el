;; Maria's init.el file  -*- lexical-binding: t; -*-
;; Created: August of 2014

(message "begin loading init.el")
(setq lexical-binding t)

'( menu

   (find-file                           ; INDEX.org
    "~/Library/Mobile Documents/com~apple~CloudDocs/org/INDEX.org"
    )                                   ; C-x C-e

  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(auto-save-default nil)
 '(browse-url-browser-function 'browse-url-default-macosx-browser)
 '(browse-url-generic-program "open -a Safari")
 '(c-basic-offset 4)
 '(c-default-style
   '((c-mode . "linux")
     (c++-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu")))
 '(display-battery-mode t)
 '(display-raw-bytes-as-hex t)
 '(electric-indent-mode nil)
 '(eww-download-directory "~/Downloads/")
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/.emacs.d/init.el")
 '(initial-scratch-message nil)
 '(load-home-init-file t t)
 '(lua-indent-level 4 t)
 '(make-backup-files nil)
 '(menu-bar-mode t)
 '(org-agenda-files nil)
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")))
 '(package-selected-packages
   '(slime swift-mode xcode-project typescript-mode vue-mode bpftrace-mode rjsx-mode haxe-mode simpleclip evil-magit magit nodejs-repl scala-mode web-mode yaml-mode markdown-mode ag zone-nyan xelb newlisp-mode nav lua-mode go-mode evil charmap))
 '(python-shell-interpreter "python3")
 '(scheme-program-name "guile")
 '(scroll-bar-mode nil)
 '(show-trailing-whitespace t)
 '(speedbar-show-unknown-files t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(web-mode-markup-indent-offset 2)
 '(whitespace-style
   '(face trailing tabs spaces indentation::space space-after-tab space-before-tab space-mark tab-mark)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "PfEd" :family "Monaco"))))
 '(highlight ((t (:background "light blue"))))
 '(region ((t (:background "SpringGreen4"))))
 '(variable-pitch ((t (:family "Helvetica"))))
 '(whitespace-indentation ((t (:foreground "gray76"))))
 '(whitespace-space ((t (:foreground "gray76"))))
 '(whitespace-tab ((t (:foreground "gray76")))))

;; Nice macros

(defmacro global-set-keys (key command &rest more)
  "Give KEYs global bindings as COMMANDs.

This is a vararg extension to `global-set-key'."
  `(progn
     (global-set-key ,key ,command)
     ,(when more
        `(global-set-keys ,@more))))

(cl-labels
    (;; My config DSL

     (append-to-env (env-name component)
       (setenv env-name (concat (getenv env-name) component)))

     (enable-functions (&rest symbols)
       (dolist (symbol symbols)
         (put symbol 'disabled nil)))

     (define-spc-command (key function)
       (define-key evil-normal-state-map
                   (kbd (format "SPC %s" key)) function))
     )

  ;; Something you have to do on Mac for homebrew apps
  (append-to-env "PATH" ":/usr/local/bin")

  ;; Enable built-in emacs functions
  (enable-functions 'upcase-region
                    'downcase-region
                    'narrow-to-region
                    'narrow-to-page
                    'erase-buffer)

  ;; SLIME
  (progn
    (require 'slime)
    (setq-default inferior-lisp-program "/usr/local/bin/sbcl")
    (slime-setup))

  ;; Make installed packages work
  (package-initialize)

  ;; Indent in Lua mode
  (customize-set-variable 'lua-indent-level 4)

  (progn     ; Evil!!
    (require 'evil)
    (evil-mode 1))

  ;; Highlight current line
  (global-hl-line-mode +1)

  ;; Whitespace visualization
  (global-whitespace-mode +1)

  (progn ; Simple clip
    (require 'simpleclip)
    (simpleclip-mode 1))

  (progn ; Key bindings
    ;; Speedbar
    (global-set-key (kbd "<kp-enter>") 'speedbar)

    ;; macOS kill line backwards
    (global-set-key (kbd "<s-backspace>")
                    (lambda () (interactive) (kill-line 0))))

  ;; I want to know my column number.
  (column-number-mode)

  ;; Empty lines. Doesn't appear to work in macOS
  (setq-default indicate-empty-lines t)

  ;; This makes C-q work with hex numbers instead of octal
  ;; Usage: C-q 0 a b 9 <enter> will type character U+0AB9
  (setq-default read-quoted-char-radix 16)

  ;; macOS specific settings
  (when (eq system-type 'darwin)
    ;; Set macOS ⌘-C to copy stuff in visual state
    (define-key evil-visual-state-map (kbd "A-c") 'simpleclip-copy)

    ;; This tells dired to use 'gls' instead of 'ls' on macOS
    ;; Do 'brew install coreutils' if it doesn't work
    (setq insert-directory-program (executable-find "/usr/local/bin/gls")))

  (progn      ; Dired
    ;; blah-blah-blah
    (setq-default dired-listing-switches "-blah --group-directories-first")

    ;; Hide details by default
    (add-hook 'dired-mode-hook 'dired-hide-details-mode))

  (progn       ; Tabs
    (setq-default tab-width 4)
    (setq-default indent-tabs-mode nil))

  ;; KEY BINDINGS

  ;; Smart C-a
  (defun beginning-of-line-dwim ()
    "Go to first nonblank character or beginning of a line."
    (interactive)
    (if (bolp)
        (back-to-indentation)
      (beginning-of-line)))

  (global-set-key (kbd "C-a") 'beginning-of-line-dwim)

  ;; Scheme-mode hacks

  (defun scheme-send-buffer ()
    (interactive)
    (save-excursion
      (mark-whole-buffer)
      (scheme-send-region (point) (mark))))

  (add-hook 'scheme-mode-hook
            (lambda ()
              (put 'thunk 'scheme-indent-function 0)
              (put 'recur 'scheme-indent-function 1)
              (put 'receive 'scheme-indent-function 2)
              (put 'and-let* 'scheme-indent-function 1)
              (put 'when 'scheme-indent-function 1)
              (put 'unless 'scheme-indent-function 1)
              (put 'module 'scheme-indent-function 2)
              ;; This doesn't seem to work:
                                        ;           (setq scheme-font-lock-keywords
                                        ;                 (cons
                                        ;                  (cons
                                        ;                   (concat "("
                                        ;                           (regexp-opt '("when" "unless" "thunk" "recur"
                                        ;                                         "receive" "and-let*")))
                                        ;                   1)
                                        ;                  scheme-font-lock-keywords)

              (local-set-key (kbd "C-c C-b") 'scheme-send-buffer)
              ))

  ;; JS mode

  ;; (add-hook 'js-mode-hook
  ;;   (lambda ()
  ;;     (local-set-key (kbd "C-c C-e") 'nodejs-repl-send-last-sexp)
  ;;     (local-set-key (kbd "C-c C-r") 'nodejs-repl-send-region)
  ;;     (local-set-key (kbd "C-c C-b") 'nodejs-repl-send-buffer)))

  ;; I want ES6 keywords to be highlighted
  (font-lock-add-keywords
   'js-mode
   '(("\\<\\(async\\|await\\|of\\|as\\|from\\|\\)\\>" . 'font-lock-keyword-face)))

  (add-to-list 'auto-mode-alist '("\\.svelte\\'" . vue-mode))

  (progn                                ; Evil mode bindings
    (define-spc-command "a" 'ag)
    (define-spc-command "w" 'widen)
    (define-spc-command "c" 'quick-calc)
    (define-spc-command "g" 'magit-status)

    (define-spc-command
     "o m"
     (lambda () (interactive)
       (find-file "~/Library/Mobile Documents/com~apple~CloudDocs/org/INDEX.org")))

    (define-spc-command
     "i"
     (lambda () (interactive)
       (let ((indent-method (intern (read-from-minibuffer "Indent method (t or s): ")))
             (tab-width (string-to-number (read-from-minibuffer "Tab width: "))))
         (cond
          ((eq indent-method 't)
           (setq-default indent-tabs-mode t))
          ((eq indent-method 's)
           (setq-default indent-tabs-mode nil)
           (setq-default tab-width tab-width))
          (t (message "Invalid indent amethod. Use 't' or 's'."))))))

    (define-spc-command
     "w"
     (lambda () (interactive)
       (setq truncate-lines (not truncate-lines))))

    ;; (define-key evil-normal-state-map (kbd "SPC b c") 'erase-buffer)
    ;; (define-key evil-normal-state-map (kbd "SPC b n") 'switch-to-next-buffer)
    ;; (define-key evil-normal-state-map (kbd "SPC b p") 'switch-to-prev-buffer)
    ;; (define-key evil-normal-state-map (kbd "SPC b k")
    ;;   (lambda () (interactive)
    ;;     (kill-buffer (current-buffer))))

    ;; Easier indenting in normal and visual states

    (define-key evil-normal-state-map (kbd "RET")
                (lambda () (interactive)
                  (indent-for-tab-command)
                  (evil-next-line)))

    (define-key evil-visual-state-map (kbd "TAB")
                (lambda () (interactive)
                  (indent-region (point) (mark))))

    ;; Single key commenting out

    (define-key evil-visual-state-map (kbd ";")
                (lambda () (interactive)
                  (comment-region (point) (mark))))

    (define-key evil-normal-state-map (kbd ";")
                (lambda () (interactive)
                  (comment-line (line-number-at-pos))))

    ;; Easy narrowing

    (define-key evil-visual-state-map (kbd "n")
                (lambda () (interactive)
                  (narrow-to-region (point) (mark))
                  (evil-exit-visual-state)))

    (define-key evil-visual-state-map (kbd "w")
                (lambda () (interactive)
                  (widen)
                  (evil-exit-visual-state)))

    ;; Kill window

    (define-key
     evil-motion-state-map
     (kbd "C-w C-k")
     (lambda () (interactive)
       (kill-buffer (current-buffer))
       (evil-window-delete)))

    ;; Insert date

    (define-key evil-insert-state-map (kbd "C-§")
                (lambda (arg) (interactive "P")
                  (insert (format-time-string "%Y-%m-%d"))))

    (define-key evil-insert-state-map (kbd "C-±")
                (lambda (arg) (interactive "P")
                  (insert (format-time-string "=%H:%M=")))))

  ;; Snippet mini-extension
  (defmacro define-snippet (key &rest body)
    `(define-key evil-insert-state-map (kbd ,(concat "M-RET " key))
                 (lambda () (interactive)
                   (insert
                    (concat
                     ,@(mapcar (lambda (item)
                                 (if (stringp item)
                                     item
                                   `(read-string ,(concat "Type " (symbol-name item)
                                                          ": "))))
                               body))))))

  (define-snippet "{" "function " funcname " () {\n}")
  (define-snippet "v" "console.log(`" variable " = ${" variable "}`)")
  (define-snippet "c" "class " classname " ()\n{\n    constructor ()\n    {\n    }\n}")
  (define-snippet "h"
                  "<!DOCTYPE html>
<html>
  <head>
    <meta charset=\"utf-8\">
    <title>" title "</title>
  </head>
  <body>
  </body>
</html>")

  ;; Transparency

  (set-frame-parameter (selected-frame) 'alpha '(100 . 100))
  (add-to-list 'default-frame-alist '(alpha . (100 . 100)))

  ;; Evil magit

  (evil-magit-init)
  (put 'dired-find-alternate-file 'disabled nil)

  (defun __xxx__ ()
    (let ((mode (substring "t8" 0 1))
          (count (substring "t8" 1)))
      (setq-default tab-always-indent (equal mode "t"))
      (setq tab-width (string-to-number count))))

  )

;; Read extensions from ~/.emacs.d/lisp

;; (mapc (lambda (x) (push x load-path))
;;       '("~/.emacs.d/lisp/pony-scratch/"
;;      "~/.emacs.d/lisp/"))

;(add-to-list 'load-path "~/.emacs.d/lisp/")

;(add-to-list 'load-path "~/.emacs.d/lisp/pony-scratch/")

(message "end loading init.el")
;; init.el ends here
