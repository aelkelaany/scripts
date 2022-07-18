/* Formatted on 21/12/2021 15:07:48 (QP5 v5.371) */
 --col01>>crn
--col07>>DEPT_MANAGER_ID
--col08>>
--col09>>


INSERT INTO BU_APPS.GRADES_APPROVAL_EXECLUDED_CRN (TERM_CODE,
                                                   CRN,
                                                   DEPT_MANAGER_ID,
                                                   DEPT_MANAGER_PIDM,
                                                   VICE_DEAN_ID,
                                                   VICE_DEAN_PIDM,
                                                   DEAN_ID,
                                                   DEAN_PIDM)
    SELECT DISTINCT '144320',
                    col01,
                    col07,
                    f_get_pidm (col07),
                    col08,
                    f_get_pidm (col08),
                    col09,
                    f_get_pidm (col09)
      FROM BU_DEV.TMP_TBL_KILANY
     WHERE col07 IS NOT NULL;