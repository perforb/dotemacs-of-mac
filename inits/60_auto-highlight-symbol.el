;;
;; auto-highlight-symbol
;; ref http://hiroki.jp/2011/01/25/1561/#more-1561
;; ref https://github.com/mitsuo-saito/auto-highlight-symbol-mode
;; (auto-install-from-url "https://raw.github.com/mitsuo-saito/auto-highlight-symbol-mode/master/auto-highlight-symbol-config.el")
;; (auto-install-from-url "https://raw.github.com/mitsuo-saito/auto-highlight-symbol-mode/master/auto-highlight-symbol.el")
;; [Usage]
;; 変数の上のカーソルをおいて、C-x C-a とすると、現在ハイライトされている変数の名前を全部一括して変更できる。
;; しかし、表示されていない部分は変更されないので注意する必要がある。
;;______________________________________________________________________

(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
