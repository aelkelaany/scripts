/* Formatted on 5/16/2020 11:29:26 PM (QP5 v5.360) */
insert into SHRTCKG
select  SHRTCKG_PIDM, SHRTCKG_TERM_CODE, SHRTCKG_TCKN_SEQ_NO, 
   SHRTCKG_SEQ_NO  ,SHRTCKG_FINAL_GRDE_SEQ_NO,(SELECT shrgrds_grde_code_substitute
          FROM shrgrde g1, shrgrds
         WHERE     shrgrds_grde_code = shrgrde_code
               AND shrgrds_levl_code = shrgrde_levl_code
               AND shrgrds_term_code_effective = shrgrde_term_code_effective
               AND shrgrds_gmod_code_student = 'Õ'
               AND g1.shrgrde_levl_code = 'Ã„'
               AND g1.shrgrde_numeric_value = precentage
               AND g1.shrgrde_term_code_effective =
                   (SELECT MAX (g2.shrgrde_term_code_effective)
                      FROM shrgrde g2
                     WHERE     g2.shrgrde_code = g1.shrgrde_code
                           AND g2.shrgrde_levl_code = g1.shrgrde_levl_code
                           AND g2.shrgrde_term_code_effective <= '144020')) SHRTCKG_GRDE_CODE_FINAL ,SHRTCKG_GMOD_CODE, SHRTCKG_CREDIT_HOURS, SHRTCKG_GCHG_CODE, 
   SHRTCKG_INCOMPLETE_EXT_DATE, SHRTCKG_FINAL_GRDE_CHG_DATE, SHRTCKG_FINAL_GRDE_CHG_USER, 
   SHRTCKG_ACTIVITY_DATE, SHRTCKG_GCMT_CODE, SHRTCKG_TERM_CODE_GRADE, 
   SHRTCKG_DATA_ORIGIN, SHRTCKG_USER_ID, SHRTCKG_HOURS_ATTEMPTED, 
   SHRTCKG_GRDE_CODE_INCMP_FINAL from 
(SELECT a.SHRTCKG_GRDE_CODE_FINAL precentage,
       SHRTCKN_CRN,
       f_get_std_id (SHRTCKN_PIDM)
           std_id  ,  SHRTCKG_PIDM, SHRTCKG_TERM_CODE, SHRTCKG_TCKN_SEQ_NO, 
   SHRTCKG_SEQ_NO+1 SHRTCKG_SEQ_NO, SHRTCKG_FINAL_GRDE_SEQ_NO, 
   '„' SHRTCKG_GMOD_CODE, SHRTCKG_CREDIT_HOURS, SHRTCKG_GCHG_CODE, 
   SHRTCKG_INCOMPLETE_EXT_DATE, SHRTCKG_FINAL_GRDE_CHG_DATE, SHRTCKG_FINAL_GRDE_CHG_USER, 
   SHRTCKG_ACTIVITY_DATE, SHRTCKG_GCMT_CODE, SHRTCKG_TERM_CODE_GRADE, 
   SHRTCKG_DATA_ORIGIN, SHRTCKG_USER_ID, SHRTCKG_HOURS_ATTEMPTED, 
   SHRTCKG_GRDE_CODE_INCMP_FINAL
        
  FROM shrtckg a, shrtckn
 WHERE     a.SHRTCKG_PIDM = shrtckn_pidm
       AND a.SHRTCKG_TERM_CODE = shrtckn_term_code
       AND SHRTCKN_TERM_CODE = '144020'
       AND a.SHRTCKG_TCKN_SEQ_NO = shrtckn_seq_no
       AND a.SHRTCKG_SEQ_NO =
           (SELECT MAX (SHRTCKG_SEQ_NO)
              FROM shrtckg, shrgrde, shrgrdo
             WHERE     SHRTCKG_PIDM = a.SHRTCKG_PIDM
                   AND SHRTCKG_TERM_CODE = a.SHRTCKG_TERM_CODE
                   AND SHRTCKG_TCKN_SEQ_NO = a.SHRTCKG_TCKN_SEQ_NO
                   AND SHRGRDE_CODE = SHRTCKG_GRDE_CODE_FINAL
                   AND SHRGRDE_LEVL_CODE = 'Ã„'
                   AND SHRGRDO_GRDE_CODE = SHRTCKG_GRDE_CODE_FINAL
                   AND SHRGRDO_LEVL_CODE = 'Ã„'
                   AND SHRGRDO_GMOD_CODE = '„')
                   
                   
                    and (select MAX (SHRTCKG_SEQ_NO)
                    from shrtckg where
                    SHRTCKG_PIDM = a.SHRTCKG_PIDM
                   AND SHRTCKG_TERM_CODE = a.SHRTCKG_TERM_CODE
                   AND SHRTCKG_TCKN_SEQ_NO = a.SHRTCKG_TCKN_SEQ_NO
                   )=1) a;


                             