;;
;; This definition is to use the emacsclient.
;;
;; Usage
;; 1)emacsclient <file_name> で編集したいファイルを開く
;; 2)編集完了後は C-x # で終了を通知する
;;
;; ref http://d.hatena.ne.jp/syohex/20101224/1293206906
;; ref http://www.kanasansoft.com/weblab/2010/03/git_core_editor_emacs_mac.html
;; ref http://www.bookshelf.jp/texi/emacs-man/21-3/jp/faq_5.html
;; _____________________________________________________________________

(require 'server)
(unless (server-running-p)
  (server-start))


;;
;; PATH
;; ref http://sakito.jp/emacs/emacsshell.html#path
;; ref http://d.hatena.ne.jp/peccu/20101116/emacs_evernote
;; _____________________________________________________________________

; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/sw/bin"
              "/usr/local/bin"
              "/usr/local/share/python"
              (expand-file-name "~/.emacs.d/lib/ruby/site_ruby")
              ))

;; PATH と exec-path に同じ物を追加します
(when ;; (and
       (file-exists-p dir) ;; (not (member dir exec-path)))
  (setenv "PATH" (concat dir ":" (getenv "PATH")))
  (setq exec-path (append (list dir) exec-path))))

(setenv "GEM_HOME" "/usr/bin/gem")
(setenv "RUBYLIB" "~/.emacs.d/lib/ruby/site_ruby/")


;;
;; CommandキーをMetaに、OptionをSUPERキー（Winキー）に入れ替え
;;______________________________________________________________________

(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))


;;
;; backup file
;;______________________________________________________________________

; #* というバックアップファイルを作らない
(setq auto-save-default nil)

;; *.~ というバックアップファイルを作らない
(setq make-backup-files nil)


;;
;; etc
;;______________________________________________________________________

;; sticky
;; (require 'sticky)
;; セミコロンを押下時に shift キーを押した状態になる
;; 英大文字や $ 記号などの入力に便利
;; (use-sticky-key ";" sticky-alist:ja)

;; 現在位置のファイル・URLを開く
(ffap-bindings)

;; ベルを鳴らさない
(setq ring-bell-function 'ignore)

;; redo
;; 1)M-x install-elisp-from-emacswiki redo+.el
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; 略語展開・補完を行うコマンドをまとめる
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially   ;ファイル名の一部
        try-complete-file-name             ;ファイル名全体
        try-expand-all-abbrevs             ;静的略語展開
        try-expand-dabbrev                 ;動的略語展開(カレントバッファ)
        try-expand-dabbrev-all-buffers     ;動的略語展開(全バッファ)
        try-expand-dabbrev-from-kill       ;動的略語展開(キルリング:M-w/C-w の履歴)
        try-complete-lisp-symbol-partially ;Lisp シンボル名の一部
        try-complete-lisp-symbol           ;Lisp シンボル名全体
        ))

;; Indent
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(c-set-offset 'case-label '+)

;; C-k で改行を含め削除
(setq kill-whole-line t)

;; カーソル位置から行頭まで削除する
(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0))
(global-set-key (kbd "C-S-k") 'backward-kill-line)

;; ファイルを自動保存する
;; M-x auto-install-from-url http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el
(require 'auto-save-buffers)
(run-with-idle-timer 1 t 'auto-save-buffers) ; アイドル1秒で保存

;; タイトルバーに編集中のファイルのパス名を表示
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))

;; 折り返さない(t で折り返さない, nil で折り返す)
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; バッファ切り替えの強化
(iswitchb-mode 1)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-regexp nil)
(setq iswitchb-prompt-newbuffer nil)

;; 最近使ったファイルを開く
;; M-x auto-install-from-emacswiki recentf-ext.el
;; ref: http://d.hatena.ne.jp/tomoya/20110217/1297928222
(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))

;; recentf の強化版
(require 'recentf-ext)

;; save-buffer 時、buffer 末尾に空行が常にあるように
(setq require-final-newline t)


;;
;; auto-async-byte-compile
;; Warning: elisp ファイル上にエラーがある場合はバイトコンパイルされないので注意
;;______________________________________________________________________

(require 'auto-async-byte-compile)
;; 自動バイトコンパイルを無効にするファイルの正規表現
(setq auto-async-byte-compile-exclude-files-regexp "/junk/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
