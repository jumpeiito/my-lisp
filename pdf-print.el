(require 'cl)

(setq pp/program-path
  "C:/users/kkr0133/Appdata/Roaming/local/bin/PDFSexp-exe.exe ")

(defvar pp/buffer-name "*pp*")

(setq pp/select-line-background "white")
(setq pp/select-line-foreground "black")

(defface pp/date
  `((t (:bold t :font "Consolas" :height 400)))
  "")

(defface pp/select-checkbox
  `((t (:bold t :foreground "violet"))) "")

(defface pp/unnotifiable
  `((t (:bold t :foreground "gray40" :font "Consolas" :height 100)))
  "")

(defface pp/shibu
  `((t (:bold t :font "Consolas")))
  "")

(defface pp/shibu-1
  `((t (:bold t :font "Consolas" :foreground "DeepSkyBlue1"))) "")

(defface pp/shibu-2
  `((t (:bold t :font "Consolas" :foreground "yellow"))) "")

(defface pp/shibu-3
  `((t (:bold t :font "Consolas" :foreground "chartreuse1"))) "")

(defface pp/shibu-4
  `((t (:bold t :font "Consolas" :foreground "DarkOrchid1"))) "")

(defface pp/rishokuhyo
  `((t (:bold t :font "Consolas" :foreground "red")))
  "")

(defface pp/select-line
  `((t (:background "dark slate blue"
        :bold t)))
  "")

(defface pp/type-got
  `((t (:foreground "orange" :bold t :font "Consolas")))
  "")

(defface pp/type-lost
  `((t (:foreground "yellow" :bold t :font "Consolas")))
  "")

(defmacro cut (&rest body)
  `(lambda (cut-args)
     ,(-tree-map (lambda (leaf)
                   (case leaf
                     (<> 'cut-args)
                     (t  leaf)))
                 body)))

(setq shibu-alist
  '(("10" . "ñk")
    ("11" . "è„")
    ("12" . "íÜ")
    ("13" . "â∫")
    ("14" . "ìÏ")
    ("15" . "ç∂")
    ("16" . "ìå")
    ("17" . "éR")
    ("18" . "âE")
    ("19" . "êº")
    ("20" . "ïö")
    ("21" . "ëÁ")
    ("50" . "â≥")
    ("51" . "âF")
    ("53" . "ãT")
    ("54" . "ëD")
    ("56" . "àª")
    ("57" . "ïü")
    ("58" . "ïë")
    ("59" . "ã{")
    ("60" . "âú")
    ("61" . "ëä")
    ("62" . "óå")
    ("63" . "í‘")))

(setq hellowork-alist
      '(("10" . "êºêw")
        ("11" . "êºêw")
        ("12" . "êºêw")
        ("13" . "éµè")
        ("14" . "éµè")
        ("15" . "êºêw")
        ("16" . "êºêw")
        ("17" . "éµè")
        ("18" . "êºêw")
        ("19" . "êºêw")
        ("20" . "ïöå©")
        ("21" . "ïöå©")
        ("50" . "éµè")
        ("51" . "âFé°")
        ("53" . "êºêw")
        ("54" . "êºêw")
        ("56" . "àªïî")
        ("57" . "ïüím")
        ("58" . "ïëíﬂ")
        ("59" . "ã{í√")
        ("60" . "ïÙéR")
        ("61" . "ñÿí√")
        ("62" . "âFé°")
        ("63" . "ìcï”")))

(defun code-to-shibu-name (code)
  (cdr (assoc code shibu-alist)))

(defun code-to-hellowork (code)
  (cdr (assoc code hellowork-alist)))

(defun pp/font-lock-add-keywords ()
  (font-lock-add-keywords
   nil
   `(("éÊìæ"      . 'pp/type-got)
     ("ëré∏"      . 'pp/type-lost)
     ("ëró£"      . 'pp/rishokuhyo)
     ("\\[X\\]"   . 'pp/select-checkbox)
     ("(.)->êºêw" . 'pp/shibu-1)
     ("(.)->éµè" . 'pp/shibu-2)
     ("(.)->ïöå©" . 'pp/shibu-3)
     ("(.)->âFé°" . 'pp/shibu-4)
     ("(.)->.."   . 'pp/shibu)
     ("[0-9][0-9][0-9][0-9][-/][0-9]*[0-9][-/][0-9]*[0-9]" . 'pp/date)
     ("[0-9][0-9][0-9][0-9][0-9][0-9]" . 'pp/unnotifiable)
     (,pp/header-regexp 2 'pp/unnotifiable))))

(defun pp/define-key ()
  (mapc
   (cut define-key pp-mode-map (car <>) (cdr <>))
   '(("\C-c "    . pp/select-line-face-toggle)
     ("\C-c\C-c" . pp/select-line-face-toggle)
     ("\C-cm"    . pp/select-all)
     ("\C-cs"    . pp/sort-interactive)
     ("\C-cn"    . pp/select-except-rishokuhyo)
     ("\C-cu"    . pp/unselect-all)
     ("\C-co"    . pp/pdf-open))))

(defun pp-mode ()
  (interactive)
  (kill-all-local-variables)
  (setq major-mode  'pp-mode
        mode-name   "PP mode"
        pp-mode-map (make-keymap))
  (pp/define-key)
  (use-local-map pp-mode-map)
  (setq line-spacing 2)
  (run-hooks 'pp-mode-hook)
  (pp/font-lock-add-keywords)
  (setq buffer-read-only t))

(defmacro with-change (&rest body)
  `(progn
     (setq buffer-read-only nil)
     (progn ,@body)
     (setq buffer-read-only t)))

(defstruct pp/unit
  (number  nil)
  (oCode   nil)
  (oName   nil)
  (sCode   nil)
  (person  nil)
  (type    nil)
  (pdflist nil))

(defstruct pp/pdffile
  (filename nil)
  (timestamp nil))

(defun filepath-to-pp/pdffile (filepath)
  (when (string-match "\\(.+?\\)@\\(.+\\)" filepath)
    (make-pp/pdffile
     :filename (match-string 1 filepath)
     :timestamp (match-string 2 filepath))))

(defun pp/buffer-string-list ()
  "*PP*ÉoÉbÉtÉ@Ç…Ç†ÇÈï∂éöóÒÇâ¸çsÇ≈splitÇµÅAÉäÉXÉgÇ…ÇµÇƒï‘Ç∑ÅB"
  (save-excursion
    (if (buffer-live-p (get-buffer pp/buffer-name))
        (progn
          (set-buffer pp/buffer-name)
          (split-string (buffer-substring-no-properties
                         (point-min) (point-max))
                        "\n")))))

(defun pp/get-marked-number ()
  "*PP*ÉoÉbÉtÉ@Ç…Ç†ÇÈï∂éöóÒÇ©ÇÁÅAÉ`ÉFÉbÉNÇÃÇ¬Ç¢ÇΩêîéöÇÃÉäÉXÉgÇï‘Ç∑ÅB"
  (compact
   (mapcar #'pp/title-line-marked-parse
           (pp/buffer-string-list))))

(defun pp/get-pdffiles-from-marked-number (number-list)
  "*PP*ÉoÉbÉtÉ@Ç…Ç†ÇÈÉ`ÉFÉbÉNÇÃÇ¬Ç¢ÇΩêîéöÇÃÉäÉXÉgÇ©ÇÁÅAPDFÉtÉ@ÉCÉãÉpÉXÇéÊìæÇ∑ÇÈÅB"
  (let ((units (pp/unit-list)))
    (-reduce-r-from
     (lambda (num files)
       (append files
               (mapcar #'pp/pdffile-filename
                       (pp/unit-pdflist (nth num units)))))
     nil
     number-list)))

(defun pp/pdf-open-command (pdffile)
  (shell-command (concat "start " pdffile)))

(defun pp/pdf-open ()
  (interactive)
  (mapc #'pp/pdf-open-command
        (pp/get-pdffiles-from-marked-number
         (pp/get-marked-number)))
  (pp/unselect-all))

(defun pp/title-line-marked-parse (title-line)
  (if (< (length title-line) 6)
      nil
    (-if-let (match-string
              (s-match (concat pp/header-regexp " \\[X\\]")
                       title-line))
        (string-to-number (third match-string)))))

(setq pp/header-regexp
      "\\(éÊìæ\\|ër.\\) \\([0-9][0-9]\\)")

(defun pp/erase-buffer-contents ()
  (goto-char (point-min))
  (next-line)
  (delete-region (point) (point-max)))

(defmacro pp/with-selection (&rest body)
  `(progn
     (goto-char (point-min))
     (next-line)
     (goto-char (point-at-bol))
     (while (not (eq (point-at-eol) (point-max)))
       ,@body
       (next-line))))

(defun pp/select-all ()
  (interactive)
  (pp/with-selection (pp/select)))

(defun pp/unselect-all ()
  (interactive)
  (pp/with-selection (pp/unselect)))

(defun pp/select-except-rishokuhyo ()
  (interactive)
  (pp/with-selection
   (goto-char (point-at-bol))
   (if (looking-at "ëró£")
       (pp/unselect)
     (pp/select))))

(defun pp/modify-status (insert-string)
  (with-change
   (goto-char (point-at-bol))
   (forward-char 6)
   (delete-char 3)
   (insert insert-string)))

(defun pp/select ()
  (interactive)
  (pp/modify-status "[X]"))

(defun pp/unselect ()
  (interactive)
  (pp/modify-status "[ ]"))

(defun pp/select-line-face-toggle ()
  (interactive)
  (goto-char (point-at-bol))
  (if (--> " \\[ \\]" (concat pp/header-regexp it) (looking-at it))
      (pp/select)
    (pp/unselect))
  (next-line)
  (font-lock-mode 1))

(defun drop (i l)
  (dotimes (c i)
    (setq l (cdr l))) l)

(defun string-take (N S)
  (if (> N (length S))
      S (substring S 0 N)))

(defun compact (sublist)
  (-reduce-r-from (lambda (el seed)
                    (if el (cons el seed) seed))
                  '()
                  sublist))

(defun pp/get-string-list-from-file ()
  (with-temp-buffer
    (insert-file-contents "d:/home/.sexp2")
    (buffer-substring-no-properties (point-min)
                                    (point-max))))

(defun pp/get-list-from-file ()
  (-> (pp/get-string-list-from-file)
      (read)
      (quote)
      (eval)))

(defun pp/string-list (&optional date-string)
  (if date-string
      (--> " "
           (concat pp/program-path it
                   date-string it
                   "20000")
           (shell-command it)))
  (pp/get-list-from-file))

(defun pp/to-unit (element)
  (cl-destructuring-bind
      (n oC oN s p tp . pl)
      element
    (make-pp/unit
     :number  n :oCode   oC :oName   oN
     :sCode   s :person  p  :type    tp
     :pdflist (mapcar #'filepath-to-pp/pdffile pl))))

(defun pp/unit-type% (unit)
  (let ((tp (pp/unit-type unit)))
    (if (and (equal "ëré∏" tp)
             (pp/unit-has-rishokuhyo-p unit))
        "ëró£"
      tp)))

(defun pp/unit-oName% (unit)
  (let ((oName (pp/unit-oName unit)))
    (string-take
     20
     (cond
      ((string-match "áä" oName)
       (replace-regexp-in-string "áä" "(óL)" oName))
      ((string-match "áã" oName)
      (replace-regexp-in-string "áã" "(óL)" oName))
      (t oName)))))

(defun pp/unit-to-string (unit)
  (format "%s %02d [ ] (%s)->%s %s %s %-20s\t%s\n"
          (pp/unit-type% unit)
          (pp/unit-number unit)
          (code-to-shibu-name (pp/unit-sCode unit))
          (code-to-hellowork (pp/unit-sCode unit))
          (pp/pdffile-timestamp (car (pp/unit-pdflist unit)))
          (pp/unit-oCode unit)
          (pp/unit-oName% unit)
          (pp/unit-person unit)))

(defun pp/unit-has-rishokuhyo-p (unit)
  (-find (cut s-match "ó£êEï[" <>)
         (mapcar #'pp/pdffile-filename
                 (pp/unit-pdflist unit))))

(defun pp/unit-list (&optional date-string)
  (mapcar #'pp/to-unit
          (pp/string-list date-string)))

(defun pp/unit-insert (&optional date-string sort-function)
  (let ((f (or sort-function #'pp/sort/shibu)))
    (mapc (cut insert (pp/unit-to-string <>))
          (funcall f
                   (pp/unit-list date-string)))))

(defun pp/with-generate-buffer ()
  (if (buffer-live-p (get-buffer pp/buffer-name))
      (kill-buffer pp/buffer-name))
  (generate-new-buffer pp/buffer-name)
  (switch-to-buffer pp/buffer-name))

(defun pp ()
  (interactive)
  (pp/with-generate-buffer)
  (let* ((today (format-time-string "%Y/%m/%d" (current-time)))
         (reads (read-from-minibuffer (concat "date(default " today "): ") ""))
         (date  (if (string= reads "") today reads)))
    (insert (concat date "\n"))
    (pp/unit-insert date))
  (pp-mode))

(defun pp/sort (sorting-list unit-function list
                             &optional compare)
  (pp/%sort (cut pp/sort/%%/get-index <> unit-function sorting-list)
            list
            compare))

(defun pp/%sort (sorter list &optional compare)
  (let ((f (or compare #'<)))
    (-sort (lambda (x y)
             (funcall f
                      (funcall sorter x) (funcall sorter y)))
           list)))

(defun pp/sort/%%/get-index (unit getter sorting-list)
  (let ((idx (-find-index
              (cut equal <> (funcall getter unit))
              sorting-list)))
    (or idx 20000)))

(setq pp/sort/%%/unit-type
      '("éÊìæ" "ëré∏" "ëró£"))

(setq pp/sort/%%/hellowork
      '("êºêw" "éµè" "ïöå©" "âFé°"
        "ìcï”" "ñÿí√" "ïüím" "àªïî"
        "ïëíﬂ" "ïÙéR" "ã{í√"))

(defun pp/sort/unit-type (list &optional compare)
  (pp/sort pp/sort/%%/unit-type
           #'pp/unit-type%
           list
           compare))

(defun pp/sort/hellowork (list &optional compare)
  (pp/sort pp/sort/%%/hellowork
           (cut code-to-hellowork (pp/unit-sCode <>))
           list
           compare))

(defun pp/sort/number (list &optional compare)
  (pp/%sort #'pp/unit-number list compare))

(defun pp/sort/oCode (list &optional compare)
  (pp/%sort #'pp/unit-oCode
            list
            (or compare #'string<)))

(defun pp/sort/oName (list &optional compare)
  (pp/%sort #'pp/unit-oName
            list
            (or compare #'string<)))

(defun pp/sort/shibu (list &optional compare)
  (pp/%sort #'pp/unit-sCode
            list
            (or compare #'string<)))

(defun pp/sort-strategy-minibuffer-prompt ()
  (let* ((gen '("Type" "Number" "OfficeCode"
                "OfficeName" "Shibu" "HelloWork"))
         (alist (-zip (list 0 1 2 3 4 5) gen)))
    (-reduce-r-from (lambda (el seed)
                      (concat
                       (format "%s%s  "
                               (propertize (concat (number-to-string (car el))
                                                   ")")
                                           'face
                                           '(:foreground "white"
                                             :background "red"
                                             :bold "t"
                                             :family "Consolas"))
                               (cdr el))
                       seed))
                    ""
                    alist)))

(defun pp/sort-by-minibuffer-prompt ()
  (let* ((gen '("Order" "Reverse"))
         (alist (-zip (list 1 2) gen)))
    (-reduce-r-from (lambda (el seed)
                      (concat
                       (format "%s%s  "
                               (propertize (concat (number-to-string (car el))
                                                   ")")
                                           'face
                                           '(:foreground "black"
                                             :background "yellow"
                                             :bold "t"
                                             :family "Consolas"))
                               (cdr el))
                       seed))
                    ""
                    alist)))

(defun pp/sort-interactive ()
  (interactive)
  (let* ((sort-strategy
          (-> (pp/sort-strategy-minibuffer-prompt)
              (read-char)
              (char-to-string)))
         (sort-by
          (-> (pp/sort-by-minibuffer-prompt)
              (read-char)
              (char-to-string)))
         (sort-function
          (let ((sort-string
                 (concat sort-strategy sort-by)))
            (string-case sort-string
              ("01" (cut pp/sort/unit-type <>))
              ("02" (cut pp/sort/unit-type <> #'>))
              ("11" (cut pp/sort/number <>))
              ("12" (cut pp/sort/number <> #'>))
              ("21" (cut pp/sort/oCode <>))
              ("22" (cut pp/sort/oCode <> #'string>))
              ("31" (cut pp/sort/oName <>))
              ("32" (cut pp/sort/oName <> #'string>))
              ("41" (cut pp/sort/shibu <>))
              ("42" (cut pp/sort/shibu <> #'string>))
              ("51" (cut pp/sort/hellowork <>))
              ("52" (cut pp/sort/hellowork <> #'>))))))
    (switch-to-buffer pp/buffer-name)
    (with-change
     (pp/erase-buffer-contents)
     (message (concat sort-strategy sort-by))
     (pp/unit-insert nil sort-function))))

(defmacro string-case (expr &rest body)
  `(cond
    ,@(mapcar
       (lambda (c)
         `((equal ,expr ,(first c))
           ,(second c)))
       body)))

