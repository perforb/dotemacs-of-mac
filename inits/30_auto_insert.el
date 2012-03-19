;;
;; auto-insert
;;______________________________________________________________________

;; ファイル形式に応じて自動でテンプレート挿入
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-directory "~/.emacs.d/templates")
(setq auto-insert-alist
      '((cperl-mode    . "perl-template.pl")
        (php-mode      . "php-template.php")
        (markdown-mode . "md_template.md")
        (html-mode     . "html-template.html")))
