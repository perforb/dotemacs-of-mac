;;
;; gtags
;;
;; [Usage]
;; 1)cd /path/to/pjhome
;; 2)gtags -v
;; 3)M-x gtags-mode (gtags-mode を設定していないモードの場合)
;;
;; ref http://www.bookshelf.jp/soft/meadow_42.html#SEC638
;; ref http://www.neutralworks.com/blog/emacs/emacsglobalgtags.html
;; ref http://uguisu.skr.jp/Windows/gtags.html
;;______________________________________________________________________

;; (autoload 'gtags-mode "gtags" "" t)
;; (setq gtags-mode-hook
;;       '(lambda ()
;;          (local-set-key "\M-t" 'gtags-find-tag)    ;; 関数の定義元へ移動
;;          (local-set-key "\M-r" 'gtags-find-rtag)   ;; 関数の参照元の一覧を表示
;;          (local-set-key "\M-s" 'gtags-find-symbol) ;; 変数の定義元と参照元の一覧を表示
;;          (local-set-key "\C-t" 'gtags-pop-stack)   ;; 前のバッファへ戻る
;;          ))

;; ;; 自動的に gtags-mode に切り替える
;; (add-hook 'c-mode-common-hook
;;           '(lambda ()
;;              (gtags-mode 1)
;;              (gtags-make-complete-list)
;;              ))
;; (add-hook 'php-mode-common-hook
;;           '(lambda ()
;;              (gtags-mode 1)
;;              (gtags-make-complete-list)
;;              ))
;; (add-hook 'java-mode-common-hook
;;           '(lambda ()
;;              (gtags-mode 1)
;;              (gtags-make-complete-list)
;;              ))
