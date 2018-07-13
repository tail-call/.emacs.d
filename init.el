;; Tommy's .emacs file
;; Created: August of 2014

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
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "chromium")
 '(c-basic-offset 4)
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (c++-mode . "linux")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "gnu"))))
 '(custom-enabled-themes (quote (deeper-blue)))
 '(display-battery-mode t)
 '(electric-indent-mode nil)
 '(eww-download-directory "~/dl/")
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(load-home-init-file t t)
 '(lua-indent-level 4 t)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("marmalade" . "http://marmalade-repo.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (rjsx-mode haxe-mode simpleclip evil-magit magit nodejs-repl scala-mode web-mode yaml-mode markdown-mode ag zone-nyan xelb newlisp-mode nav lua-mode go-mode evil charmap)))
 '(python-shell-interpreter "python3")
 '(scheme-program-name "guile")
 '(scroll-bar-mode nil)
 '(show-trailing-whitespace t)
 '(speedbar-show-unknown-files t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(web-mode-markup-indent-offset 2))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#243035" :foreground "#bcc3c7" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "PfEd" :family "DejaVu Sans Mono"))))
 '(variable-pitch ((t (:family "Times New Roman")))))

;; Enable crap

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'erase-buffer 'disabled nil)

;; Make slime work

(require 'cl)
(require 'slime)
(setq-default inferior-lisp-program "sbcl")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
(slime-setup)

;; This will make installed packages actually work

(package-initialize)

;; Lua mode setup

(customize-set-variable 'lua-indent-level 4)

;; EVIL !!

(require 'evil)
(evil-mode 1)

;; Simple clip

(require 'simpleclip)
(simpleclip-mode 1)

;; Nice macros

(defmacro global-set-keys (key command &rest more)
  "Give KEYs global bindings as COMMANDs.

This is a vararg extension to `global-set-key'."
  `(progn
     (global-set-key ,key ,command)
     ,(when more
        `(global-set-keys ,@more))))

;; Speedy speedbar
(global-set-key (kbd "<kp-enter>") 'speedbar)

;; Read extensions from ~/.emacs.d/lisp

;; (mapc (lambda (x) (push x load-path))
;;       '("~/.emacs.d/lisp/pony-scratch/"
;;      "~/.emacs.d/lisp/"))

;(add-to-list 'load-path "~/.emacs.d/lisp/")

;(add-to-list 'load-path "~/.emacs.d/lisp/pony-scratch/")

;; I want to know my column number.
(column-number-mode)

;; Empty lines

(setq-default indicate-empty-lines t)

;; This makes C-q work with hex numbers instead of octal
;; Usage: C-q 0 a b 9 <enter> will type character U+0AB9

(setq-default read-quoted-char-radix 16)

;; This makes Dired blah-blah-blah.

(setq-default dired-listing-switches "-blah --group-directories-first")

;; This makes Dired hide details by default

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; No tabs - no fabs (implying fabs are bad)

(setq-default indent-tabs-mode nil)


;; Emacs Pinkie

;(require 'pony-scratch)

;(let ((phrases ["Java sucks!"
;                "Everything sucks!"
;                "Type C-x C-c now! Save me from dealing with you."
;                "Your typing speed amuse me."
;                "Pink!"
;                "Let'th procethth thome lithtth!"
;                "values of β will give rise to dom!"
;                "Ponk!"
;                "I'm pretty, ain't I?"
 ;               "I hate you because you use vim a lot."
 ;               "So-o-o-no?.."
 ;               "My other cake is cdke."
 ;               "SEXP."
 ;               "pinkie@pie ~$ screw you"
 ;               "Who's the worst pony? YOU ARE!"
 ;               "There's nothing wrong with vim, something's wrong with YOU."
 ;               "I'm the operator with my pocket evaluator!"
 ;               "Don't forget that I don't care."
 ;               "Sexp joke!"
 ;               "You know what looks like a big defun? YOUR FACE!"
 ;               "I'm just a picture. No need to be offended."
 ;               "RNG ERROR"
 ;               "Ceep kalm and sfuhfle lterets."
 ;               "Welcome to Emacs!.. I decided to be silly today."
 ;               "Sexp in need is a sexp, indeed!"
 ;               "= = ==  = ==  ===  = = JUST WHAT I NEED!"
 ;               "If you think something is obvious, it's most likely because you're undereducated."
 ;               "Prepare your eye sockets for visual delights and good time shenaningas."
 ;               "Sexp considered harmful."
 ;               "Feuerboch!"]))
 ; (pony-scratch (aref phrases (random (length phrases)))))

;;; KEY BINDINGS

;; Smart C-a

(defun beginning-of-line-dwim ()
  "Go to first nonblank character or beginning of line."
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

;; I want async/await to be highlighted
(font-lock-add-keywords
 'js-mode
 '(("\\<\\(async\\|await\\|of\\|\\)\\>" . 'font-lock-keyword-face)))

;; Evil mode SPC prefixed keys

(define-key evil-normal-state-map (kbd "SPC a") 'ag)
(define-key evil-normal-state-map (kbd "SPC w") 'widen)
;; (define-key evil-normal-state-map (kbd "SPC b c") 'erase-buffer)
;; (define-key evil-normal-state-map (kbd "SPC b n") 'switch-to-next-buffer)
;; (define-key evil-normal-state-map (kbd "SPC b p") 'switch-to-prev-buffer)
;; (define-key evil-normal-state-map (kbd "SPC b k")
;;   (lambda () (interactive)
;;     (kill-buffer (current-buffer))))
(define-key evil-normal-state-map (kbd "SPC o m")
  (lambda () (interactive)
    (find-file "~/org/main.org")))
(define-key evil-normal-state-map (kbd "SPC c") 'quick-calc)
(define-key evil-normal-state-map (kbd "SPC g") 'magit-status)

;; Easier indenting in normal and visual states

(define-key evil-normal-state-map (kbd "RET")
  (lambda () (interactive)
    (indent-for-tab-command)
    (evil-next-line)))

(define-key evil-visual-state-map (kbd "TAB")
  (lambda () (interactive)
    (indent-region (point) (mark))))

;; Easy evil narrowing

(define-key evil-visual-state-map (kbd "n")
  (lambda () (interactive)
    (narrow-to-region (point) (mark))
    (evil-exit-visual-state)))

(define-key evil-visual-state-map (kbd "w")
  (lambda () (interactive)
    (widen)
    (evil-exit-visual-state)))

;; Evil mode keybindings

(define-key
  evil-motion-state-map
  (kbd "C-w C-k")
  (lambda () (interactive)
    (kill-buffer (current-buffer))
    (evil-window-delete)))

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

(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; Evil magit

(evil-magit-init)

;; .emacs ends here
(put 'dired-find-alternate-file 'disabled nil)
