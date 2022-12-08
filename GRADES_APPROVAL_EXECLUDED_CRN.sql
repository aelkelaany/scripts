/* Formatted on 21/12/2021 15:07:48 (QP5 v5.371) */
 --col01>>crn
--col03>>DEPT_MANAGER_ID
--col03>> vice id 
--col04>> dean id 


INSERT INTO BU_APPS.GRADES_APPROVAL_EXECLUDED_CRN (TERM_CODE,
                                                   CRN,
                                                   DEPT_MANAGER_ID,
                                                   DEPT_MANAGER_PIDM,
                                                   VICE_DEAN_ID,
                                                   VICE_DEAN_PIDM,
                                                   DEAN_ID,
                                                   DEAN_PIDM)
    SELECT DISTINCT '144410',
                    col01,
                    col02,
                    f_get_pidm (col02),
                    col03,
                    f_get_pidm (col03),
                    col04,
                    f_get_pidm (col04)
      FROM BU_DEV.TMP_TBL_KILANY
     WHERE col02 IS NOT NULL;