;;
;; auto-complete
;;
;; ref http://cx4a.org/software/auto-complete/index.ja.html
;;
;; (auto-install-batch "auto-complete development version")
;; (auto-install-from-emacswiki "auto-complete-etags.el")
;; (auto-install-from-emacswiki "etags-table.el")
;; ______________________________________________________________________

(require 'auto-complete-config)
(require 'auto-complete-etags)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

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

(ac-config-default)

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
(add-to-list 'ac-modes 'html-helper-mode)
(add-to-list 'ac-modes 'js2-mode)
(add-to-list 'ac-modes 'tmt-mode)
(add-to-list 'ac-modes 'yaml-mode)

;; company
;; (install-elisp "http://nschum.de/src/emacs/company-mode/company-0.5.tar.bz2")

;; ac-company
;; (install-elisp "https://raw.github.com/buzztaiki/auto-complete/master/ac-company.el")
(require 'ac-company)

;; for cperl-mode
;; (install-elisp "http://www.emacswiki.org/emacs/download/perl-completion.el")
;; ref http://d.hatena.ne.jp/IMAKADO/20081125/1227552844
;; ref http://bm11.kayac.com/2009/project/perlcomletionel/
;; doc http://www.emacswiki.org/emacs/PerlCompletion

;; (setq plcmp-use-keymap nil) ; nil に設定した場合デフォルトのキーバインド割当が行われない
(require 'perl-completion)
(add-hook 'cperl-mode-hook
          '(lambda ()
             (progn
               (auto-complete-init-sources)
               (add-to-list 'ac-sources 'ac-source-perl-completion)
               (perl-completion-mode t)
              )))

;; for emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (auto-complete-init-sources)
             (add-to-list 'ac-sources 'ac-source-functions)
             (add-to-list 'ac-sources 'ac-source-symbols)))

;; for yaml-mode
(add-hook 'yaml-mode-hook
          '(lambda ()
             (auto-complete-init-sources)
             (setq ac-sources '(ac-source-words-in-buffer))))

;; for objc-mode
(setq ac-modes (append ac-modes '(objc-mode)))
(require 'etags-table)
(add-to-list  'etags-table-alist
              '("\\.[mh]$" "~/.emacs.d/tags/objc.TAGS"))
(defvar ac-source-etags-table
  '((candidates . (lambda ()
         (all-completions ac-target (tags-completion-table))))
    (candidate-face . ac-candidate-face)
    (selection-face . ac-selection-face)
    (requires . 1))
  "etags をソースにする")
(add-hook 'objc-mode-hook
          (lambda ()
           (push 'ac-source-company-xcode ac-sources)
           (push 'ac-source-c++-keywords ac-sources)
           (push 'ac-source-etags-table ac-sources)))
