SELECT SIRDPCL_DEPT_CODE,f_get_desc_fnc('stvdept',SIRDPCL_DEPT_CODE,30) dept_CODE,f_get_std_id(SIRDPCL_PIDM),f_get_std_name(SIRDPCL_PIDM),spbpers_sex,spbpers_ssn
                  FROM SIRDPCL a,sibinst,spbpers
                 WHERE  
                   SIRDPCL_PIDM=SIBINST_PIDM
                   and spbpers_pidm= SIRDPCL_PIDM  
                       and  SIRDPCL_TERM_CODE_EFF =
                           (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                              FROM SIRDPCL
                             WHERE SIRDPCL_PIDM = a.SIRDPCL_pidm)
                            -- and (SIRDPCL_DEPT_CODE like '41__' or SIRDPCL_DEPT_CODE='1705')
                           -- and f_get_desc_fnc('stvdept',SIRDPCL_DEPT_CODE,30) like '%Õ«”»%'
                           -- and  SIRDPCL_coll_CODE   in ('41','17','18','42','19')
                           and SIRDPCL_DEPT_CODE='3205'
                             and  SIBINST_FCST_CODE='‰'
                             and SIBINST_TERM_CODE_EFF=(select max(SIBINST_TERM_CODE_EFF) from SIBINST where    SIRDPCL_PIDM=SIBINST_PIDM  )
                             order by 1