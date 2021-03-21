/* Formatted on 5/2/2020 5:19:46 PM (QP5 v5.227.12220.39754) */
  SELECT DISTINCT
         f_get_std_id (sfrstcr_pidm) id,
         f_get_std_name (sfrstcr_pidm) name,
         /* f_get_desc_fnc ('STVSTST', SGBSTDN_STST_CODE, 60)
             AS "���� ������",*/
         f_get_desc_fnc ('STVSTYP', SGBSTDN_STYP_CODE, 60)
            AS "��� �������",
         f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) AS "������",
         f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60) AS "�����",
         f_get_desc_fnc ('STVCAMP', sgbstdn_camp_code, 60) AS "�����",
         f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60) AS "������",
         SSBSECT_CRN AS "����� ������� ",
         SCBCRSE_TITLE AS "��� ������",
         NVL (SFRSTCR_GRDE_CODE_MID, '�� ��� �����')
            AS " ���� ����� "
    FROM sfrstcr,
         sgbstdn,
         SSBSECT,
         SCBCRSE
   WHERE     sgbstdn_pidm = sfrstcr_pidm
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM sgbstdn
                                       WHERE sgbstdn_pidm = sfrstcr_pidm)
         AND sfrstcr_term_code = '144020'
         AND sfrstcr_rsts_code IN ('RE', 'RW')
         AND SGBSTDN_STST_CODE IN ('AS')
         AND F_GET_LEVEL(sgbstdn_pidm)='��'
         AND SSBSECT_TERM_CODE = '144020'
         AND SSBSECT_CRN = SFRSTCR_CRN
         AND SSBSECT_GRADABLE_IND = 'Y'
         AND SSBSECT_SUBJ_CODE || SSBSECT_CRSE_NUMB =
                SCBCRSE_SUBJ_CODE || SCBCRSE_CRSE_NUMB
         AND SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE  
                           SCBCRSE_SUBJ_CODE || SCBCRSE_CRSE_NUMB=SSBSECT_SUBJ_CODE || SSBSECT_CRSE_NUMB )
         AND EXISTS
                (SELECT 'Y'
                   FROM SFRSTCR
                  WHERE     SFRSTCR_TERM_CODE = '144020'
                        AND SFRSTCR_PIDM = SGBSTDN_PIDM
                        AND sfrstcr_rsts_code IN ('RE', 'RW')
                        AND SFRSTCR_GRDE_CODE_MID = 0)
ORDER BY 6,
         4,
         5,
         3 DESC