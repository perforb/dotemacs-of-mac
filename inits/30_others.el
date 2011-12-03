;; uniq
;; (install-elisp "http://www.arttaylor.com/~reeses/software/uniq.el")
(load "uniq")


;; 終了前に確認する
(defadvice save-buffers-kill-emacs
  (before safe-save-buffers-kill-emacs activate)
  "safe-save-buffers-kill-emacs"
  (unless (y-or-n-p "Really exit emacs? ")
    (keyboard-quit)))


;; sequential-command
;; ref http://d.hatena.ne.jp/rubikitch/20090219/sequential_command
;; (auto-install-batch "sequential-command")
(require 'sequential-command-config)
(define-sequential-command seq-home
  back-to-indentation beginning-of-line beginning-of-buffer seq-return)
(define-sequential-command seq-end
  end-of-line end-of-buffer seq-return)
(sequential-command-setup-keys)


;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")


;; sudo-ext
;; ref http://d.hatena.ne.jp/rubikitch/20101018/sudoext
;; (install-elisp-from-emacswiki "sudo-ext.el")
(require 'sudo-ext)


;; open-junk-file.el
;; (install-elisp-from-emacswiki "open-junk-file.el")
(require 'open-junk-file)
(setq open-junk-file-format "~/junk/%Y/%m/%Y%m%d_%H%M%S.")

