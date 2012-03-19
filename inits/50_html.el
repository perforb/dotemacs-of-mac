;;
;; html-mode
;;______________________________________________________________________

(setq auto-mode-alist (cons '("\\.html$" . html-mode) auto-mode-alist))
(setq auto-mode-alist
      (append '(("\\.html$" . html-mode)
                ("\\.twig$" . html-mode)
                ("\\.$" . html-mode))
              auto-mode-alist))

;; html format
;; ref http://d.hatena.ne.jp/kitokitoki/20101219/p1
(defun my-html-format-region (begin end)
  "リージョンの HTML を整形します。なお整形に失敗した場合はバッファ内容のままとなります。"
  (interactive "r")
  ;; hamcutlet.rb は PATH から探索できる前提
  (unless (executable-find "hamcutlet.rb")
    (error "hamcutlet.rb を利用できません"))
  (let ((text (buffer-substring-no-properties begin end)))
    (delete-region begin end)
    (call-process "hamcutlet.rb" nil t 0 text)))

(defalias 'htmlf 'my-html-format-region)
(add-hook 'html-mode-hook
          '(lambda ()
             (define-key html-mode-map (kbd "C-M-q") 'my-html-format-region)))
