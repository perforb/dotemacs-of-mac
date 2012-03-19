;;
;; anything
;; (auto-install-batch "anything")
;;______________________________________________________________________

(require 'anything-startup)


;;
;; anything-c-moccur
;; [Usage]
;; M-s で3文字以上入力
;;______________________________________________________________________

;; 1)M-x auto-install-from-emacswiki color-moccur.el
(require 'color-moccur)

;; 1)M-x auto-install-from-url http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el
(require 'anything-c-moccur)
(setq moccur-split-word t)


;;
;; anything-gtags
;; (auto-install-from-url "http://www.emacswiki.org/cgi-bin/wiki/download/anything-gtags.el")
;;______________________________________________________________________

;; (require 'anything-gtags)


;;
;; anything-project
;;
;; (install-elisp "https://github.com/imakado/anything-project/raw/master/anything-project.el")
;;______________________________________________________________________

(require 'anything-project)
(global-set-key (kbd "C-c b") 'anything-project)
(ap:add-project
 :name 'perl
 :look-for '("Makefile.PL" "Build.PL")
 :include-regexp '("\\.pm$" "\\.t$" "\\.pl$" "\\.PL$" "\\.mt$" "\\.tt$")
 :exclude-regexp '("/tmp" "/service")
 )

(ap:add-project
 :name 'symfony
 :look-for '("symfony")
 :include-regexp '("\\.php$" "\\.html" "\\.yml$" "\\.base$" "\\.txt$")
 :exclude-regexp '("/cache" "/log" ".*/vendor" ".*/sf")
 )

;; file cache for anything-project
;; http://d.hatena.ne.jp/kitokitoki/20110710/p1
(defvar ap:project-files ".ap-project-files")

(defadvice anything-project (around anything-project-by-file-cache activate)
  (interactive)
  (anything-project-init)
  (anything-other-buffer
   `(((name . "Project Files in File Cache")
      (candidates-file . ,(ap:get-project-root-path))
      (action . (("Find file" .
                  (lambda (c)
                    (find-file (ap:expand-file c))))
                 ("Find file other window" .
                  (lambda (c)
                    (find-file-other-window (ap:expand-file c))))
                 ("Find file other frame" .
                  (lambda (c)
                    (find-file-other-frame (ap:expand-file c))))
                 ("Open dired in file's directory" .
                  (lambda (c)
                    (ap:anything-c-open-dired (ap:expand-file c))))))))
   "*anything project in file cache*"))

(defun ap:make-cache-file ()
  (interactive)
  (with-temp-buffer
    (insert (mapconcat 'identity (ap:get-project-files) "\n"))
    (write-file (ap:get-project-root-path))))

(defun ap:get-project-root-path ()
  (ap:aif (car (ap:get-root-directory))
      (concat it ap:project-files)
     nil))

(defun anything-project-init ()
  (ap:set-project-root-path)
  (when (or current-prefix-arg (not (ap:project-files-p)))
     (ap:make-cache-file)))

(defun ap:set-project-root-path ()
  (setq ap:root-directory (car (ap:get-root-directory))))

(defmacro ap:aif (test-form then-form &optional else-form)
  `(let ((it ,test-form))
     (if it ,then-form ,else-form)))

(defun ap:project-files-p ()
  (file-exists-p (ap:get-project-root-path)))
