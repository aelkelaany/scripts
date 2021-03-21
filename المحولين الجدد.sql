select DISTINCT f_get_std_id(sorlfos_pidm) ,f_get_std_name(sorlfos_pidm)  , sorlfos_pidm ,SORLFOS_MAJR_CODE ,STVMAJR_DESC ,
from sorlfos ,STVMAJR 
where SORLFOS_USER_ID=USER
AND SORLFOS_DATA_ORIGIN='BannerIT'
AND TO_CHAR(SORLFOS_ACTIVITY_DATE,'YYYY')='2019'
AND   SORLFOS_CSTS_CODE = 'INPROGRESS' 
AND SORLFOS_CACT_CODE = 'ACTIVE'
AND STVMAJR_CODE=SORLFOS_MAJR_CODE
ORDER BY SORLFOS_MAJR_CODE