(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;; (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives
               '("melpa-stable" . "https://stable.melpa.org/packages/") t)

  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;; (unless (package-installed-p 'cider)
;;   (package-install 'cider))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("59171e7f5270c0f8c28721bb96ae56d35f38a0d86da35eab4001aebbd99271a8" default))
 '(package-selected-packages
   '(meghanada atom-one-dark-theme yasnippet-snippets paredit yasnippet cider)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(unless (package-installed-p 'yasnippet)
  (package-install 'yasnippet))
(unless (package-installed-p 'yasnippet-snippets)
  (package-install 'yasnippet-snippets))
(unless (package-installed-p 'paredit)
  (package-install 'paredit))
(unless (package-installed-p 'atom-one-dark-theme)
  (package-install 'atom-one-dark-theme))

(ido-mode t)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/ischaaf"))
;; find-library
(load-library "test")
(load-library "scratch")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/atom-one-dark-theme-0.4.0/")
(load-theme 'atom-one-dark t)
(set-background-color "color-235")

(use-package meghanada
  :ensure t
  :init
  ;; Don't auto-start
  (setq meghanada-auto-start nil)
  (when eos/use-meghanada
    (add-hook 'java-mode-hook #'meghanada-mode)
    (add-hook 'java-mode-hook 'flycheck-mode)
    (bind-key "C-c M-." 'meghanada-jump-declaration java-mode-map)))
