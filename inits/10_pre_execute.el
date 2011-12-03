;; 起動前に実行する処理
(require 'cl)

;; ref http://d.hatena.ne.jp/kitokitoki/20100425/p1
(setq byte-compile-warnings '(free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local))
