;;
;; display
;;______________________________________________________________________

;; font and frame setting
(if window-system
    (progn
      (set-frame-parameter nil 'alpha 88)  ; 透明度
      (setq inhibit-startup-message t)     ; 起動時のメッセージを非表示
      (setq inhibit-startup-screen t)      ; スタートアップメッセージを非表示
      (menu-bar-mode 0)                    ; menu-bar を非表示
      (tool-bar-mode nil)                  ; ツールバー非表示
      (setq initial-frame-alist
            '((width . 198)
              (height . 58)
              (top . 0)
              (left . 2)))                 ; 起動時のフレームの設定
      (set-scroll-bar-mode nil)            ; スクロールバー非表示
      (setq line-spacing 0.2)              ; 行間
      (when (>= emacs-major-version 23)
        (tool-bar-mode nil)
        (set-frame-font "Menlo-11")
        (set-fontset-font (frame-parameter nil 'font)
                          'japanese-jisx0208
                          (font-spec :family "Hiragino Maru Gothic ProN" :size 12))
        (set-fontset-font (frame-parameter nil 'font)
                          'japanese-jisx0212
                          (font-spec :family "Hiragino Maru Gothic ProN" :size 12))
        (set-fontset-font (frame-parameter nil 'font)
                          'katakana-jisx0201
                          (font-spec :family "Hiragino Maru Gothic ProN" :size 12)))
      (setq ns-pop-up-frames nil)))


;;
;; tabbar
;; (install-elisp "http://www.emacswiki.org/emacs/download/tabbar.el")
;; ref http://d.hatena.ne.jp/tequilasunset/20110103/p1
;; ref http://idita.blog11.fc2.com/blog-entry-810.html
;; ______________________________________________________________________

(require 'tabbar)
(tabbar-mode 1)

;; タブ上でマウスホイール操作無効
(tabbar-mwheel-mode -1)

;; グループ化しない
(setq tabbar-buffer-groups-function nil)

;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;; タブの長さ
(setq tabbar-separator '(1.5))

;; 外観変更
(set-face-attribute
 'tabbar-default nil
 :family "Comic Sans MS"
 :background "black"
 :foreground "gray72"
 :height 1.0)
(set-face-attribute
 'tabbar-unselected nil
 :background "black"
 :foreground "grey72"
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background "black"
 :foreground "yellow"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box nil)
(set-face-attribute
 'tabbar-separator nil
 :height 1.5)

;; タブに表示させるバッファの設定
(defvar my-tabbar-displayed-buffers
  '("*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-")
  "*Regexps matches buffer names always included tabs.")

(defun my-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
  (let* ((hides (list ?\  ?\*))
         (re (regexp-opt my-tabbar-displayed-buffers))
         (cur-buf (current-buffer))
         (tabs (delq nil
                     (mapcar (lambda (buf)
                               (let ((name (buffer-name buf)))
                                 (when (or (string-match re name)
                                           (not (memq (aref name 0) hides)))
                                   buf)))
                             (buffer-list)))))
    ;; Always include the current buffer.
    (if (memq cur-buf tabs)
        tabs
      (cons cur-buf tabs))))

(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;; タブ切り替え
(global-set-key [C-tab] 'tabbar-forward-tab)
(global-set-key [C-S-tab] 'tabbar-backward-tab)

;; タブ上をマウス中クリックで kill-buffer
(defun my-tabbar-buffer-help-on-tab (tab)
  "Return the help string shown when mouse is onto TAB."
  (if tabbar--buffer-show-groups
      (let* ((tabset (tabbar-tab-tabset tab))
             (tab (tabbar-selected-tab tabset)))
        (format "mouse-1: switch to buffer %S in group [%s]"
                (buffer-name (tabbar-tab-value tab)) tabset))
    (format "\
mouse-1: switch to buffer %S\n\
mouse-2: kill this buffer\n\
mouse-3: delete other windows"
            (buffer-name (tabbar-tab-value tab)))))

(defun my-tabbar-buffer-select-tab (event tab)
  "On mouse EVENT, select TAB."
  (let ((mouse-button (event-basic-type event))
        (buffer (tabbar-tab-value tab)))
    (cond
     ((eq mouse-button 'mouse-2)
      (with-current-buffer buffer
        (kill-buffer)))
     ((eq mouse-button 'mouse-3)
      (delete-other-windows))
     (t
      (switch-to-buffer buffer)))
    ;; Don't show groups.
    (tabbar-buffer-show-groups nil)))

(setq tabbar-help-on-tab-function 'my-tabbar-buffer-help-on-tab)
(setq tabbar-select-tab-function 'my-tabbar-buffer-select-tab)


;;
;; popup
;; ref http://d.hatena.ne.jp/m2ym/20110120/1295524932
;; ref http://d.hatena.ne.jp/sokutou-metsu/20110205/1296915272
;; ref http://d.hatena.ne.jp/hirose31/20110302/1299062869
;;______________________________________________________________________

(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-width 0.4)
(push '(" *auto-async-byte-compile*" :position right :noselect t) popwin:special-display-config)
(push '(dired-mode :position right) popwin:special-display-config)


;;
;; カラーテーマ(http://www.nongnu.org/color-theme/)
;; テーマサンプル(http://code.google.com/p/gnuemacscolorthemetest/)
;;______________________________________________________________________

;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;;      (color-theme-arjen)))


;;
;; Color
;;______________________________________________________________________

(set-foreground-color                                  "#ffffff") ; 文字色
(set-background-color                                  "#000000") ; 背景色
(set-cursor-color                                      "#ffffff") ; カーソル色
(set-face-background 'region                           "#0000CD") ; リージョン
(set-face-foreground 'modeline                         "#ffffff") ; モードライン文字
(set-face-background 'modeline                         "#00008B") ; モードライン背景
(set-face-foreground 'mode-line-inactive               "#000000") ; モードライン文字(非アクティブ)
(set-face-background 'mode-line-inactive               "#ffffff") ; モードライン背景(非アクティブ)
(set-face-foreground 'font-lock-comment-delimiter-face "#888888") ; コメントデリミタ
(set-face-foreground 'font-lock-comment-face           "#888888") ; コメント
(set-face-foreground 'font-lock-string-face            "#ff4500") ; 文字列
(set-face-foreground 'font-lock-function-name-face     "#ffffff") ; 関数名
(set-face-foreground 'font-lock-keyword-face           "#FF7F7F") ; キーワード
(set-face-foreground 'font-lock-constant-face          "#FF7F7F") ; 定数(this, selfなども)
(set-face-foreground 'font-lock-variable-name-face     "#6495ED") ; 変数
(set-face-foreground 'font-lock-type-face              "#20b2aa") ; クラス
(set-face-foreground 'fringe                           "#666666") ; fringe(折り返し記号なでが出る部分)
(set-face-background 'fringe                           "#282828") ; fringe

;; 現在行をハイライト
(global-hl-line-mode t)
(set-face-background 'hl-line "#222244")


;;
;; etc
;;______________________________________________________________________

;; paren-mode 対応する括弧を強調表示
(setq show-paren-delay 0)
(setq show-paren-style 'mixed)
(show-paren-mode t)
(set-face-background 'show-paren-match-face "#008080")
(set-face-foreground 'show-paren-mismatch-face "red")

;; 行番号表示
;; (global-linum-mode)
;; (setq linum-format "%4d")

;; 全角スペース、タブの強調表示
(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
(defface my-face-b-2 '((t (:background "medium aquamarine"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ ]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks
          '(lambda ()
             (if font-lock-mode nil
               (font-lock-mode t))) t)

;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; カーソル位置のフェースを調べる関数
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))
