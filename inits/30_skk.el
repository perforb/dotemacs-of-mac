;;
;; skk
;;______________________________________________________________________

(require 'info)
(add-to-list 'Info-additional-directory-list "~/.emacs.d/info")
(when (require 'skk-autoloads nil t)
  ;; C-x C-j で skk モードを起動
  (define-key global-map (kbd "C-x C-j") 'skk-mode)
  ;; .skk を自動的にバイトコンパイル
  (setq skk-byte-compile-init-file t))

;;チュートリアルの場所設定
(setq skk-tut-file "~/.emacs.d/share/skk/SKK.tut")
