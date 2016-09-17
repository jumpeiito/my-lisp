(require 'cl-lib)

(defvar toggle-folding-output-buffer "*toggle-folding output*")
(defvar tf-newline "
")
(defvar line-head "　")

(defun header-chomp (str)
  (replace-regexp-in-string "^[ 　]+" "" str))

(defun string-straighten (str)
  (concat line-head
	  (cl-reduce (lambda (seed el)
		    (concat seed
			    (if (string-match el "^[ 　]+$")
				(concat tf-newline line-head)
				"")
			    (header-chomp el)))
		  (cdr (split-string str tf-newline))
		  :initial-value (header-chomp
				  (car (split-string str tf-newline))))))

(defun toggle-folding (bg en)
  (interactive "r")
  (save-excursion
    (let ((str (buffer-substring-no-properties bg en))
	  (curbuf (current-buffer))
	  (buf (or (get-buffer toggle-folding-output-buffer)
		   (generate-new-buffer toggle-folding-output-buffer))))
      (delete-other-windows)
      (split-window-vertically)
      (other-window 1)
      (switch-to-buffer buf)
      (delete-region (point-min) (point-max))
      (let ((pt  (point))
	    (sss (string-straighten str)))
	(insert sss)
	(kill-ring-save pt (point))
	(goto-char (point-min))
	(other-window 1)))))




