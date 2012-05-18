;;
;; markdown-mode
;;
;;______________________________________________________________________

;; (install-elisp "http://jblevins.org/projects/markdown-mode/markdown-mode.el")
;; http://jblevins.org/projects/markdown-mode/

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdwn$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdt$" . markdown-mode))

;; org-mode の表作成を自動で利用可能にする
(add-hook 'markdown-mode-hook 'turn-on-orgtbl)
