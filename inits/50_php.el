;;
;; php-mode
;; ref http://tech.kayac.com/archive/php-completion.html
;; ref http://tech.kayac.com/archive/emacs.html
;;______________________________________________________________________

;; (require 'php-mode)
;; (autoload 'php-mode "php-mode")
;; (setq auto-mode-alist
;;       (cons '("\\.php\\'" . php-mode) auto-mode-alist))
;; (setq php-mode-force-pear t)
;; (defun pear/php-mode-init()
;;   "Set some buffer-local variables."
;;   (setq case-fold-search t)
;;   (c-set-offset 'arglist-intro '+)
;;   (c-set-offset 'arglist-close 0))
;; (add-hook 'php-mode-hook 'pear/php-mode-init)
;; (add-hook 'php-mode-hook
;;           '(lambda ()
;;              (c-set-style "stroustrup")
;;              (setq c-basic-offset 4)
;;              (setq indent-tabs-mode nil)
;;              (setq tab-width 4)))
;; (add-hook 'php-mode-hook
;;           (lambda ()
;;             (c-set-offset 'case-label' 4)
;;             (c-set-offset 'arglist-intro' 4)
;;             (c-set-offset 'arglist-cont-nonempty' 4)
;;             (c-set-offset 'arglist-close' 0)))
;; (add-hook 'php-mode-hook
;;           (lambda ()
;;             (require 'php-completion)
;;             (php-completion-mode t)
;;             (define-key php-mode-map (kbd "C-l") 'phpcmp-complete)
;;             (when (require 'auto-complete nil t)
;;               (make-variable-buffer-local 'ac-sources)
;;               (add-to-list 'ac-sources 'ac-source-php-completion)
;;               (auto-complete-mode t)
;;               )
;;             ))


;; INSTALL
;; (install-elisp-from-emacswiki "php-mode-improved.el")

(require 'php-mode)
(autoload 'php-mode "php-mode")
;; (setq auto-mode-alist
;;       (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq php-mode-force-pear t)
(defun pear/php-mode-init()
  "Set some buffer-local variables."
  (setq case-fold-search t)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close 0))
(add-hook 'php-mode-hook 'pear/php-mode-init)
(add-hook 'php-mode-hook
          '(lambda ()
             (c-set-style "stroustrup")
             (setq php-manual-path "/usr/share/doc/php/html")
             (setq php-search-url  "http://www.phppro.jp/")
             (setq php-manual-url  "http://www.phppro.jp/phpmanual")
             (setq indent-tabs-mode nil)
             (setq c-basic-offset 2)
             (setq tab-width 2)
             ))

;; php-eval.el
;; (install-elisp "http://www.ne.jp/asahi/alpha/kazu/pub/emacs/php-eval.el")

(require 'php-eval)

;; リージョン内のコード(<?php ?>がなくてもOK)を評価
;; http://d.hatena.ne.jp/kitokitoki/20100605/p1
(defun my-php-eval-region ()
  (interactive)
  (when (region-active-p)
    (let ((region-str (buffer-substring-no-properties (region-beginning) (region-end)))
          (result-buf "*php*")
          (temp-file "/tmp/hoge.php"))
      (with-temp-file temp-file
        (insert "<?php \n" region-str))
      (shell-command (concat "php " temp-file) result-buf)
      (view-buffer-other-window result-buf t
                                (lambda (buf)
                                  (kill-buffer-and-window)
                                  (delete-file temp-file))))))

(eval-after-load 'php-eval
  '(progn
    (define-key php-mode-map (kbd "C-c C-r C-r") 'my-php-eval-region)
    (define-key php-mode-map (kbd "C-c C-r C-v") 'php-eval-display-buffer)
    ))
