;;
;; html-helper-mode
;; ref http://www.nongnu.org/baol-hth/
;; ref https://gist.github.com/672655
;; ref http://oku.edu.mie-u.ac.jp/~okumura/html/emacs.html (manual)
;; ref http://what-linux.seesaa.net/article/134521580.html (manual)
;; ref http://code.google.com/p/zen-coding/wiki/ZenHTMLElementsEn (manual)
;;______________________________________________________________________

(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
(setq auto-mode-alist
      (append '(("\\.html$" . html-helper-modee)
                ("\\.twig$" . html-helper-mode))
              auto-mode-alist))
(setq html-helper-basic-offset 0)
(setq html-helper-item-continue-indent 0)
(setq html-helper-never-indent t)
(setq html-helper-verbose nil)
(defvar html-helper-new-buffer-template
  '("<!DOCTYPE html>\n"
    "<html>\n"
    "\n"
    "<head>\n"
    "<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\">\n"
    "<title></title>\n"
    "</head>\n"
    "\n"
    "<body>\n"
    "\n"
    "\n"
    "\n"
    "</body>\n"
    "</html>\n")
  "*Template for new buffers, inserted by html-helper-insert-new-buffer-strings if html-helper-build-new-buffer is set to t")

(require 'sgml-mode)
(add-hook 'html-helper-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-e") 'sgml-close-tag)
             (set-face-bold-p 'html-tag-face nil)))


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
(add-hook 'html-helper-mode-hook
          '(lambda ()
             (define-key html-helper-mode-map (kbd "C-M-q") 'my-html-format-region)))
