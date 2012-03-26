;;
;; migemo
;;______________________________________________________________________

;; ref http://yourpalm.jubenoum.com/2010/08/cocoa-emacs-%E3%81%AB-migemo-%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB/A
;; ref http://plus-alpha-space.cocolog-nifty.com/blog/2009/12/carbon-emacsmig.html
;; make 時に ruby: no such file to load -- romkan (LoadError) という ruby の require 絡みのエラー発生
;; このため migemo がうまく動かなかった
(setq migemo-command "migemo")
(setq migemo-options '("-t" "emacs"))
(setq migemo-dictionary (expand-file-name "~/.emacs.d/conf/migemo/migemo-dict"))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(require 'migemo)
(migemo-init)
