select COUNT(1) from sorlfos 
where exists (select '1' from   sgbstdn A
WHERE
sgbstdn_pidm=sorlfos_pidm 
 and SGBSTDN_CMJR_RULE_1_1=SORLFOS_LFOS_RULE
and sgbstdn_DEPT_CODE||sgbstdn_MAJR_CODE_1 !=SORLFOS_DEPT_CODE||SORLFOS_MAJR_CODE 
and A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                                 --  and sgbstdn_program_1='1F31CHEM38'
                                           and sgbstdn_program_1 not in ('1F41CS38','1F17FASH38')
                                         and sgbstdn_stst_code   in ('AS','ãæ','ãÚ' )
)
AND SORLFOS_CURRENT_CDE = 'Y' ;

 ---------
 select    distinct   SORLFOS_MAJR_CODE||SORLFOS_DEPT_CODE 
 from SORLFOS 
 where SORLFOS_LFOS_RULE = 826 
 and   exists (select '1' from sgbstdn a where 
 sgbstdn_pidm=sorlfos_pidm 
 and A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                                         and sgbstdn_program_1='1F31CHEM38'
                                        )
 
 ;
 
 update SORLFOS set   SORLFOS_MAJR_CODE='3102',SORLFOS_DEPT_CODE='3102'  
 where 
 SORLFOS_LFOS_RULE = 826
 and  SORLFOS_MAJR_CODE||SORLFOS_DEPT_CODE ='PLEG1206'  ;