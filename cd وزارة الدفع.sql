
 select * from 
 ( SELECT COL01,
         COL02,
         COL03,
         COL04,
         COL05,
         COL06,
         COL07,
         f_get_desc_fnc ('stvcoll', c.SHRDGMR_coll_code_1, 30)     college,
         f_get_desc_fnc ('stvmajr', c.SHRDGMR_majr_code_1, 30)     Major,  '4   -'||to_char(round(SHRLGPA_GPA,2),'0.00')CGPA 
    FROM bu_dev.tmp_tbl_kilany a, spbpers b, shrdgmr c,shrlgpa
   WHERE     b.spbpers_ssn = a.col02
         AND b.spbpers_pidm = c.shrdgmr_pidm 
         AND c.SHRDGMR_SEQ_NO  =   (SELECT MAX (SHRDGMR_SEQ_NO)
                                          FROM SHRDGMR
                                         WHERE  SHRDGMR_pidm = c.SHRDGMR_pidm 
                                          )  
         AND SHRDGMR_LEVL_CODE = 'Ã„'
         and SHRLGPA_PIDM =b.spbpers_pidm
         and SHRLGPA_GPA_TYPE_IND='O'
union
select COL01,
         COL02,
         COL03,
         COL04,
         COL05,
         COL06,
         COL07,'null','null','' 
from BU_DEV.TMP_TBL_KILANY
WHERE    
    not exists (select  '1' from  spbpers where spbpers_ssn=col02  )
   
   order by 1 )
   where col07<>cgpa