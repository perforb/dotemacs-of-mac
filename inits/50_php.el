;;
;; php-mode
;;______________________________________________________________________

;; php-mode の設定
(when (require 'php-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.ctp\\'" . php-mode))
  (add-to-list 'auto-mode-alist '("\\.twig\\'" . php-mode))
  (setq php-search-url "http://jp.php.net/ja/")
  (setq php-manual-url "http://jp.php.net/manual/ja/"))

;; php-mode のインデント設定
(defun php-indent-hook ()
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
  ;; (c-set-offset 'case-label '+) ; switch 文の case ラベル
  (c-set-offset 'arglist-intro '+) ; 配列の最初の要素が改行した場合
  (c-set-offset 'arglist-close 0)) ; 配列の閉じ括弧

(add-hook 'php-mode-hook 'php-indent-hook)

;; php-mode の補完を強化する
(defun php-completion-hook ()
  (when (require 'php-completion nil t)
    (php-completion-mode t)
    ;; anything による補完
    (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)

    (when (require 'auto-complete nil t)
      (make-variable-buffer-local 'ac-sources)
      (add-to-list 'ac-sources 'ac-source-php-completion)
      (auto-complete-mode t))))

(add-hook 'php-mode-hook 'php-completion-hook)


;;
;; CakePHP
;;______________________________________________________________________

;; (install-elisp "https://raw.github.com/k1LoW/emacs-historyf/master/historyf.el")
;; (install-elisp "https://raw.github.com/k1LoW/emacs-cake/master/cake-inflector.el")
;; (install-elisp "https://raw.github.com/k1LoW/emacs-cake/master/cake.el")
;; (install-elisp "https://raw.github.com/k1LoW/emacs-cake/master/ac-cake.el")
;; (install-elisp "https://raw.github.com/k1LoW/emacs-cake2/master/cake2.el")
;; (install-elisp "https://raw.github.com/k1LoW/emacs-cake2/master/ac-cake2.el")

;; CakePHP 1 系統の emacs-cake
(when (require 'cake nil t)
  ;; emacs-cake の標準キーバインドを利用する
  (cake-set-default-keymap)
  ;; 標準で emacs-cake をオフ
  (global-cake -1))

;; CakePHP 2 系統の emacs-cake
(when (require 'cake2 nil t)
  ;; emacs-cake2 の標準キーバインドを利用する
  (cake2-set-default-keymap)
  ;; 標準で emacs-cake2 をオン
  (global-cake2 t))

;; emacs-cake を切り替えるコマンドを定義
(defun toggle-emacs-cake ()
  "emacs-cake と emacs-cake2 を切り替える"
  (interactive)
  (cond ((eq cake2 t) ; cake2 がオンであれば
         (cake2 -1) ; cake2 をオフにして
         (cake t)) ; cake をオンにする
        ((eq cake t) ; cake がオンであれば
         (cake -1) ; cake をオフにして
         (cake2 t)) ; cake2 をオンにする
        (t nil))) ; どちらもオフであれば何もしない

;; C-c t に toggle-emacs-cake を割り当て
(define-key cake-key-map (kbd "C-c t") 'toggle-emacs-cake)
(define-key cake2-key-map (kbd "C-c t") 'toggle-emacs-cake)

;; auto-complete, ac-cake, ac-cake2 の読み込みをチェック
(when (and (require 'auto-complete nil t)
           (require 'ac-cake nil t)
           (require 'ac-cake2 nil t))
  ;; ac-cake 用の関数定義
  (defun ac-cake-hook ()
    (make-variable-buffer-local 'ac-sources)
    (add-to-list 'ac-sources 'ac-source-cake)
    (add-to-list 'ac-sources 'ac-source-cake2))
  ;; php-mode-hook に ac-cake 用の関数を追加
  (add-hook 'php-mode-hook 'ac-cake-hook))
