/* Formatted on 7/8/2020 11:52:29 AM (QP5 v5.360) */
  SELECT                                                                   --,
         DISTINCT
         ssbsect_crn AS "����� �������",
         scbcrse_subj_code||
         scbcrse_crse_numb AS "��� ������",
         scbcrse_title AS "��� ������",
         f_get_desc_fnc ('STVSCHD', SSBSECT_SCHD_CODE, 60)
             AS "��� ������",
         SSBSECT_CREDIT_HRS AS "����� ������",
         DECODE (SSBSECT_GRADABLE_IND,
                 'Y', '���� �������',
                 '��� ���� �������') AS "��� �������",
         GREATEST (NVL (SCBCRSE_CREDIT_HR_LOW, 0),
                   NVL (SCBCRSE_CREDIT_HR_HIGH, 0))
             AS "����� ������"
    ,f_get_desc_fnc ('STVCOLL', scbcrse_coll_code, 60)
         AS "������",
     f_get_desc_fnc ('STVDEPT', scbcrse_dept_code, 60)
         AS "�����",
     ssbsect_max_enrl as "��� ������" ,ssbsect_enrl  as "��� ��������" ,SSBSECT_SEATS_AVAIL  as "������� �������"
    FROM ssbsect, scbcrse
   WHERE     ssbsect_term_code = '144210'
         AND scbcrse_subj_code = ssbsect_subj_code
         AND scbcrse_crse_numb = ssbsect_crse_numb
         AND SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM SCBCRSE
               WHERE     scbcrse_subj_code = ssbsect_subj_code
                     AND scbcrse_crse_numb = ssbsect_crse_numb)
         AND SSBSECT_SSTS_CODE = '�'
         AND EXISTS
                 (SELECT '1'
                    FROM SFRSTCR
                   WHERE     sfrstcr_term_code = ssbsect_term_code
                         AND sfrstcr_crn = ssbsect_crn
                         AND sfrstcr_rsts_code IN ('RE', 'RW')
                         AND SFRSTCR_CREDIT_HR = 0)
         AND GREATEST (NVL (SCBCRSE_CREDIT_HR_LOW, 0),
                       NVL (SCBCRSE_CREDIT_HR_HIGH, 0)) >
             0
ORDER BY 5, 6
--  group by sfrstcr_crn ,scbcrse_coll_code ,scbcrse_dept_code