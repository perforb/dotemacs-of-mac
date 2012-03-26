;;
;; ctags
;;______________________________________________________________________

(require 'ctags nil t)
(setq tags-revert-without-query t)
;; ctags を呼び出すコマンドライン. パスが通っていればフルパスでなくてもよい
;; etags 互換タグを利用する場合はコメントを外す
;; (setq ctags-command "ctags -e -R ")
;; anything-exuberant-ctags.el を利用しない場合はコメントアウトする
(setq ctags-command "ctags -R --fields=\"+afikKlmnsSzt\" ")
(global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)
