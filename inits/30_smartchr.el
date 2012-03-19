;;
;; smartchr
;; ref http://sakito.jp/emacs/emacsobjectivec.html
;; ref http://tech.kayac.com/archive/emacs-tips-smartchr.html
;;______________________________________________________________________

(require 'smartchr)
(defun smartchr-custom-keybindings ()
  (local-set-key (kbd "=") (smartchr '("=" " = " " == " " === ")))
  ;; !! がカーソルの位置
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[[`!!']]" "[")))
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{\n`!!'\n}" "{")))
  (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ">") (smartchr '(">" "->" ">>")))
  )

(defun smartchr-custom-keybindings-objc ()
  (local-set-key (kbd "@") (smartchr '("@\"`!!'\"" "@")))
  )

(add-hook 'php-mode-hook 'smartchr-custom-keybindings)
(add-hook 'c-mode-common-hook 'smartchr-custom-keybindings)
(add-hook 'js2-mode-hook 'smartchr-custom-keybindings)
(add-hook 'ruby-mode-hook 'smartchr-custom-keybindings)
(add-hook 'cperl-mode-hook 'smartchr-custom-keybindings)
(add-hook 'objc-mode-hook 'smartchr-custom-keybindings-objc)
