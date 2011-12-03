;;
;; flymake
;;______________________________________________________________________

;; キーバインド
(global-set-key "\M-p" 'flymake-goto-prev-error)
(global-set-key "\M-n" 'flymake-goto-next-error)
(global-set-key "\C-cd" 'flymake-popup-err-message)


(require 'flymake)

;; GUIの警告は表示しない
(setq flymake-gui-warnings-enabled nil)

;; 全てのファイルで flymakeを有効化
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; エラーメッセージをポップアップ表示
(defun flymake-popup-err-message ()
  "Display a menu with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (let* ((line-no            (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (menu-data          (flymake-make-err-menu-data line-no line-err-info-list)))
    (if menu-data
      (popup-tip (mapconcat '(lambda (e) (nth 0 e))
                            (nth 1 menu-data)
                            "\n")))
    ))

;; ;; カーソルをエラー行に載せるとエラーメッセージをポップアップ表示
;; ;; anythingと干渉するようなのでコメントアウト
;; (defadvice flymake-mode (before post-command-stuff activate compile)
;;   "エラー行にカーソルが当ったら自動的にエラーが minibuffer に表示されるように
;; post command hook に機能追加"
;;   (set (make-local-variable 'post-command-hook)
;;        (add-hook 'post-command-hook 'flymake-popup-err-message)))

;; エラー表示
;; INSTALL
;; (install-elisp "http://nschum.de/src/emacs/fringe-helper/fringe-helper.el")
(require 'fringe-helper)
(set-face-background 'flymake-errline nil)
(set-face-underline 'flymake-errline "#FF0000")
(defvar flymake-fringe-overlays nil)
(make-variable-buffer-local 'flymake-fringe-overlays)
(defadvice flymake-make-overlay (after add-to-fringe first
                                 (beg end tooltip-text face mouse-face)
                                 activate compile)
  (push (fringe-helper-insert-region
         beg end
         (fringe-lib-load (if (eq face 'flymake-errline)
                              fringe-lib-exclamation-mark
                            fringe-lib-question-mark))
         'left-fringe 'font-lock-warning-face)
        flymake-fringe-overlays))
(defadvice flymake-delete-own-overlays (after remove-from-fringe activate
                                        compile)
  (mapc 'fringe-helper-remove flymake-fringe-overlays)
  (setq flymake-fringe-overlays nil))

;; Objective-C 用設定
(defvar xcode:gccver "4.2.1")
(defvar xcode:sdkver "3.1.2")
(defvar xcode:sdkpath "/Developer/Platforms/iPhoneSimulator.platform/Developer")
(defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
(defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc-" xcode:gccver))
(defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" xcode:sdk))
(defvar flymake-last-position nil)
(defvar flymake-objc-compile-options '("-I."))
(defun flymake-objc-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                    'flymake-create-temp-inplace))
         (local-file (file-relative-name
                     temp-file
                     (file-name-directory buffer-file-name))))
     (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))

(add-hook 'objc-mode-hook
         (lambda ()
           ;; 拡張子 m と h に対して flymake を有効にする設定 flymake-mode t の前に書く必要があります
           (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
           (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)
           ;; 存在するファイルかつ書き込み可能ファイル時のみ flymake-mode を有効にします
           (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
               (flymake-mode t))))

;; coffee script用設定
;; http://d.hatena.ne.jp/antipop/20110508/1304838383
(setq flymake-coffeescript-err-line-patterns
      '(("\\(Error: In \\([^,]+\\), .+ on line \\([0-9]+\\).*\\)" 2 3 nil 1)))

(defconst flymake-allowed-coffeescript-file-name-masks
  '(("\\.coffee$" flymake-coffeescript-init)))

(defun flymake-coffeescript-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "coffee" (list local-file))))

(defun flymake-coffeescript-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks
        (append flymake-allowed-file-name-masks
                flymake-allowed-coffeescript-file-name-masks))
  (setq flymake-err-line-patterns flymake-coffeescript-err-line-patterns)
  (flymake-mode t))

(add-hook 'coffee-mode-hook 'flymake-coffeescript-load)

;; キーバインド
(global-set-key "\M-p" 'flymake-goto-prev-error)
(global-set-key "\M-n" 'flymake-goto-next-error)
(global-set-key "\C-cd" 'flymake-popup-err-message)




;; (require 'flymake)

;; ;; GUIの警告は表示しない
;; (setq flymake-gui-warnings-enabled nil)

;; ;; 全てのファイルで flymakeを有効化
;; (add-hook 'find-file-hook 'flymake-find-file-hook)

;; ;; エラーメッセージをポップアップ表示
;; (defun flymake-popup-err-message ()
;;   "Display a menu with errors/warnings for current line if it has errors and/or warnings."
;;   (interactive)
;;   (let* ((line-no            (flymake-current-line-no))
;;          (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (menu-data          (flymake-make-err-menu-data line-no line-err-info-list)))
;;     (if menu-data
;;         (popup-tip (mapconcat '(lambda (e) (nth 0 e))
;;                               (nth 1 menu-data)
;;                               "\n")))
;;     ))

;; objc
;; (defvar xcode:gccver "4.2.1")
;; (defvar xcode:sdkver "3.2.4")
;; (defvar xcode:sdkpath "/Developer/Platforms/iPhoneSimulator.platform/Developer")
;; (defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
;; (defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc-" xcode:gccver))
;; (defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" xcode:sdk))
;; (defvar flymake-last-position nil)
;; (defvar flymake-objc-compile-options '("-I."))
;; (defun flymake-objc-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))

;; (add-hook 'objc-mode-hook
;;           (lambda ()
;;             ;; 拡張子 m と h に対して flymake を有効にする設定 flymake-mode t の前に書く必要があります
;;             (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
;;             (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)
;;             ;; 存在するファイルかつ書き込み可能ファイル時のみ flymake-mode を有効にします
;;             (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
;;                 (flymake-mode t))
;;             ))

;; (defun flymake-display-err-minibuffer ()
;;   "現在行の error や warinig minibuffer に表示する"
;;   (interactive)
;;   (let* ((line-no (flymake-current-line-no))
;;          (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (count (length line-err-info-list)))
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
;;                (full-file (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;                (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                (line (flymake-ler-line (nth (1- count) line-err-info-list))))
;;           (message "[%s] %s" line text)))
;;       (setq count (1- count)))))

;; (defadvice flymake-goto-next-error (after display-message activate compile)
;;   "次のエラーへ進む"
;;   (flymake-display-err-minibuffer))

;; (defadvice flymake-goto-prev-error (after display-message activate compile)
;;   "前のエラーへ戻る"
;;   (flymake-display-err-minibuffer))

;; (defadvice flymake-mode (before post-command-stuff activate compile)
;;   "エラー行にカーソルが当ったら自動的にエラーが minibuffer に表示されるように
;; post command hook に機能追加"
;;   (set (make-local-variable 'post-command-hook)
;;        (add-hook 'post-command-hook 'flymake-display-err-minibuffer)))

;; 自動的な表示に不都合がある場合は以下を設定してください
;; post-command-hook は anything.el の動作に影響する場合があります
;;(define-key global-map (kbd "C-c d") 'flymake-display-err-minibuffer)

;; (set-face-background 'flymake-errline "red")
;; (set-face-background 'flymake-warnline "yellow")

;; ;; カーソルをエラー行に載せるとエラーメッセージをポップアップ表示
;; ;; anythingと干渉するようなのでコメントアウト 
;; (defadvice flymake-mode (before post-command-stuff activate compile)
;;   "エラー行にカーソルが当ったら自動的にエラーが minibuffer に表示されるように
;; post command hook に機能追加"
;;   (set (make-local-variable 'post-command-hook)
;;        (add-hook 'post-command-hook 'flymake-popup-err-message)))
