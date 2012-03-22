;;
;; auto-complete
;;
;; ______________________________________________________________________

(when (require 'auto-complete-config nil t)
  ;; (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

  ;; 辞書補完
  ;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/conf/ac-dict")

  ;; サンプル設定の有効化
  (ac-config-default)

  ;; 補完ウィンドウ内でのキー定義
  (define-key ac-completing-map (kbd "C-n") 'ac-next)
  (define-key ac-completing-map (kbd "C-p") 'ac-previous)
  (define-key ac-completing-map (kbd "M-/") 'ac-stop)

  ;; 補完が自動で起動するのを停止
  (setq ac-auto-start t)

  ;; 起動キーの設定
  (ac-set-trigger-key "TAB")

  ;; 候補の最大件数 デフォルトは 10件
  (setq ac-candidate-max 20)

  ;; 補完を開始する文字数
  (setq ac-auto-start 1)

  ;; 補完リストが表示されるまでの時間
  (setq ac-auto-show-menu 0.2)

  (defun auto-complete-init-sources ()
    (setq ac-sources '(ac-source-yasnippet
                       ac-source-dictionary
                       ac-source-gtags
                       ac-source-words-in-buffer)))

  (auto-complete-init-sources)

  (add-to-list 'ac-modes 'emacs-lisp-mode)
  (add-to-list 'ac-modes 'html-mode)
  (add-to-list 'ac-modes 'js2-mode)
  (add-to-list 'ac-modes 'tmt-mode)
  (add-to-list 'ac-modes 'yaml-mode)

  ;; company
  ;; (install-elisp "http://nschum.de/src/emacs/company-mode/company-0.5.tar.bz2")

  ;; ac-company
  ;; (install-elisp "https://raw.github.com/buzztaiki/auto-complete/master/ac-company.el")
  (require 'ac-company)

  ;; for emacs-lisp-mode
  (add-hook 'emacs-lisp-mode-hook
            '(lambda ()
               (auto-complete-init-sources)
               (add-to-list 'ac-sources 'ac-source-functions)
               (add-to-list 'ac-sources 'ac-source-symbols))))
