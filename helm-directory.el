(defvar helm-kyokenro-directory
      '(("2015年度"		. "s:/原田フォルダ/2015年度")
	("2016年度"		. "s:/原田フォルダ/2016年度")
	("月別資料"		. "s:/原田フォルダ/2016年度/月別資料")
	("さくら通信"		. "s:/馬場フォルダ/醍醐さくら通信/2016年")
	("組合員名簿"		. "s:/馬場フォルダ/組合員名簿")
	("山口フォルダ"		. "s:/山口フォルダ")
	("原田フォルダ"		. "s:/原田フォルダ")
	("馬場フォルダ"		. "s:/馬場フォルダ")
	("支部公開フォルダ"	. "\\\\Kkrfsv01\\支部公開フォルダ")
	("専門部資料"		. "\\\\Kkrfsv01\\支部公開フォルダ\\専門部資料")
	("国保組合"		. "\\\\Kkrfsv01\\支部公開フォルダ\\国保組合関係資料")
	("支部決算書"		. "s:/原田フォルダ/支部決算書")
	("建設業許可"		. "s:/建設業許可")
	("全労済"		. "s:/原田フォルダ/全労済")
	("建退共"		. "s:/原田フォルダ/建退共")
	("分会関係"		. "s:/原田フォルダ/分会関係")
	("分会・班長会議関係"	. "s:/山口フォルダ/用紙書式/分会・班長会議関係")
	("申請関係"		. "s:/原田フォルダ/申請関係")
	("組合アルバム"		. "s:/馬場フォルダ/組合アルバム")))


(defvar helm-kyokenro-file
  '(("組合員名簿.xlsm"		. "s:/馬場フォルダ/組合員名簿/組合員名簿.xlsm")
    ("全労済給付.醍醐.xlsm"	. "s:/原田フォルダ/全労済/全労済給付.醍醐.xlsm")
    ("日野班長連絡表.xlsx"	. "s:/原田フォルダ/分会関係/日野分会/16年度/16日野班長連絡表.xlsx")
    ("建退共受付簿.xlsm"	        . "s:/原田フォルダ/建退共/建退共受付簿.醍醐ver.xlsm")
    ("一般会計月別決算.xlsx"	. "s:/原田フォルダ/支部決算書/2016年度支部決算書/一般会計月別決算：16年度.xlsx")
    ("特別会計月別決算.xlsx"	. "s:/原田フォルダ/支部決算書/2016年度支部決算書/特別会計月別決算：16年度.xlsx")
    ("国保給付.xlsx"		. "s:/原田フォルダ/申請関係/国保給付.xlsx")
    ("総合共済.xlsx"		. "s:/原田フォルダ/申請関係/総合共済.xlsx")
    ("分会執行委員会報告.docx"	. "s:/山口フォルダ/用紙書式/分会・班長会議関係/分会執行委員会報告.docx")
    ("残名簿.xlsm"		. "s:/伊東フォルダ/残名簿/石田-小栗栖残名簿六月.xlsm")
    ("出勤簿.xlsx"		. "s:/伊東フォルダ/2016年度　出勤簿（原紙） (2).xlsx")
    ("拡大月間用訪問名簿.xlsb"    . "s:/原田フォルダ/2016年度/拡大月間/拡大月間用訪問名簿.xlsb")
    ("加入手続状況一覧.xlsx"      . "s:/馬場フォルダ/新加入/2016年度加入手続状況一覧.xlsx")
    ("現勢報告書.xlsx"           . "s:/原田フォルダ/2016年度/年間資料/2016年度　現勢報告書.xlsx")
    ("組合費納入状況.xlsx"       . "s:/原田フォルダ/2016年度/年間資料/2016年度分会別組合費納入状況.xlsx")
    ("対象者名簿.xlsm"           . "s:/原田フォルダ/2016年度/年間資料/2016年度拡大対象者名簿.xlsm")
    ("拡大進行状況.xlsx"         . "s:/原田フォルダ/2016年度/年間資料/2016年度月別拡大進行状況.xlsx")
    ))

(defvar helm-source-kyokenro-directory
  (helm-build-sync-source "Open Directory"
    :candidates helm-kyokenro-directory
    :action     'find-file
    :migemo     t))

(defvar helm-source-kyokenro-file
  (helm-build-sync-source "Open File"
    :candidates helm-kyokenro-file
    :action     (lambda (file) (w32-shell-execute "open" file nil 1))
    :migemo     t))

(defun helm-open-directory ()
  (interactive)
  (helm :sources '(helm-source-kyokenro-directory
		   helm-source-kyokenro-file)
        :buffer "*helm directory*"))

