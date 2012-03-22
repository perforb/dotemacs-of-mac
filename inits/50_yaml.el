;;
;; yaml
;;______________________________________________________________________

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; for yaml-mode
(add-hook 'yaml-mode-hook
          '(lambda ()
             (auto-complete-init-sources)
             (setq ac-sources '(ac-source-words-in-buffer)))))
