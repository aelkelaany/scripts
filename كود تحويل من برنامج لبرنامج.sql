/* Formatted on 1/8/2020 12:04:12 PM (QP5 v5.227.12220.39754) */
INSERT INTO TRANSFER_STUDENT_PROGRAM (PIDM_CD,
                                      PROGRAM_CD,
                                      DEPT_CODE,
                                      MAJOR_CODE,
                                      NOTES)
   SELECT DISTINCT SGBSTDN_PIDM PIDM_CD,
                   '2-1710-1433',
                   '1710',
                   '1710',
                   NULL
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF =
                 (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                    FROM SGBSTDN
                   WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                         AND SGBSTDN_TERM_CODE_EFF <= '144020')
          AND sgbstdn_program_1 = '2-1726-1433';

INSERT INTO TRANSFER_STUDENT_PROGRAM (PIDM_CD,
                                      PROGRAM_CD,
                                      DEPT_CODE,
                                      MAJOR_CODE,
                                      NOTES)
   SELECT DISTINCT SGBSTDN_PIDM PIDM_CD,
                   '2-1711-1433',
                   '1706',
                   '1706',
                   NULL
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF =
                 (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                    FROM SGBSTDN
                   WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                         AND SGBSTDN_TERM_CODE_EFF <= '144020')
          AND sgbstdn_program_1 = '2-1716-1433';
          
          
          exec ITRANSFER_PROC ('144020') ;
          
          select f_get_std_id(PIDM_CD) ,a.* from TRANSFER_STUDENT_PROGRAM a
          
          update request_master set request_status='C'
          where object_code='WF_GRADE_APPROVAL'
          and request_status='P'