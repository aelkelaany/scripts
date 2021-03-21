 SELECT ROWNUM SEQ,
                SMRARUL_SUBJ_CODE || SMRARUL_CRSE_NUMB_LOW CRSE,
                SCBCRSE_TITLE TITLE,
                DECODE (SCBCRSE_CREDIT_HR_low,
                  0, SCBCRSE_CREDIT_HR_HIGH,
                  SCBCRSE_CREDIT_HR_LOW)
                   CRD_HR ,(select 'Y' from smrdous where smrdous_pidm=pidm and   smrdous_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                            FROM SMBPOGN
                                           WHERE SMBPOGN_PIDM = PIDM) 
                                           and SMRDOUS_SUBJ_CODE =
                                           and SMRDOUS_CRSE_NUMB=
                                           )
                                           
           FROM SMRARUL r, SCBCRSE
          WHERE     SCBCRSE_SUBJ_CODE = SMRARUL_SUBJ_CODE
                AND SCBCRSE_CRSE_NUMB = SMRARUL_CRSE_NUMB_LOW
                AND SCBCRSE_EFF_TERM =
                       (SELECT MAX (SCBCRSE_EFF_TERM)
                          FROM scbcrse
                         WHERE     SCBCRSE_SUBJ_CODE = SMRARUL_SUBJ_CODE
                               AND SCBCRSE_CRSE_NUMB = SMRARUL_CRSE_NUMB_LOW)
                AND SMRARUL_KEY_RULE = P_KEY_RULE
                AND SMRARUL_AREA = P_AREA
                AND SMRARUL_TERM_CODE_EFF = P_TERM_CODE_EFF