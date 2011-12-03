;; objc-mode

(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

;; Xcode上でコンパイル＆実行
(defun xcode-buildandrun ()
 (interactive)
 (do-applescript
  (format
   (concat
    "tell application \"Xcode\" to activate \r"
    "tell application \"System Events\" \r"
    "     tell process \"Xcode\" \r"
    "          key code 36 using {command down} \r"
    "    end tell \r"
    "end tell \r"
    ))))

;; Xcodeにブレークポイント追加
;; http://d.hatena.ne.jp/kaniza/20090915/p1
(defun xcode-add-breakpoint-at-line ()
  (interactive)
  (let ((line (number-to-string (line-number-at-pos)))
        (file-path buffer-file-name))
    (do-applescript (concat
     "tell application \"Xcode\"
        activate
        tell front project
          repeat with r in file references
            set p to full path of r
            if \"" file-path "\" = p then
              set bp to make new file breakpoint with properties {line number:" line "}
              set file reference of bp to r
              set enabled of bp to true
              exit repeat
            end if
         end repeat
       end tell
     end tell"))))

(add-hook 'objc-mode-hook
          (lambda ()
            (define-key objc-mode-map (kbd "C-c C-r") 'xcode-buildandrun)
            (define-key objc-mode-map (kbd "C-c C-b") 'xcode-add-breakpoint-at-line)
            ))




;;
;; Objective-C
;; ref http://sakito.jp/emacs/emacsobjectivec.html
;;______________________________________________________________________

;; (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
;; (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
;; (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

;; ;; 例えば #import <UIKit/UIKit.h> 等の記述から簡単にヘッダファイルを開きたい場合があります。
;; ;; ffap を利用すると C-x C-f するとカーソルがある部分を解析してファイルとして開こうとします。
;; ;; ffap は C-x C-f の挙動が変化するので注意してください。
;; (ffap-bindings)
;; ;; 探すパスは ffap-c-path で設定する
;; ;; (setq ffap-c-path
;; ;;     '("/usr/include" "/usr/local/include"))
;; ;; 新規ファイルの場合には確認する
;; (setq ffap-newfile-prompt t)
;; ;; ffap-kpathsea-expand-path で展開するパスの深さ
;; (setq ffap-kpathsea-depth 5)

;; ;; また、 .h を開いている時に対応する .m を開いたり、 .m を開いている時に
;; ;; 対応する .h を開いたりしたい場合、 ff-find-other-file を利用します。
;; ;; 以下のように設定すると C-c o で対応するファイルを開いてくれます。
;; (setq ff-other-file-alist
;;       '(("\\.mm?$" (".h"))
;;         ("\\.cc$"  (".hh" ".h"))
;;         ("\\.hh$"  (".cc" ".C"))

;;         ("\\.c$"   (".h"))
;;         ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

;;         ("\\.C$"   (".H"  ".hh" ".h"))
;;         ("\\.H$"   (".C"  ".CC"))

;;         ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
;;         ("\\.HH$"  (".CC"))

;;         ("\\.cxx$" (".hh" ".h"))
;;         ("\\.cpp$" (".hpp" ".hh" ".h"))

;;         ("\\.hpp$" (".cpp" ".c"))))
;; (add-hook 'objc-mode-hook
;;           (lambda ()
;;             (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)
;;             ))

;; ;; ロード
;; (require 'ac-company)
;; ;; ac-company で company-xcode を有効にする
;; (ac-company-define-source ac-source-company-xcode company-xcode)
;; ;; objc-mode で補完候補を設定
;; (setq ac-modes (append ac-modes '(objc-mode)))
;; ;; hook
;; (add-hook 'objc-mode-hook
;;           (lambda ()
;;             (define-key objc-mode-map (kbd "\t") 'ac-complete)
;;             ;; XCode を利用した補完を有効にする
;;             (push 'ac-source-company-xcode ac-sources)
;;             ;; C++ のキーワード補完をする Objective-C++ を利用する人だけ設定してください
;;             ;; (push 'ac-source-c++-keywords ac-sources)
;;             ))

;; ;; etags-table の機能を有効にする
;; (require 'etags-table)
;; (add-to-list  'etags-table-alist
;;               '("\\.[mh]$" "~/.emacs.d/share/tags/objc.TAGS"))
;; ;; auto-complete に etags の内容を認識させるための変数
;; ;; 以下の例だと3文字以上打たないと補完候補にならないように設定してあります。requires の次の数字で指定します
;; (defvar ac-source-etags
;;   '((candidates . (lambda ()
;;                     (all-completions ac-target (tags-completion-table))))
;;     (candidate-face . ac-candidate-face)
;;     (selection-face . ac-selection-face)
;;     (requires . 3))
;;   "etags をソースにする")
;; ;; objc で etags からの補完を可能にする
;; (add-hook 'objc-mode-hook
;;           (lambda ()
;;             (push 'ac-source-etags ac-sources)))

;; (defun xcode:buildandrun ()
;;   (interactive)
;;   (do-applescript
;;    (format
;;     (concat
;;      "tell application \"Xcode\" to activate \r"
;;      "tell application \"System Events\" \r"
;;      "     tell process \"Xcode\" \r"
;;      "          key code 36 using {command down} \r"
;;      "    end tell \r"
;;      "end tell \r"
;;      ))))

;; (add-hook 'objc-mode-hook
;;           (lambda ()
;;             (define-key objc-mode-map (kbd "C-c C-r") 'xcode:buildandrun)
;;             ))
