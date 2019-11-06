
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
      (_ (propertize val 'face 'default)))))

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
     (("2017年度" . "基本")
      . "s:/原田フォルダ/2017年度")
     (("月別資料" . "月別")
      . "s:/原田フォルダ/2017年度/月別資料")
     (("さくら通信" . "新聞")
      . "s:/馬場フォルダ/醍醐さくら通信/2017年")
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
     (("督促関係" . "組合費")
      . "s:/原田フォルダ/実務用品/督促関係")
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
      . "s:/原田フォルダ/分会関係/日野分会/17年度/17日野班長連絡表.xlsx")
     (("建退共受付簿.xlsm" . "建退共")
      . "s:/原田フォルダ/建退共/建退共受付簿.醍醐ver.xlsm")
     (("一般会計月別決算.xlsx" . "会計")
      . "s:/原田フォルダ/支部決算書/2017年度支部決算書/一般会計月別決算：17年度.xlsx")
     (("特別会計月別決算.xlsx" . "会計")
      . "s:/原田フォルダ/支部決算書/2017年度支部決算書/特別会計月別決算：17年度.xlsx")
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
     (("汎用組合費FAX.docx" . "組合費")
      . "s:/原田フォルダ/実務用品/督促関係/汎用組合費FAX.docx")
     (("加入手続状況一覧.xlsm" . "申請")
      . "s:/馬場フォルダ/新加入/2017年度加入手続状況一覧.xlsm")
     (("現勢報告書.xlsx" . "年間")
      . "s:/原田フォルダ/2017年度/年間資料/2017年度　現勢報告書.xlsx")
     (("組合費納入状況.xlsx" . "年間")
      . "s:/原田フォルダ/2017年度/年間資料/2017年度分会別組合費納入状況.xlsx")
     (("対象者名簿.xlsm" . "拡大")
      . "s:/原田フォルダ/2017年度/年間資料/2017年度拡大対象者名簿.xlsm")
     (("拡大進行状況.xlsx" . "年間")
      . "s:/原田フォルダ/2017年度/年間資料/2017年度月別拡大進行状況.xlsx")
     (("実行動参加.xlsx" . "拡大")
      . "s:/原田フォルダ/2017年度/拡大月間/行動参加確認表/実行動参加.xlsx")
     (("拡大月間進行表.xlsx" . "拡大")
      . "s:/原田フォルダ/2017年度/拡大月間/行動参加確認表/'17拡大月間　進行表.xlsx"))))

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
  ;; (message (format "%s" (length (car (last (split-string string "\n"))))))
  (let ((string-list (filter (lambda (x) (not (string= "" x)))
                             (split-string string "\n"))))
    (insert (car (last string-list))))
  )

(defun filter (pred xl)
  (let ((xls nil))
    (dolist (x xl)
      (if (funcall pred x)
          (setq xls (cons x xls))))
    (reverse xls)))

(defun insert2 (_ string)
  (insert string))

(require 'url-util)
(defun myfetch (file)
  (interactive "sFile: ")
  (unless (process-status "hoge")
    (let ((proc (make-network-process
                 :name "hoge"
                 :buffer nil
                 :family 'ipv4
                 :host "localhost"
                 :service 3000
                 :nowait nil
                 :coding 'utf-8
                 :filter 'read-sexp
                 :filter-multibyte t
                 :server nil)))
      (process-send-string
       proc (format "GET /query/%s HTTP/1.1\r\n\r\n" (url-hexify-string file))))
    (process-send-string
     (get-process "hoge")
     (format "GET /query/%s HTTP/1.1\r\n\r\n" (url-hexify-string file)))))

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
