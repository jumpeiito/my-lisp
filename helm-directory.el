(defun set-face-string (plist)
  (let ((val (plist-get plist :value)))
    (pcase (list (plist-get plist :type)
		 (plist-get plist :hancho))
      (`("老" "0") (propertize val 'face 'helm-rourei-face))
      (`("老" "1") (propertize val 'face 'helm-rourei-face2))
      (`("見" "0") (propertize val 'face 'helm-minarai-face))
      (`("見" "1") (propertize val 'face 'helm-minarai-face2))
      (`("青" "0") (propertize val 'face 'helm-seinen-face))
      (`("青" "1") (propertize val 'face 'helm-seinen-face2))
      (`("一" "1") (propertize val 'face 'helm-hancho-face))
      (t (propertize val 'face 'default)))))

(defface helm-seinen-face   '((t :foreground "#1e90ff" :bold t)) "自分専用のface")
(defface helm-seinen-face2  '((t :foreground "#1e90ff" :bold t :underline t)) "自分専用のface")
(defface helm-minarai-face  '((t :foreground "#228b22" :bold t)) "")
(defface helm-minarai-face2 '((t :foreground "#228b22" :bold t :underline t)) "")
(defface helm-rourei-face   '((t :foreground "#8a2be2" :bold t)) "")
(defface helm-rourei-face2  '((t :foreground "#8a2be2" :bold t :underline t)) "")
(defface helm-hancho-face  '((t :foreground "black" :background "violet" :bold t)) "")

(defun helm-kyokenro-file-buffer--transform (buf _)
  (cl-destructuring-bind ((file . tag) . path) buf
    (cons (concat (propertize tag 'face 'helm-buffer-process) "\t"
		  file)
	  path)))

(defun helm-kyokenro-file-transform (list)
  (mapcar (lambda (buf) (helm-kyokenro-file-buffer--transform buf 0))
	  list))

(defvar helm-kyokenro-directory
  (helm-kyokenro-file-transform
   '((("2015年度" . "基本")
      . "s:/原田フォルダ/2015年度")
     (("2016年度" . "基本")
      . "s:/原田フォルダ/2016年度")
     (("月別資料" . "月別")
      . "s:/原田フォルダ/2016年度/月別資料")
     (("さくら通信" . "新聞")
      . "s:/馬場フォルダ/醍醐さくら通信/2016年")
     (("組合員名簿" . "名簿")
      . "s:/馬場フォルダ/組合員名簿")
     (("山口フォルダ" . "個人")
      . "s:/山口フォルダ")
     (("原田フォルダ" . "個人")
      . "s:/原田フォルダ")
     (("馬場フォルダ" . "個人")
      . "s:/馬場フォルダ")
     (("伊東フォルダ" . "個人")
      . "s:/伊東フォルダ")
     (("支部フォルダ" . "支部")
      . "\\\\Kkrfsv01\\21醍醐")
     (("公開フォルダ" . "本部")
      . "\\\\Kkrfsv01\\支部公開フォルダ")
     (("専門部資料" . "本部")
      . "\\\\Kkrfsv01\\支部公開フォルダ\\専門部資料")
     (("国保組合" . "本部")
      . "\\\\Kkrfsv01\\支部公開フォルダ\\国保組合関係資料")
     (("作業主任・特別教育・職長教育" . "本部")
      . "\\\\Kkrfsv01\\支部公開フォルダ\\専門部資料\\作業主任・特別教育・職長教育")
     (("支部決算書" . "会計")
      . "s:/原田フォルダ/支部決算書")
     (("建設業許可" . "許可")
      . "s:/建設業許可")
     (("全労済" . "全労済")
      . "s:/原田フォルダ/全労済")
     (("建退共" . "建退共")
      . "s:/原田フォルダ/建退共")
     (("分会関係" . "分会")
      . "s:/原田フォルダ/分会関係")
     (("分会・班長会議関係" . "分会")
      . "s:/山口フォルダ/用紙書式/分会・班長会議関係")
     (("申請関係" . "申請")
      . "s:/原田フォルダ/申請関係")
     (("組合アルバム" . "写真")
      . "s:/馬場フォルダ/組合アルバム")
     (("除籍ハガキ" . "保険料")
      . "s:/山口フォルダ/保険料/除籍関係"))))

(defvar helm-kyokenro-file
  (helm-kyokenro-file-transform
   '((("組合員名簿.xlsm" . "名簿")
      . "s:/馬場フォルダ/組合員名簿/組合員名簿.xlsm")
     (("全労済給付.醍醐.xlsm" . "全労済")
      . "s:/原田フォルダ/全労済/全労済給付.醍醐.xlsm")
     (("日野班長連絡表.xlsx" . "分会")
      . "s:/原田フォルダ/分会関係/日野分会/16年度/16日野班長連絡表.xlsx")
     (("建退共受付簿.xlsm" . "建退共")
      . "s:/原田フォルダ/建退共/建退共受付簿.醍醐ver.xlsm")
     (("一般会計月別決算.xlsx" . "会計")
      . "s:/原田フォルダ/支部決算書/2016年度支部決算書/一般会計月別決算：16年度.xlsx")
     (("特別会計月別決算.xlsx" . "会計")
      . "s:/原田フォルダ/支部決算書/2016年度支部決算書/特別会計月別決算：16年度.xlsx")
     (("国保給付.xlsx" . "申請")
      . "s:/原田フォルダ/申請関係/国保給付.xlsx")
     (("総合共済.xlsx" . "申請")
      . "s:/原田フォルダ/申請関係/総合共済.xlsx")
     (("分会執行委員会報告.docx" . "分会")
      . "s:/山口フォルダ/用紙書式/分会・班長会議関係/分会執行委員会報告.docx")
     (("残名簿.xlsm" . "組合費")
      . "s:/伊東フォルダ/残名簿/石田-小栗栖残名簿六月.xlsm")
     (("出勤簿.xlsx" . "出勤簿")
      . "s:/伊東フォルダ/2016年度　出勤簿（原紙） (2).xlsx")
     (("拡大月間用訪問名簿.xlsb" . "拡大")
      . "s:/原田フォルダ/2016年度/拡大月間/拡大月間用訪問名簿.xlsb")
     (("加入手続状況一覧.xlsm" . "申請")
      . "s:/馬場フォルダ/新加入/2016年度加入手続状況一覧.xlsm")
     (("現勢報告書.xlsx" . "年間")
      . "s:/原田フォルダ/2016年度/年間資料/2016年度　現勢報告書.xlsx")
     (("組合費納入状況.xlsx" . "年間")
      . "s:/原田フォルダ/2016年度/年間資料/2016年度分会別組合費納入状況.xlsx")
     (("対象者名簿.xlsm" . "拡大")
      . "s:/原田フォルダ/2016年度/年間資料/2016年度拡大対象者名簿.xlsm")
     (("拡大進行状況.xlsx" . "年間")
      . "s:/原田フォルダ/2016年度/年間資料/2016年度月別拡大進行状況.xlsx")
     (("実行動参加.xlsx" . "拡大")
      . "s:/原田フォルダ/2016年度/拡大月間/行動参加確認表/実行動参加.xlsx")
     (("拡大月間進行表.xlsx" . "拡大")
      . "s:/原田フォルダ/2016年度/拡大月間/行動参加確認表/'16拡大月間　進行表.xlsx"))))

(defvar helm-source-kyokenro-directory
  (helm-build-sync-source "Open Directory"
    :candidates helm-kyokenro-directory
    :action     'find-file
    :migemo     t))

;; (defvar helm-source-meibo
;;   (helm-build-sync-source "Meibo"
;;     :candidates (mapcar #'set-face-string helm-meibo)
;;     :action     'insert
;;     :migemo     t))

(defvar helm-source-kyokenro-file
  (helm-build-sync-source "Open File"
    :candidates helm-kyokenro-file
    :action     (lambda (file) (w32-shell-execute "open" file nil 1))
    :migemo     t))

(defvar helm-w3m-history-candidates
  (let (alist)
    (mapatoms
     (lambda (sym)
       (and sym
	    (setq url (symbol-name sym))
	    (not (string-match "#" url))
	    (not (string-match w3m-history-ignored-regexp url))
	    (let ((title (or (w3m-arrived-title url) url)))
	      (push (cons title url) alist))))
     w3m-arrived-db)
    alist))

(defvar helm-w3m-history-v
  (helm-build-sync-source "W3M history"
    :candidates helm-w3m-history-candidates
    :migemo     t
    :action     (helm-make-actions
		 "Open" #'w3m-goto-url
		 "Open with new tab" #'w3m-goto-url-new-session)
    ))

(defun helm-w3m-history ()
  (interactive)
  (helm :sources '(helm-w3m-history-v)
	:buffer  "*helm w3m-history*"))

(defun helm-open-directory ()
  (interactive)
  (helm :sources '(helm-source-kyokenro-directory
		   helm-source-kyokenro-file
		   ;; helm-source-meibo
		   )
        :buffer  "*helm directory*"))

(defun read-sexp (proc string)
  ;; (let ((str (car (last (split-string string "\n")))))
  ;;   (sleep-for 1)
  ;;   (eval (read-from-string str)))
  ;; (with-temp-buffer
  ;;   (insert (car (last (split-string string "\n"))))
  ;;   (sleep-for 1)
  ;;   (message "hoge")
  ;;   (eval-buffer))
  (message (format "%s" (length (car (last (split-string string "\n")))))))

(defun insert2 (_ string)
  (insert string))


(defun myfetch (host file)
  (interactive "sHost: \nsFile: ")
  (unless (process-status "hoge")
    ;; (setq myfetch-buffer (get-buffer-create myfetch-buffer-name))
    (let ((proc (make-network-process :name "hoge"
                     :buffer nil
                     :family 'ipv4
                     :host "localhost"
                     :service 3000
                     ;; :sentinel 'myfetch-sentinel
                     :nowait nil
		     :coding 'utf-8
                     :filter 'read-sexp
		     :filter-multibyte t
		     :server nil)))
      ;; (myfetch-logging
      ;;  (format "Access to http://localhost:3000/csv/hoge" host file))
      ;; (myfetch-logging "Make connection...")
      (process-send-string
       proc (format "GET /csv/hoge HTTP/1.0\r\n\r\n" file)))))

(defun myfetch-filter (proc string)
  (myfetch-logging string))

(defun myfetch-sentinel (proc msg)
  (myfetch-logging (format "sentinel: proc=%s msg=%s" proc msg)))

(defun myfetch-logging (string)
  (when (get-buffer myfetch-buffer)
    (with-current-buffer myfetch-buffer
      (goto-char (point-max))
      (insert (current-time-string)
          " " string)
      (newline))))
