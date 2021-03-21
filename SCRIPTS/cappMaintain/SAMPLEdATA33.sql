/* Formatted on 14/02/2021 12:19:48 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM (SELECT f_get_std_id (GLBEXTR_KEY) AS "«·—ﬁ„ «·Ã«„⁄Ì",
                 GLBEXTR_KEY,
                 f_get_std_name (GLBEXTR_KEY) AS "«·«”„",
                 NEW_COMP.SMBPOGN_REQUEST_NO "REQUEST NEW",
                 NEW_COMP.SMBPOGN_ACTIVITY_DATE AS "NEW DATE",
                 NEW_COMP.SMBPOGN_PROGRAM AS "«·»—‰«„Ã",
                 NEW_COMP.SMBPOGN_ACT_CREDITS_OVERALL
                    AS "«·”«⁄«  »⁄œ",
                 OLD_COMP.SMBPOGN_REQUEST_NO old_req#,
                 OLD_COMP.SMBPOGN_ACTIVITY_DATE AS "OLD DATE",
                 OLD_COMP.SMBPOGN_PROGRAM old_prog,
                 OLD_COMP.SMBPOGN_ACT_CREDITS_OVERALL
                    AS "«·”«⁄«  ﬁ»·",
                 OLD_COMP.SMBPOGN_COLL_CODE AS "«·ﬂ·Ì…",
                 NEW_COMP.SMBPOGN_ACT_COURSES_OVERALL + 2 newCoursesCount,
                 old_COMP.SMBPOGN_ACT_COURSES_OVERALL oldCoursesCount,
                 ROW_NUMBER ()
                 OVER (PARTITION BY NEW_COMP.SMBPOGN_PROGRAM
                       ORDER BY GLBEXTR_KEY NULLS LAST)
                    RANK
            FROM GLBEXTR, SMBPOGN NEW_COMP, SMBPOGN OLD_COMP
           WHERE     GLBEXTR_SELECTION = 'CAPP_STD_IS33'
                  -- AND F_GET_STATUS (GLBEXTR_KEY) = 'AS'
                 AND NEW_COMP.SMBPOGN_PIDM = GLBEXTR_KEY
                 AND OLD_COMP.SMBPOGN_PIDM = GLBEXTR_KEY
                 AND NEW_COMP.SMBPOGN_REQUEST_NO =
                        (SELECT MAX (SMBPOGN_REQUEST_NO)
                           FROM SMBPOGN
                          WHERE SMBPOGN_PIDM = NEW_COMP.SMBPOGN_PIDM)
                 AND OLD_COMP.SMBPOGN_REQUEST_NO =
                        (SELECT MAX (SMBPOGN_REQUEST_NO)
                           FROM SMBPOGN
                          WHERE     SMBPOGN_PIDM = OLD_COMP.SMBPOGN_PIDM
                                AND SMBPOGN_ACTIVITY_DATE < SYSDATE - 15 ---15
                                                                        )
--                 AND NEW_COMP.SMBPOGN_ACT_COURSES_OVERALL + 2 < old_COMP.SMBPOGN_ACT_COURSES_OVERALL
--                 AND NEW_COMP.SMBPOGN_ACT_CREDITS_OVERALL <old_COMP.SMBPOGN_ACT_CREDITS_OVERALL
                 AND NEW_COMP.SMBPOGN_REQUEST_NO > old_COMP.SMBPOGN_REQUEST_NO)
ORDER BY 7 DESC;

SELECT f_get_std_id (GLBEXTR_KEY) id,
       f_get_std_name (GLBEXTR_KEY) name,
       GLBEXTR_KEY,
       F_GET_STATUS (GLBEXTR_KEY) ST_STATUS
  FROM GLBEXTR
 WHERE     GLBEXTR_SELECTION = 'CAPP_STD_PHYS33'
       AND F_GET_STATUS (GLBEXTR_KEY) = 'AS';


  SELECT *
    FROM SMRRQCM
   WHERE     SMRRQCM_pidm IN (SELECT GLBEXTR_KEY
                                FROM GLBEXTR
                               WHERE GLBEXTR_SELECTION = 'CAPP_STD_PHYS33')
         AND SMRRQCM_progRam = '1F15ARAB38'
         AND SMRRQCM_TERM_CODE_CTLG_1 = '143810'
         AND SMRRQCM_DETAIL_EXISTS_IND = 'Y'
ORDER BY 1, 2 DESC

--------CAPP_STD_FASH33