;; ************************************************************
;;
;; GENERAL EMACS SETTINGS
;;
;; ************************************************************


;; =========================
;; Set default window size
;; =========================

(setq initial-frame-alist
      '((width . 180)     ; Width (in symbols)
        (height . 60)     ; Height (in strings)
        (left . 300)      ; Left corner position (in pixels)
        (top . 300)))     ; Top corner position (in pixels)

(setq default-frame-alist
      '((width . 180)     ; Width (in symbols)
        (height . 60)     ; Height (in strings)
        (left . 300)      ; Left corner position (in pixels)
        (top . 300)))     ; Top corner position (in pixels)


;; ====================================
;; Make Emacs window up when starting
;; ====================================

(add-hook 'window-setup-hook
          (lambda ()
            (raise-frame)
            (select-frame-set-input-focus (selected-frame))))

;; For creating new frames
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (raise-frame)
              (select-frame-set-input-focus frame))))


;; ======================
;; Disable start screen
;; ======================

(setq inhibit-startup-screen t)

;; Отключить сообщение в эхо-области
(setq inhibit-startup-echo-area-message "vsndrg")  ;; замените your-username на ваше имя пользователя

;; Очистить начальное сообщение в scratch-буфере
(setq initial-scratch-message nil)

;; Отключить прочие стартовые сообщения
(setq initial-buffer-choice nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (when (get-buffer "*GNU Emacs*")
              (kill-buffer "*GNU Emacs*"))))




;; ************************************************************
;;
;; EMACS EDITOR SETTINGS
;;
;; ************************************************************


;; ===========================
;; Set delete selection mode
;; ===========================

(delete-selection-mode 1) ;; Deletes selected text when you start typing

;; ==================
;; Set custom theme
;; ==================

