SELECT F_GET_STD_NAME(A.SGBSTDN_PIDM),F_GET_STD_ID(A.SGBSTDN_PIDM) ,'1601' FROM SGBSTDN  A
WHERE A.SGBSTDN_TERM_CODE_EFF =(SELECT MAX(SGBSTDN_TERM_CODE_EFF) FROM SGBSTDN
WHERE SGBSTDN_PIDM=A.SGBSTDN_PIDM
and SGBSTDN_TERM_CODE_EFF<='144010'
 )
AND SGBSTDN_STST_CODE='AS'
AND A.SGBSTDN_STYP_CODE ='�'
AND SGBSTDN_COLL_CODE_1='16'
AND SGBSTDN_DEPT_CODE='1601'
AND SUBSTR(F_GET_STD_ID(A.SGBSTDN_PIDM),1,3)='438'
AND ROWNUM<5  
union
SELECT F_GET_STD_NAME(A.SGBSTDN_PIDM),F_GET_STD_ID(A.SGBSTDN_PIDM) ,'1602' FROM SGBSTDN  A
WHERE A.SGBSTDN_TERM_CODE_EFF =(SELECT MAX(SGBSTDN_TERM_CODE_EFF) FROM SGBSTDN
WHERE SGBSTDN_PIDM=A.SGBSTDN_PIDM
and SGBSTDN_TERM_CODE_EFF<='144010'
 )
AND SGBSTDN_STST_CODE='AS'
AND SGBSTDN_COLL_CODE_1='16'
AND SGBSTDN_DEPT_CODE='1602'
AND SUBSTR(F_GET_STD_ID(A.SGBSTDN_PIDM),1,3)='438'
AND ROWNUM<5  
 
UNION
SELECT F_GET_STD_NAME(A.SGBSTDN_PIDM),F_GET_STD_ID(A.SGBSTDN_PIDM) ,'1603' FROM SGBSTDN  A
WHERE A.SGBSTDN_TERM_CODE_EFF =(SELECT MAX(SGBSTDN_TERM_CODE_EFF) FROM SGBSTDN
WHERE SGBSTDN_PIDM=A.SGBSTDN_PIDM
and SGBSTDN_TERM_CODE_EFF<='144010'
 )
AND SGBSTDN_STST_CODE='AS'
AND SGBSTDN_COLL_CODE_1='16'
AND SGBSTDN_DEPT_CODE='1603'
AND SUBSTR(F_GET_STD_ID(A.SGBSTDN_PIDM),1,3)='438'
AND ROWNUM<5  
union
SELECT F_GET_STD_NAME(A.SGBSTDN_PIDM),F_GET_STD_ID(A.SGBSTDN_PIDM) ,'1604' FROM SGBSTDN  A
WHERE A.SGBSTDN_TERM_CODE_EFF =(SELECT MAX(SGBSTDN_TERM_CODE_EFF) FROM SGBSTDN
WHERE SGBSTDN_PIDM=A.SGBSTDN_PIDM
and SGBSTDN_TERM_CODE_EFF<='144010'
 )
AND SGBSTDN_STST_CODE='AS'
AND SGBSTDN_COLL_CODE_1='16'
AND SGBSTDN_DEPT_CODE='1604'
AND SUBSTR(F_GET_STD_ID(A.SGBSTDN_PIDM),1,3)='438'
AND ROWNUM<5  

order by 3