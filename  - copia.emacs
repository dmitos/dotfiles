

;;--------------------------------------
;;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

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

;; Añadir path del tema Dracula
(add-to-list 'custom-theme-load-path "~/.emacs.d/temas")
(load-theme 'dracula t) ;; load dracula theme
(add-hook 'dired-mode-hook 'auto-revert-mode)
(setq show-trailing-whitespace 't) ; muestra los espacios en blanco

;;(global-linum-mode t) ;; enable line numbers globally

;; turn on visible bell
;;(setq visible-bell t)
;; auto refresh dired when file changes

;;--------------------------
;;SPEED BAR
;;-----------------------------

;(speedbar 1)
;(when window-system (speedbar t))
;(setq speedbar-mode-hook '(lambda ()(interactive)(other-frame 0)))

;-------------------------;
;;; Syntax Highlighting ;;;
;-------------------------;

; text decoration
(require 'font-lock)
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
(global-hi-lock-mode nil)
(setq jit-lock-contextually t)
(setq jit-lock-stealth-verbose t)

; if there is size information associated with text, change the text
; size to reflect it
(size-indication-mode t)


;;----------------------------------------------------------------------------
;; Show matching parens
;;----------------------------------------------------------------------------
(require 'paren)
(show-paren-mode 1)


;;------ probando numero a los costado y resalto de linea
(require 'linum)
(require 'hl-line)

(defface my-linum-hl
  `((t :inherit linum :background ,(face-background 'hl-line nil t)))
  "Face for the current line number."
  :group 'linum)
(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)

(defun my-linum-get-format-string ()
  (let* ((width (1+ (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat "%" (number-to-string width) "d \u2502")))
    (setq my-linum-format-string format)))

(defvar my-linum-current-line-number 0)

(defun my-linum-format (line-number)
  (propertize (format my-linum-format-string line-number) 'face
              (if (eq line-number my-linum-current-line-number)
                  'my-linum-hl
                'linum)))
(setq linum-format 'my-linum-format)

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)

(defvar *linum-mdown-line* nil)

(defun line-at-click ()
  (save-excursion
    (let ((click-y (cdr (cdr (mouse-position))))
          (line-move-visual-store line-move-visual))
      (setq line-move-visual t)
      (goto-char (window-start))
      (next-line (1- click-y))
      (setq line-move-visual line-move-visual-store)
      ;; If you are using tabbar substitute the next line with
      ;; (line-number-at-pos))))
      (1+ (line-number-at-pos)))))

(defun md-select-linum ()
  (interactive)
  (goto-line (line-at-click))
  (set-mark (point))
  (setq *linum-mdown-line*
        (line-number-at-pos)))

(defun mu-select-linum ()
  (interactive)
  (when *linum-mdown-line*
    (let (mu-line)
      ;; (goto-line (line-at-click))
      (setq mu-line (line-at-click))
      (goto-line (max *linum-mdown-line* mu-line))
      (set-mark (line-end-position))
      (goto-line (min *linum-mdown-line* mu-line))
      (setq *linum-mdown*
            nil))))
(global-set-key (kbd "<left-margin> <down-mouse-1>") 'md-select-linum)
(global-set-key (kbd "<left-margin> <mouse-1>") 'mu-select-linum)
(global-set-key (kbd "<left-margin> <drag-mouse-1>") 'mu-select-linum)

(add-hook 'find-file-hook (lambda () (linum-mode 1)))
(linum-mode)
(setq global-linum-mode t)
(global-hl-line-mode 't)
;;------ termina numero a los costados y resaltado de linea

;;------ visibilidad de alarma
;; Visible bell, but flash only modeline. Thanks to http://www.grantjenks.com/
(setq visible-bell nil)
(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.1 nil 'invert-face 'mode-line)))

;; Semi-bold and italic comments
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-comment-face nil :weight 'semibold)

;;------ termina visibilidad de alarma

;;--- escribe fecha y hora en la mode line
(setq display-time-day-and-date t)
(display-time)
;;--- escribe fecha y hora en la mode line ^

;;----------------------------------------------------------------------------
;; Recent files
;;----------------------------------------------------------------------------

(recentf-mode 1)
(setq-default
 recentf-max-saved-items 1000
 recentf-exclude '("/tmp/"))
;;----------------------------------------------------------------------------
;; Recent files finaliza
;;---------------
;; Ido mode to navigate filesystem
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)
;;------------- finaliza ido mode

;; eshell
;; Open eshell in new window
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)
(defun eshell-other-window ()
  "Opens `eshell' in a new window."
  (interactive)
  (let ((buf (eshell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))
;; finaliza eshell

;;----------------------------------------------------------------------------
;; Configure keys
;;----------------------------------------------------------------------------
(global-set-key (kbd "s-r") 'recentf-open-files)
(global-set-key (kbd "C-x M-c") 'recentf-open-files)
(define-key global-map "\C-ce" 'eshell-other-window)

;; Define keys for minibuffer history search
(define-key minibuffer-local-map (kbd "<prior>") 'previous-complete-history-element)
(define-key minibuffer-local-map (kbd "<next>") 'next-complete-history-element)

;;---------------------------------
;; copias de seguridad
;;--------------------------------
;; hace una copia cada 10 modificaciones
(setq auto-save-interval 1)

;;------- LINEA VERTICAL DE FIN DE LINEA
(require 'fill-column-indicator)
(add-hook 'after-change-major-mode-hook 'fci-mode)
(setq fci-rule-width 5)
(setq fci-rule-column 80)

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(global-flycheck-mode)
;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; OTROS PLUGINS
;;------------------------------------


(add-to-list 'load-path "C:/Users/dotero/AppData/Roaming/.emacs.d/autopair") ;; comment if autopair.el is in standard load path 
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;;----------------------------------
;; POWER-LINE
;;---------------------------------

(require 'powerline)
(powerline-default-theme)

;;---------------------------------
;; UNDO TREE
;;----------------------------------

(global-undo-tree-mode)

;;-----------------------------------
;; WHICH KEY
;;----------------------------------
(require 'which-key)
(which-key-mode)
(setq which-key-popup-type 'minibuffer)

;;------------------------------------
;; ORG-MODE
;;------------------------------------

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-todo-keywords
      '((sequence "TODO(t!)" "TAREA [DIEGO](e@/!)" "ESPERANDO(s@/!)" "|" "FINALIZADO(f!)")))

;; ;Las tareas marcadas para repetirse, al marcarlas cómo DONE vuelven al estado TODO y añade un timestamp del dia y la hora.
;; (defun org-summary-todo (n-done n-not-done)
;;   "Switch entry to DONE when all subentries are done, to TODO otherwise."
;;   (let (org-log-done org-log-states)   ; turn off logging
;;     (org-todo (if (= n-not-done 0) "FINALIZADA" "TODO"))))
;; (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; -----> esta parte siempre tiene que ir al final del .emacs
;; carga la pagina al principio
(find-file "//164.73.100.51/publico/Seccion Designaciones(BAD BOYS DE NATY)/tareas/tareas.org")
;;------> no poner nada por debajo de esto, a menos que sea para cargar
;;------> masc cosas
