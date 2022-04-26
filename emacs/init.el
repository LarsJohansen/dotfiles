;; Define the init file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Define and initialise package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Keyboard-centric user interface
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Theme
(use-package twilight-theme
  :config (load-theme 'twilight t))

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; Helm configuration
  (use-package helm
    :config
    (require 'helm-config)
    :init
    (helm-mode 1)
    :bind
    (("M-x"     . helm-M-x) ;; Evaluate functions
     ("C-x C-f" . helm-find-files) ;; Open or create files
     ("C-x b"   . helm-mini) ;; Select buffers
     ("C-x C-r" . helm-recentf) ;; Select recently saved files
     ("C-c i"   . helm-imenu) ;; Select document heading
     ("M-y"     . helm-show-kill-ring) ;; Show the kill ring
     :map helm-map
     ("C-q" . helm-select-action)
     ("<tab>" . helm-execute-persistent-action)))

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle 0.5
 which-key-idle-delay 50)
  (which-key-setup-minibuffer))

;; Auto completion
(use-package company
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 4
        company-selection-wrap-around t))
(global-company-mode)

;; Org-Mode initial setup
(use-package org
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)))

;; Improve org mode looks
(setq org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t)

;; Show hidden emphasis markers
(use-package org-appear
  :hook (org-mode . org-appear-mode))

;; Nice bullets
(use-package org-superstar
    :config
    (setq org-superstar-special-todo-items t)
    (add-hook 'org-mode-hook (lambda ()
                               (org-superstar-mode 1))))

;; Capture 
(global-set-key "\C-c c" 'org-capture)
(setq org-capture-templates
        '(("d" "Distraction" entry (file+headline "~/documents/notes/distractions.org" "Notes")
         "* %?\n%T")
	  ("t" "TODO" entry (file+headline "~/documents/todo.org" "Captured Tasks")
         "* TODO %?\n %i\n %a")))

;; Agenda files. Change to your chosen file(s)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/documents/todo.org"))
(setq org-agenda-include-diary t)
(setq calendar-latitude 59.6)
(setq calendar-longitude 10.7)
(setq calendar-location-name "Vestby, NO")

;; Spell checking
;; Requires Hunspell
(use-package flyspell
  :config
  (setq ispell-program-name "hunspell"
        ispell-default-dictionary "en_GB"
	ispell-dictionary-alist: "en_GB,nb_NO")
  :hook (text-mode . flyspell-mode)
  :bind (("M-<f7>" . flyspell-buffer)
         ("<f7>" . flyspell-word)
         ("C-;" . flyspell-auto-correct-previous-word)))

;; Distraction-free screen
(use-package olivetti
  :init
  (setq olivetti-body-width .67)
  :config
  (defun distraction-free ()
    "Distraction-free writing environment"
    (interactive)
    (if (equal olivetti-mode nil)
        (progn
          (window-configuration-to-register 1)
          (delete-other-windows)
          (text-scale-increase 2)
          (olivetti-mode t))
      (progn
        (jump-to-register 1)
        (olivetti-mode 0)
        (text-scale-decrease 2))))
  :bind
  (("<f9>" . distraction-free)))

;; Org-Roam basic configuration
(setq org-directory "~/documents/notes/")
 (use-package org-roam
  :after org
  :init (setq org-roam-v2-ack t) ;; Acknowledge V2 upgrade
  :custom
  (org-roam-directory (file-truename org-directory))
  :config
  (org-roam-setup)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n r" . org-roam-node-random)		    
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)
                ("C-c n o" . org-id-get-create)
                ("C-c n t" . org-roam-tag-add)
                ("C-c n a" . org-roam-alias-add)
              ("C-c n l" . org-roam-buffer-toggle)))))


;; Search notes with deft
(use-package deft
  :config
  (setq deft-directory org-directory
        deft-recursive t
        deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n"
        deft-use-filename-as-title t)
  :bind
  ("C-c n d" . deft))

;; mu4e
;;(add-to-list 'load-path "/home/lars/mu/mu-0.9.9.5/mu4e/")
;;(require 'mu4e)

;;(require 'smtpmail)
;;(require 'auth-source-xoauth2)

;;(setq mail-user-agent 'mu4e-user-agent)
;;(setq mu4e-sent-messages-behavior 'delete)
;;(setq mu4e-maildir "/home/lars/Mails/gmail")
;;(setq
;;  mu4e-sent-folder   "/[Gmail].Sent Mail"       ;; folder for sent messages
;;  mu4e-drafts-folder "/[Gmail].Drafts"     ;; unfinished messages
;;  mu4e-trash-folder  "/[Gmail].Trash")      ;; trashed messages
;;(setq mu4e-update-interval 120)
;;
;;(setq message-send-mail-function 'smtpmail-send-it)
;;(setq mu4e-get-mail-command "offlineimap")
;;(setq mu4e-headers-date-format "%d-%m-%Y %H:%M")
;;(setq mu4e-headers-fields '((:human-date . 20)
;;			    (:flags . 6)
;;			    (:from . 22)
;;			    (:maildir . 8)
;;			    (:subject)))
;;(defun my-xoauth2-get-secrets (host user port)
;;  (when (and (string= host "smtp.gmail.com")
;;             (string= user "lars.johansen@nordhealth.com"))
;;    (list
;;     :token-url "https://accounts.google.com/o/oauth2/token"
;;     :client-id     (auth-source-pass-get 'secret "gmail_oauth2_client_id")
;;     :client-secret (auth-source-pass-get 'secret "gmail_oauth2_client_secret")
;;     :refresh-token (auth-source-pass-get 'secret "gmail_oauth2_refresh_token"))))
;;(setq auth-source-xoauth2-creds 'my-xoauth2-get-secrets)
;;(add-to-list 'smtpmail-auth-supported 'xoauth2)
;;(auth-source-xoauth2-enable)
;;(setq auth-sources (quote (xoauth2 password-store)))

