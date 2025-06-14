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


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)


;; Установка company-mode, если не установлен
(unless (package-installed-p 'company)
  (package-refresh-contents)
  (package-install 'company))

;; Включение глобального company-mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)


;; ======================
;; Idris packages setup
;; ======================

;;(add-to-list 'load-path "~/.emacs.d/idris2-mode/")
;;(require 'idris2-mode)




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




;; ************************************************************
;;
;; IDRIS 2 MODE SETTINGS
;;
;; ************************************************************


;; 1. путь к вашему клону idris2-mode
;;(add-to-list 'load-path "~/.emacs.d/idris2-mode/")

;; 2. сам режим
;;(require 'idris2-mode)

;; 3. явно говорим: все файлы *.idr открывать в idris2-mode
;;(add-to-list 'auto-mode-alist '("\\.idr\\'" . idris2-mode))


;; ********************************************************
;;
;; C/C++ MODE SETTINGS
;;
;; ********************************************************


;; =================
;; Auto completion
;; =================

(global-set-key (kbd "C-SPC") 'company-complete)

;; Fast completion
(setq company-idle-delay 0.0)          ; Delay before show 
(setq company-minimum-prefix-length 1) ; Start auto complete from one symbol

;; Improvement for C/C++
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'company-mode)


;; =========================
;; Correct braces position
;; =========================

(defun my-c-mode-set-bsd-style ()
  "Включить BSD/Allman-стиль в cc-mode: '{' для substatements без смещения."
  (c-set-style "bsd")
  ;; установить c-basic-offset = 2 (или своё значение)
  (setq c-basic-offset 2)
  ;; убрать доп. отступ перед '{' для substatement-open
  (c-set-offset 'substatement-open 0))

(add-hook 'c-mode-common-hook #'my-c-mode-set-bsd-style)


;; =======================
;; Auto close '{' braces
;; =======================

(defun my-c-mode-enable-electric ()
  "Включить electric-pair-mode и авто-новые линии в C/C++."
  ;; вставлять сразу пару «{}»
  (electric-pair-local-mode 1)
  ;; вставлять перенос строки после {, } и ;
  (c-toggle-auto-newline 1))

(add-hook 'c-mode-common-hook #'my-c-mode-enable-electric)


;; Отключение автодополнения внутри строк и комментариев
(defun my-company-in-code-context ()
  "Проверяет, находится ли курсор в коде (не в строке и не в комментарии)."
  (not (or (nth 3 (syntax-ppss))   ; Внутри строки?
           (nth 4 (syntax-ppss))))) ; Внутри комментария?

;; Добавляем проверку контекста для company-mode
(with-eval-after-load 'company
  (add-to-list 'company-transformers 'my-company-ignore-strings))

(defun my-company-ignore-strings (candidates)
  "Фильтрует кандидатов, если курсор находится внутри строки."
  (if (my-company-in-code-context)
      candidates
    (unless (eq this-command 'company-complete)
      (company-cancel))
    nil))

