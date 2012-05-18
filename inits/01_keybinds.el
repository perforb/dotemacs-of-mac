;;
;; Key Binding
;;______________________________________________________________________

;; recentf-open-files を SUPER-f に割り当て
;; キーバインド設定参考 http://d.hatena.ne.jp/tomoya/20090415/1239809615
(define-key global-map [(s f)] 'recentf-open-files)

;; C-l に略語展開・補完機能を割り当て
(define-key global-map (kbd "M-/") 'hippie-expand)

;; C-h をバックスペースに変更
(keyboard-translate ?\C-h ?\C-?)

;; C-: に anything-for-files を割り当て
(define-key global-map (kbd "C-:") 'anything-for-files)

;; フレームの移動
(global-set-key (kbd "C-t") 'next-multiframe-window)
(global-set-key (kbd "C-S-t") 'previous-multiframe-window)

;; インデント
(global-set-key (kbd "C-S-i") 'indent-region)

;; インデントの削除
(global-set-key (kbd "C-c d") 'delete-indentation)

;; Eclipse ライクな行の複製
(defun duplicate-line-backward ()
  "Duplicate the current line backward."
  (interactive "*")
  (save-excursion
    (let ((contents
           (buffer-substring
            (line-beginning-position)
            (line-end-position))))
      (beginning-of-line)
      (insert contents ?\n)))
  (previous-line 1))

(defun duplicate-region-backward ()
  "If mark is active duplicates the region backward."
  (interactive "*")
  (if mark-active

      (let* (
             (deactivate-mark nil)
             (start (region-beginning))
             (end (region-end))
             (contents (buffer-substring
                        start
                        end)))
        (save-excursion
          (goto-char start)
          (insert contents))
        (goto-char end)
        (push-mark (+ end (- end start))))
    (error
     "Mark is not active. Region not duplicated.")))

(defun duplicate-line-forward ()
  "Duplicate the current line forward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
                     (line-beginning-position)
                     (line-end-position))))
      (end-of-line)
      (insert ?\n contents)))
  (next-line 1))

(defun duplicate-region-forward ()
  "If mark is active duplicates the region forward."
  (interactive "*")
  (if mark-active
      (let* (
             (deactivate-mark nil)
             (start (region-beginning))
             (end (region-end))
             (contents (buffer-substring
                        start
                        end)))
        (save-excursion
          (goto-char end)
          (insert contents))
        (goto-char start)
        (push-mark end)
        (exchange-point-and-mark))
    (error "Mark is not active. Region not duplicated.")))

(global-set-key (kbd "<M-s-up>") 'duplicate-line-backward)
(global-set-key (kbd "<M-s-down>") 'duplicate-line-forward)
