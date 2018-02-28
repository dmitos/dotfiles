;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))


(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    material-theme
    py-autopep8))


;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Añadir path del tema Dracula
 
(add-to-list 'custom-theme-load-path "~/.emacs.d/temas")
(load-theme 'dracula t)
  

;; OTROS PLUGINS
;;------------------------------------


(add-to-list 'load-path "C:/Users/dotero/AppData/Roaming/.emacs.d/autopair") ;; comment if autopair.el is in standard load path 
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;;------------------------------------
;; ORG-MODE
;;------------------------------------

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-todo-keywords
  '((sequence "TODO(t!)" "|" "TAREA [DIEGO](e@/!)" "ESPERANDO(s@/!)" "FINALIZADO(f!)")))

;;---------------------------------
;; copias de seguridad
;;--------------------------------
;; hace una copia cada 10 modificaciones
(setq auto-save-interval 1)

;; reloj
;(setq display-time)

;;----------------------------------
;; POWER-LINE
;;---------------------------------

(require 'powerline)
(powerline-default-theme)

;;(require 'tabbar)
;;;; turn on the tabbar
;;(tabbar-mode t)

;; (setq org-todo-keywords
;; '((sequence "TODO(!)" "DONE")))

(find-file "~/../../Documents/app/tareas.org")
