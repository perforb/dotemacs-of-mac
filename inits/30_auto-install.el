;;
;; auto-install
;;______________________________________________________________________

(require 'auto-install)
;; インストール先
(setq auto-install-directory "~/.emacs.d/elisp/")

;; 起動時に EmacsWiki のページ名を補完候補に加える
(auto-install-update-emacswiki-package-name t)

;; install.elisp.el 互換モードにする
(auto-install-compatibility-setup)

;; ediff 関連のバッファを１つのフレームにまとめる
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
