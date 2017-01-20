;; (defvar helm-w3m-history-candidates nil)

(defun helm-w3m-history-make-candidates ()
  (let (alist)
    (mapatoms
     (lambda (sym)
       (and sym
	    (setq url (symbol-name sym))
	    (not (string-match "#" url))
	    (not (string-match w3m-history-ignored-regexp url))
	    (let ((title (or (w3m-arrived-get url 'title) url)))
	      (push (cons title url) alist))))
     w3m-arrived-db)
    alist))

(defun helm-w3m-history-make-source (candidates)
  (helm-build-sync-source "W3M history"
    :candidates candidates
    :migemo     t
    :action     (helm-make-actions
		 "Open" #'w3m-goto-url
		 "Open with new tab" #'w3m-goto-url-new-session)))

(defun helm-w3m-history ()
  (interactive)
  (let ((helm-w3m-history-candidates
	 (helm-w3m-history-make-candidates)))
    (helm :sources `(,(helm-w3m-history-make-source helm-w3m-history-candidates))
	  :buffer  "*helm w3m-history*")))


