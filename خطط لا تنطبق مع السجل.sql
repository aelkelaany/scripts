  SELECT DISTINCT *
    FROM (  SELECT F_GET_STD_NAME (A.SGBSTDN_PIDM),
                   F_GET_STD_ID (A.SGBSTDN_PIDM) AS "����� �������",
                   SGBSTDN_PROGRAM_1 "��� ��������", SMRPRLE_PROGRAM_DESC as "��� ��������" ,SGBSTDN_COLL_CODE_1 as "��� ������",f_get_desc_fnc('STVCOLL' ,SGBSTDN_COLL_CODE_1  , 30  ) AS "������" ,  
                   SUM (SHRTGPA_HOURS_EARNED) AS "����� �����",
                   SMBPOGN_ACT_CREDITS_OVERALL AS "����� ��������",
                   SMBPOGN_REQUEST_NO AS "��� �����",
                    SUM (SHRTGPA_HOURS_EARNED) - SMBPOGN_ACT_CREDITS_OVERALL 
                      AS "��� �������"
              FROM SGBSTDN A, SHRTGPA, SMBPOGN ,smrprle
             WHERE     A.SGBSTDN_TERM_CODE_EFF =
                          (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                             FROM SGBSTDN
                            WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                  AND SGBSTDN_TERM_CODE_EFF <= '144010')
                   AND SGBSTDN_STST_CODE = 'AS'
                   AND A.SGBSTDN_STYP_CODE = '�'
                   AND a.SGBSTDN_DEGC_CODE_1 = '��'
                   AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) = '438'
                   AND SHRTGPA_pidm = sgbstdn_pidm
                   -- AND SGBSTDN_PROGRAM_1 NOT LIKE '%1433'
                   AND SMBPOGN_pidm = sgbstdn_pidm
                   AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                               FROM SMBPOGN
                                              WHERE SMBPOGN_pidm = sgbstdn_pidm)
                   AND SMBPOGN_PROGRAM = SGBSTDN_PROGRAM_1
                   and SMRPRLE_PROGRAM=SGBSTDN_PROGRAM_1
                    
          GROUP BY SGBSTDN_PROGRAM_1,
                   sgbstdn_pidm,
                   SMBPOGN_ACT_CREDITS_OVERALL,
                   SMBPOGN_REQUEST_NO ,SGBSTDN_COLL_CODE_1,SMRPRLE_PROGRAM_DESC)
                  where "����� �����">0 
                  and  ("��� �������" /"����� �����")*100 >10
  
ORDER BY 3;