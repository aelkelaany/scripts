  SELECT SMBPGEN_PROGRAM,
         SMRPRLE_PROGRAM_DESC,
         SMBPGEN_REQ_CREDITS_OVERALL,
         SMBPGEN_REQ_COURSES_OVERALL,
         SMRPAAP_AREA_PRIORITY,
         SMRACAA_AREA,
         SMRALIB_area_desc,
         SMBPGEN_TERM_CODE_EFF,
         SMRPAAP_AREA,
         SMBAGEN_REQ_CREDITS_OVERALL,
         SMBAGEN_REQ_COURSES_OVERALL,
         SMRACAA_RULE,
         SMRACAA_SUBJ_CODE,
         SMRACAA_CRSE_NUMB_LOW,
         (SELECT a.scbcrse_title
            FROM scbcrse a
           WHERE     a.scbcrse_subj_code = SMRACAA_SUBJ_CODE
                 AND a.scbcrse_crse_numb = SMRACAA_CRSE_NUMB_LOW
                 AND SCBCRSE_EFF_TERM =
                        (SELECT MAX (SCBCRSE_EFF_TERM)
                           FROM scbcrse
                          WHERE     scbcrse_subj_code = SMRACAA_SUBJ_CODE
                                AND scbcrse_crse_numb = SMRACAA_CRSE_NUMB_LOW
                                AND SCBCRSE_EFF_TERM <= '143310'))
            title,
         SMRACAA_RULE,
         SMRACAA_TERM_CODE_EFF
    FROM smbpgen a,
         smrpaap,
         smracaa,
         SMBAGEN,
         SMRALIB,
         SMRPRLE
   WHERE     SMBPGEN_PROGRAM || SMBPGEN_TERM_CODE_EFF =
                SMRPAAP_PROGRAM || SMRPAAP_TERM_CODE_EFF
         AND SMRPRLE.SMRPRLE_PROGRAM = SMBPGEN_PROGRAM
         AND SMBAGEN_AREA || SMBAGEN_TERM_CODE_EFF =
                SMRPAAP_AREA || SMRPAAP_TERM_CODE_EFF
         AND SMRPAAP_AREA || SMRPAAP_TERM_CODE_EFF =
                SMRACAA_AREA || SMRACAA_TERM_CODE_EFF
         AND SMRALIB_area = SMBAGEN_AREA
         AND SMBPGEN_TERM_CODE_EFF =
                (SELECT MAX (SMBPGEN_TERM_CODE_EFF)
                   FROM smbpgen
                  WHERE     SMBPGEN_TERM_CODE_EFF <= :eff_term
                        AND SMBPGEN_PROGRAM = a.SMBPGEN_PROGRAM)
                        and SMBPGEN_PROGRAM=:prog
                        
                        union 
                         SELECT '',
         '',
         null,
         null,
         null,
         SMRARUL_area,
         null,
         null,
         null,
         null,
         null,
         SMRARUL_KEY_RULE,
         SMRARUL_SUBJ_CODE,
         SMRARUL_CRSE_NUMB_LOW,
         (SELECT a.scbcrse_title
            FROM scbcrse a
           WHERE     a.scbcrse_subj_code = SMRARUL_SUBJ_CODE
                 AND a.scbcrse_crse_numb = SMRARUL_CRSE_NUMB_LOW
                 AND SCBCRSE_EFF_TERM =
                        (SELECT MAX (SCBCRSE_EFF_TERM)
                           FROM scbcrse
                          WHERE     scbcrse_subj_code = SMRARUL_SUBJ_CODE
                                AND scbcrse_crse_numb = SMRARUL_CRSE_NUMB_LOW
                                AND SCBCRSE_EFF_TERM <=:eff_term))
            title,
         null,
         null
         from 
        SMRARUL 
        where (SMRARUL_KEY_RULE,SMRARUL_AREA) in (select SMRACAA_RULE,SMRACAA_AREA from SMRACAA
        where  SMRACAA_AREA in (select SMRPAAP_AREA from SMRPAAP where SMRPAAP_program=:prog
        and SMRACAA_TERM_CODE_EFF=:eff_term)
        )
        and SMRARUL_TERM_CODE_EFF=:eff_term
ORDER BY SMBPGEN_PROGRAM,SMRACAA_AREA ,
         SMRALIB_AREA_DESC,
         SMRPAAP_AREA_PRIORITY,
         SMRACAA_SUBJ_CODE,
         SMRACAA_CRSE_NUMB_LOW DESC
         
         