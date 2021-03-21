select NVL(Round(SHRLGPA_GPA,2), 0) ,SHRLGPA_PIDM ,f_get_std_id(SHRLGPA_PIDM)
       
       from   SHRLGPA
       where  SHRLGPA_PIDM not in (SELECT DISTINCT SHRTCKG_PIDM
FROM SHRTCKG O, SHRTCKL
WHERE SHRTCKL_PIDM = SHRTCKG_PIDM
AND SHRTCKL_TERM_CODE = SHRTCKG_TERM_CODE
AND SHRTCKL_TCKN_SEQ_NO = SHRTCKG_TCKN_SEQ_NO
AND SHRTCKL_LEVL_CODE = 'Ìã'
 
AND SHRTCKG_GRDE_CODE_FINAL IN ('åÜ', 'Í','å')
AND SHRTCKG_SEQ_NO = (SELECT MAX(SHRTCKG_SEQ_NO) 
                      FROM SHRTCKG I 
                      WHERE I.SHRTCKG_PIDM = O.SHRTCKG_PIDM 
                      AND I.SHRTCKG_TERM_CODE = O.SHRTCKG_TERM_CODE 
                      AND I.SHRTCKG_TCKN_SEQ_NO = O.SHRTCKG_TCKN_SEQ_NO)
              and SHRLGPA_LEVL_CODE = 'Ìã'
              and SHRLGPA_GPA_TYPE_IND='O')
              and NVL(Round(SHRLGPA_GPA,2), 0)>=3.25 AND NVL(Round(SHRLGPA_GPA,2), 0)<3.75  -- ãÑÊÈÉ ÔÑÝ ÇáËÇäíÉ
            --  and NVL(Round(SHRLGPA_GPA,2), 0)>=3.75 AND NVL(Round(SHRLGPA_GPA,2), 0)<5 --  ÇáÇæáì
              and SHRLGPA_PIDM in (select shrdgmr_pidm from shrdgmr where SHRDGMR_DEGS_CODE='ÎÌ') 
             order by 1 desc 

