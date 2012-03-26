;;
;; ruby-mode
;;______________________________________________________________________

;; ruby-mode のインデント設定
(setq ;; ruby-indent-level 3      ; インデント幅を 3 に. 初期値は 2
 ruby-deep-indent-paren-style t ; 改行時のインデントを調整する
 ;; ruby-mode 実行時に indent-tabs-mode を設定値に変更
 ;; ruby-indent-tabs-mode t       ; タブ文字を使用する. 初期値は nil
 )

;; 括弧の自動挿入── ruby-electric
;; (install-elisp "https://raw.github.com/ruby/ruby/trunk/misc/ruby-electric.el")
(require 'ruby-electric nil t)

;; end に対応する行のハイライト── ruby-block
;; M-x auto-install-from-emacswiki RET ruby-block.el
(when (require 'ruby-block nil t)
  (setq ruby-block-highlight-toggle t))

;; インタラクティブ Ruby を利用する── inf-ruby
;; (install-elisp "https://raw.github.com/ruby/ruby/trunk/misc/inf-ruby.el")
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

;; ruby-mode-hook 用の関数を定義
(defun ruby-mode-hooks ()
  (inf-ruby-keys)
  (ruby-electric-mode t)
  (ruby-block-mode t))

;; ruby-mode-hook に追加
(add-hook 'ruby-mode-hook 'ruby-mode-hooks)
