(defvar tagfile "f:/.tags")

(load-library tagfile)

(setq helm-orgpaper-tags
  (helm-build-sync-source "Insert tags"
    :candidates org-newspaper-tags-list
    ;; :action     (lambda (s) (insert (cl-reduce #'concat s)))
    :action     (lambda (s) (message "%s%s" "hoge" helm-marked-candidates))
    :migemo     t
    :persistent-action (lambda (s) (insert (length s)))))

(defun helm-orgpaper-insert-tags ()
  (interactive)
  (helm :sources '(helm-orgpaper-tags)
        :buffer "*helm tags*"))

