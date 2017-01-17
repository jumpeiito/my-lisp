(require 'cl)

(defun concat-with (arg &optional before after)
  (let ((b-str (or before ""))
	(a-str (or after "")))
    (apply #'concat
	   (mapcar (lambda (el) (concat b-str el a-str))
		   arg))))

(defun join-with (arg &optional before after)
  (concat-with arg before (concat after "\n")))

(defun insert:checkbox (arg)
  )
