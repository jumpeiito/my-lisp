(load "f:/.tags")

(defun helm-orgtags-insert (slist)
  (cl-flet ((concat-colon (a b) (concat a ":" b)))
    (insert (concat ":"
		    (cl-reduce #'concat-colon slist)
		    ":"))))

(defvar helm-orgtags-source
  (helm-build-sync-source "OrgNews Tags"
    :candidates org-newspaper-tags-list
    :action     (lambda (e) (helm-orgtags-insert (helm-marked-candidates)))
    :migemo     t))

(defun helm-orgtags ()
  (interactive)
  (helm :sources '(helm-orgtags-source)
	:buffer "*helm orgtags*"))

