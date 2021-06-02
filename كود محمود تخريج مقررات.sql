/* Formatted on 06/05/2021 13:47:00 (QP5 v5.227.12220.39754) */
SELECT DISTINCT
       SGBSTDN_PIDM AS CODE_PIDM,
       SPBPERS_SSN AS "����� ������",
       SPRIDEN_ID AS "����� �������",
       SPRIDEN_FIRST_NAME || ' ' || SPRIDEN_MI || ' ' || SPRIDEN_LAST_NAME
          AS "�����",
       SGBSTDN_TERM_CODE_ADMIT AS "��� ������",
       SHRTCKG_TERM AS "���-������",
       DECODE (SPBPERS_SEX,
               'M', '���',
               'F', '����',
               '��� ����')
          AS "�����",
       STVDEGC_DESC AS "������ �������",
       STVSTST_DESC AS "���� ������",
       STVSTYP_DESC AS "��� ������",
       STVCOLL_DESC AS "��� ������",
       STVMAJR_DESC AS "������",
       SMRPRLE_PROGRAM_DESC AS "��� ��������",
       SGBSTDN_PROGRAM_1 AS "������-����",
       SMBPOGN_PROGRAM AS "������-������",
       SGBSTDN_TERM_CODE_CTLG_1 AS "��� ����-����",
       SMBPOGN_TERM_CODE_CATLG AS "��� ����-������",
       DECODE (SMBPOGN_MET_IND,
               'Y', '���',
               'N', '��',
               '��� ����')
          AS "���� ������",
       SMBPOGN_REQ_CREDITS_OVERALL AS "����-����",
       SMBPOGN_ACT_CREDITS_OVERALL AS "����-�����",
       SHRTGPA_HOURS AS "����-���",
       SMBPOGN_REQ_COURSES_OVERALL AS "����-����",
       SMBPOGN_ACT_COURSES_OVERALL AS "����-�����",
       SHRTGPA_GPA AS "������",
       STVASTD_DESC AS "�������"
  FROM SGBSTDN SGB,
       SPBPERS,
       SPRIDEN,
       SMBPOGN SMB,
       STVDEGC,
       STVSTST,
       STVSTYP,
       STVCOLL,
       STVMAJR,
       SMRPRLE,
       SHRTTRM SHR,
       STVASTD,
       (  SELECT SHRTGPA_PIDM,
                 ROUND (
                    DECODE (
                       SUM (SHRTGPA_GPA_HOURS),
                       0, 0,
                       SUM (SHRTGPA_QUALITY_POINTS) / SUM (SHRTGPA_GPA_HOURS)),
                    2)
                    SHRTGPA_GPA,
                 SUM (SHRTGPA_HOURS_EARNED) SHRTGPA_HOURS
            FROM SHRTGPA
        GROUP BY SHRTGPA_PIDM),
       (  SELECT DISTINCT SHRTCKG_PIDM, MAX (SHRTCKG_TERM_CODE) SHRTCKG_TERM
            FROM SHRTCKG
        GROUP BY SHRTCKG_PIDM)
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SGB.SGBSTDN_PIDM)
       AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                   FROM SMBPOGN
                                  WHERE SMBPOGN_PIDM = SMB.SMBPOGN_PIDM)
       AND SHRTTRM_TERM_CODE =
              (SELECT MAX (SHRTTRM_TERM_CODE)
                 FROM SHRTTRM
                WHERE     SHRTTRM_PIDM = SHR.SHRTTRM_PIDM
                      AND SHRTTRM_ASTD_CODE_END_OF_TERM IS NOT NULL)
       AND SGBSTDN_PIDM = SPBPERS_PIDM(+)
       AND SGBSTDN_PIDM = SPRIDEN_PIDM(+)
       AND SPRIDEN_CHANGE_IND(+) IS NULL
       AND SGBSTDN_PIDM = SMBPOGN_PIDM(+)
       AND SGBSTDN_PIDM = SHRTGPA_PIDM(+)
       AND SGBSTDN_PIDM = SHRTCKG_PIDM(+)
       AND SGBSTDN_PIDM = SHRTTRM_PIDM(+)
       AND SGBSTDN_DEGC_CODE_1 = STVDEGC_CODE(+)
       AND SGBSTDN_STST_CODE = STVSTST_CODE(+)
       AND SGBSTDN_STYP_CODE = STVSTYP_CODE(+)
       AND SGBSTDN_COLL_CODE_1 = STVCOLL_CODE(+)
       AND SGBSTDN_MAJR_CODE_1 = STVMAJR_CODE(+)
       AND SGBSTDN_PROGRAM_1 = SMRPRLE_PROGRAM(+)
       AND SHRTTRM_ASTD_CODE_END_OF_TERM = STVASTD_CODE(+)
       AND SGBSTDN_STST_CODE IN ('��')
          --    ('AS', '��', '��', '��', '��', '��', '��', '��')
       AND SGBSTDN_DEGC_CODE_1 IN ('�� �', '��', '000000', '��')
       AND SGBSTDN_dept_CODE ='3201'-- IN ('14', '25', '33', '55')
       AND sgbstdn_styp_code = '�'
       AND SMBPOGN_MET_IND = 'Y'
      -- AND SMBPOGN_REQ_COURSES_OVERALL = SMBPOGN_ACT_COURSES_OVERALL   
       --AND SHRTGPA_GPA >= 1
        
       AND EXISTS
              (SELECT 1
                  FROM SATURN.SMRDOCN A  ,SHRGRDE

 where  SMRDOCN_PIDM=sgbstdn_pidm
and SMRDOCN_REQUEST_NO=SMBPOGN_REQUEST_NO
and
SMRDOCN_GRDE_CODE=SHRGRDE_CODE
 and SHRGRDE_LEVL_CODE=SMRDOCN_LEVL_CODE
 and SHRGRDE_TERM_CODE_EFFECTIVE=(select max(SHRGRDE_TERM_CODE_EFFECTIVE)
 from SHRGRDE where SHRGRDE_CODE=SHRGRDE_CODE
 and SHRGRDE_LEVL_CODE=SMRDOCN_LEVL_CODE
 and SHRGRDE_TERM_CODE_EFFECTIVE<=SMRDOCN_TERM_CODE )
and SHRGRDE_PASSED_IND='Y'
and SMRDOCN_CREDIT_HOURS>0
and not exists (select '1' from smrdous
where
smrdous_request_no=SMRDOCN_REQUEST_NO
and smrdous_pidm=SMRDOCN_PIDM
and SMRDOUS_SUBJ_CODE|| SMRDOUS_CRSE_NUMB=SMRDOCN_SUBJ_CODE||SMRDOCN_CRSE_NUMB) )
ORDER BY STVCOLL_DESC,
         STVMAJR_DESC,
         SGBSTDN_PROGRAM_1,
         SHRTCKG_TERM ASC;