;;
;; yasnippet
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

;; スニペットの位置を複数設定します. 同名の snippets はより後ろに設定した方で上書きされます.
(setq yas/root-directory '("~/.emacs.d/info/yasnippet/snippets"))

;; yas/load-directory も複数ディレクトリに対応した修正をします
(mapc 'yas/load-directory yas/root-directory)

;; References
;; http://yasnippet.googlecode.com/svn/trunk/doc/index.html
;; http://d.hatena.ne.jp/botchy/20080502/1209717204
;; http://yasnippet-doc-jp.googlecode.com/svn/trunk/doc-jp/index.html
;; http://sakito.jp/emacs/emacsobjectivec.html
