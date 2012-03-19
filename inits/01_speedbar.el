;;
;; speedbar
;;______________________________________________________________________

(defun my-speedbar-expand-line ()
  (interactive)
  (if (= (point-max) (progn (speedbar-expand-line) (point-max)))
      (save-current-buffer
        (speedbar-edit-line))))

(when (locate-library "speedbar")
  (require 'speedbar)
  ;; "a" で無視ファイル表示/非表示のトグル
  (define-key speedbar-file-key-map "a" 'speedbar-toggle-show-all-files)
  ;; ← や → でもディレクトリを開閉 ;;デフォルト: "=" "+", "-"
  (define-key speedbar-file-key-map [right] 'my-speedbar-expand-line)
  (define-key speedbar-file-key-map "\C-f" 'my-speedbar-expand-line)
  (define-key speedbar-file-key-map [left] 'speedbar-contract-line)
  (define-key speedbar-file-key-map "\C-b" 'speedbar-contract-line)
  ;; BS でも上位ディレクトリへ ;;デフォルト: "U"
  (define-key speedbar-file-key-map [backspace] 'speedbar-up-directory)
  (define-key speedbar-file-key-map "\C-h" 'speedbar-up-directory)
  ;; 起動位置を直接指定する
  (setq speedbar-frame-parameters
        (append (list '(top . 40)
                      '(left . 780)
                      '(width . 25))
                speedbar-frame-parameters))
  ;; Speedbar で表示するファイルタイプ
  (setq speedbar-supported-extension-expressions
        (append '("*.*")))
  ) ;; end of speedbar

;; F4 で Speedbar
(global-set-key [(meta f4)] 'speedbar-get-focus)
