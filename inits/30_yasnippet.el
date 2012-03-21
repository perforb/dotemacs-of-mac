;;
;; yasnippet
;; 1)http://code.google.com/p/yasnippet/ から yasnippet-0.6.1c.tar.bz2 をダウンロード
;; 2)展開後、yasnippet.0.6.1c ディレクトリを ~/.emacs.d/plugins 以下に移動する
;; ref http://yasnippet.googlecode.com/svn/trunk/doc/index.html
;; ref http://d.hatena.ne.jp/botchy/20080502/1209717204
;; ref http://yasnippet-doc-jp.googlecode.com/svn/trunk/doc-jp/index.html
;; ref http://sakito.jp/emacs/emacsobjectivec.html
;;______________________________________________________________________

(require 'yasnippet) ;; not yasnippet-bundle

;; スニペット展開を <TAB> から <SPC>  に変更
;; (setq yas/trigger-key "SPC")

;; メニューは使わない
(setq yas/use-menu nil)

(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt))

;; 初期化
(yas/initialize)

;; スニペットの位置を複数設定します。同名の snippets はより後ろに設定した方で上書きされます。
;; (setq yas/root-directory '("~/.emacs.d/elisp/yasnippet-0.6.1c/snippets"
;;                           "~/.emacs.d/conf/snippets"))
(setq yas/root-directory '("~/.emacs.d/elisp/yasnippet/snippets"))

;; yas/load-directory も複数ディレクトリに対応した修正をします
(mapc 'yas/load-directory yas/root-directory)

;; snippet 一覧をポップアップ
(global-set-key (kbd "C-c s") 'yas/insert-snippet)