(load-theme 'vscode-dark-plus t)

;; =====================
;; Disable sound alert
;; =====================

(setq ring-bell-function #'ignore)


;; =================
;; Set cursor mode
;; =================

(setq-default cursor-type 'bar)


;; =========
;; Hotkeys
;; =========

;; -------------------------------------------------------------------
;; 1) Функции: если есть выделение – копируем/вырезаем его,
;;    иначе — всю текущую строку.
;; -------------------------------------------------------------------
(defun my-copy-or-line ()
  "Копирует активную область или, если нет выделения, – текущую строку."
  (interactive)
  (if (use-region-p)
      (kill-ring-save (region-beginning) (region-end))
    (kill-ring-save (line-beginning-position)
                    (line-beginning-position 2))
    (message "Line copied")))

(defun my-cut-or-line ()
  "Вырезает активную область или, если нет выделения, – текущую строку."
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (kill-region (line-beginning-position)
                 (line-beginning-position 2))
    (message "Line cut")))

;; -------------------------------------------------------------------
;; 2) Привязки клавиш
;; -------------------------------------------------------------------
;; Сохранять файл: Ctrl+S
(global-set-key (kbd "C-s") #'save-buffer)

;; Копировать: Ctrl+C
(global-set-key (kbd "C-c") #'my-copy-or-line)

;; Вставить: Ctrl+V
(global-set-key (kbd "C-v") #'yank)

;; Вырезать: Ctrl+X (если хочется аналогично)
(global-set-key (kbd "C-x") #'my-cut-or-line)

;; Ctrl+Ins = копировать
(global-set-key (kbd "<C-insert>") #'my-copy-or-line)

;; Shift+Ins = вставить
(global-set-key (kbd "<S-insert>") #'yank)

;; Shift+Del = вырезать
(global-set-key (kbd "<S-delete>") #'my-cut-or-line)

;; Optionally: Ctrl+Del и Ctrl+Backspace для удаления слов вправо/влево
(global-set-key (kbd "<C-delete>") #'kill-word)
(global-set-key (kbd "<C-backspace>") #'backward-kill-word)

;; New undo/redo bindings
(global-set-key (kbd "C-z") 'undo) ;; Ctrl+Z = Undo
(global-set-key (kbd "C-S-z") 'undo-redo) ;; Ctrl+Shift+Z = Redo

;; Select whole buffer
(global-set-key (kbd "C-a") 'mark-whole-buffer)

;; -------------------------------------------------------------------
;; 3) Отключаем конфликтующие префиксы (если нужно)
;; -------------------------------------------------------------------
;; Emacs по умолчанию использует C-c и C-x как префиксные ключи
;; (для пользовательских и встроенных команд); если вы не планируете
;; их использовать в «старом» режиме, можно снять префикс:
;;(define-prefix-command nil 'ctl-x-map)
;;(define-key global-map (kbd "C-x") nil)

;; Но не обязательно — в большинстве случаев новая привязка
;; просто перекроет старую.


;; ==================
;; Smooth scrolling
;; ==================

(setq scroll-step 1)              ; Прокрутка по 1 строке
(setq scroll-conservatively 100)  ; Не прыгать при приближении к краю
(setq auto-window-vscroll nil)    ; Отключить автоматическую вертикальную прокрутку
(setq scroll-margin 3)            ; Отступ (марджин) в 5 строк от краев окна


;; ===============
;; Set scrolling
;; ===============

;; Scroll buffer up by one line, point stays on same screen line
(defun scroll-up-one-line ()
  "Scroll buffer upward by one line, keeping point position."
  (interactive)
  (scroll-up-command 1))

;; Scroll buffer down by one line, point stays on same screen line
(defun scroll-down-one-line ()
  "Scroll buffer downward by one line, keeping point position."
  (interactive)
  (scroll-down-command 1))

;; Bind to C-↓ / C-↑
(global-set-key (kbd "C-<down>") 'scroll-up-one-line)
(global-set-key (kbd "C-<up>")   'scroll-down-one-line)


;; =====================
;; Set font (Consolas)
;; =====================

(set-frame-font "Consolas 12" nil t)

;; =====================
;; Enable line numbers
;; =====================

;; Emacs 26+ built-in
;;(global-display-line-numbers-mode 1)


;;========================
;; Highlight cursor line
;;========================

(global-hl-line-mode 1)  ;; turn on hl-line-mode globally

;; After hl-line is loaded, adjust its face for a dark background
;;(with-eval-after-load 'hl-line
;;  (set-face-attribute 'hl-line nil
;;                      :background "#454745"  ;; dark-grey highlight
;;                      :foreground nil        ;; keep text color unchanged
;;                      :inherit nil))


;; ================================================
;; Highlight current line number in the margin
;; ================================================

;; Make sure line numbers are on
(global-display-line-numbers-mode 1)

;; Включить выделение текущей строки
(global-hl-line-mode 1)


;;(with-eval-after-load 'display-line-numbers
;;  ;; Use the same bg as hl-line for the current line number
;;  (set-face-attribute 'line-number-current-line nil
;;                      :background "#2f3436"   ;; match your hl-line bg
;;                      :foreground nil         ;; keep text color
;;                      :inherit 'hl-line))     ;; inherit any other hl-line settings


;; ===============================
;; Customize the selection color
;; ===============================

;; Set custom region (highlighted) color
;;(set-face-attribute 'region nil
;;                    :background "#3e5675"  ;; Background color for selection
;;                    :foreground nil) ;; Foreground color for selection text




;; ************************************************************
;;
;; PACKAGES SETUP
;;
;; ************************************************************


;; ====================
;; Coq packages setup
;; ====================

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)




;; ************************************************************
;;
;; COQ MODE SETTINGS
;;
;; ************************************************************


;; ==========================
;; Custom shortcuts for Coq
;; ==========================

(add-hook 'coq-mode-hook
  (lambda ()
    ;; unset the old binding, then set yours
    (local-unset-key (kbd "M-<down>"))
    (local-set-key   (kbd "M-<down>")  #'proof-assert-next-command-interactive)
    (local-set-key   (kbd "M-<up>")    #'proof-undo-last-successful-command)
    (local-set-key   (kbd "M-<right>") #'proof-goto-point)
    (local-set-key   (kbd "M-<left>")  #'proof-undo-and-retry)))


;; =========================================
;; Disable automatic Proof-General preview
;; =========================================

(with-eval-after-load 'proof-site
  (setq proof-splash-enable nil)        ;; Do not show Splash-screen when loading Proof-General
  (setq proof-auto-raise-buffers nil)   ;; Do not automatically up goal/response buffers
  (setq proof-three-window-enable nil)) ;; Disable three-window mode (leave script only)


;; =============
;; Column view
;; =============

(with-eval-after-load 'proof-site
  (setq proof-three-window-enable t)
  (setq proof-three-window-mode-policy 'hybrid)
  (add-hook 'coq-mode-hook #'proof-layout-windows))

;; ==================================
;; Highlight ordinary spaces in Coq
;; ==================================

(require 'whitespace)

;; Show spaces as centered dots
(setq whitespace-display-mappings
      '((space-mark ?\  [?\u00B7] [?.])))

;; Only highlight spaces (not tabs, newlines, etc.)
(setq whitespace-style '(face spaces space-mark))

;; Enable whitespace-mode in Coq buffers
(add-hook 'coq-mode-hook #'whitespace-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(vs-dark-theme vscode-dark-plus-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
