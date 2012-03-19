;;
;; markdown-mode
;;
;; (install-elisp "http://jblevins.org/projects/markdown-mode/markdown-mode.el")
;; manual http://jblevins.org/projects/markdown-mode/
;;______________________________________________________________________

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdwn$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdt$" . markdown-mode))

