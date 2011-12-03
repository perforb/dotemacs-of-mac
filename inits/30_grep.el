;;
;; grep
;;______________________________________________________________________

;; igrep
;; 1)M-x auto-install-from-emacswiki igrep.el
;; [Usage]
;; 1)M-x igrep-find
;; 2)検索文字列を入力
;; 3)検索ファイルを入力 (ex)/opt/local/apache2/htdocs/fw/*.php
;; [Memo]
;; xargs の -e オプションでエラーになるので xargs をオフに変更
(require 'igrep)
(igrep-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -Ou8"))
(igrep-find-define lgrep (igrep-use-zgrep nil)(igrep-regex-option "-n -Ou8"))
(setq igrep-find-use-xargs nil)

;; grep-edit
;; 1)M-x auto-install-from-emacswiki grep-edit.el
;; [Patch]
;; ref http://d.hatena.ne.jp/tomoya/20090826/1251261798
;; [Summary]
;; grep の検索結果を直接編集することで複数ファイルの一括置換が可能となる
;; [Usage]
;; C-c C-e 変更を反映する
;; C-c C-r リージョンの変更点を破棄する
;; C-c C-u 全変更点を破棄する
;; C-x s   変更されたファイルを保存
(require 'grep-edit)
