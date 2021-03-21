/* Formatted on 8/13/2020 10:12:07 PM (QP5 v5.360) */
SELECT *
  FROM (  SELECT DISTINCT
                 SHRLGPA_PIDM
                     PIDM,
                 f_get_std_id (SHRLGPA_PIDM)
                     "����� �������",
                 f_get_std_name (SHRLGPA_PIDM)
                     "��� ������",
                 SHRTTRM_TERM_CODE
                     "����� �������",
                 f_get_desc_fnc ('STVASTD', SHRTTRM_ASTD_CODE_END_OF_TERM, 60)
                     "����� ���������",
                 SHRTTRM_ASTD_CODE_END_OF_TERM " ��� �����",
                 ROUND (SHRLGPA_GPA, 2) "������ ��������",
                 SHRLGPA_HOURS_ATTEMPTED "� ������" ,
                     SHRLGPA_HOURS_EARNED "� ������",
                 SHRLGPA_GPA_HOURS "� ����",
                 SHRLGPA_HOURS_PASSED "� ������",
                 SHRLGPA_QUALITY_POINTS "������"
            FROM shrttrm, SHRLGPA
           WHERE     SHRLGPA_PIDM = shrttrm_PIDM
                 AND SHRLGPA_GPA_TYPE_IND = 'O'
                 AND SHRTTRM_TERM_CODE = '144030'
                 AND SHRLGPA_PIDM IN
                         (SELECT SFRSTCR_PIDM
                            FROM SFRSTCR
                           WHERE     SFRSTCR_TERM_CODE = '143820'
                                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                                 AND SFRSTCR_CRN = '27361')
        ORDER BY 1, 2 ASC)
 WHERE "����� �������" =
       (SELECT MAX (SHRTTRM_TERM_CODE)
          FROM SHRTTRM
         WHERE SHRTTRM_PIDM = PIDM AND SHRTTRM_TERM_CODE <= '144030')