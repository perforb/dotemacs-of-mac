;;
;; dired-x
;;______________________________________________________________________

(require 'dired-x)

;;
;; wdired
;;______________________________________________________________________

(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;;
;; etc
;;______________________________________________________________________

;; See http://d.hatena.ne.jp/nishikawasasaki/20120222/1329932699

;; ファイルなら別バッファで、ディレクトリなら同じバッファで開く
(defun dired-open-in-accordance-with-situation ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (dired-find-alternate-file)
      (dired-find-file))))

;; RET 標準の dired-find-file では dired バッファが複数作られるので
;; dired-find-alternate-file を代わりに使う
;; Note: この設定により, '.' と '..' の相対パスに移動する場合は a をタイプする必要がある.
(define-key dired-mode-map (kbd "RET") 'dired-open-in-accordance-with-situation)
(define-key dired-mode-map (kbd "a") 'dired-find-file)
