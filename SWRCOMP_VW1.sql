/* Formatted on 5/13/2020 4:56:53 AM (QP5 v5.227.12220.39754) */
SELECT COMP.*
  FROM (SELECT SMBPOGN_PIDM ST_PIDM,                                ------PROGRAM
               SMBPOGN_REQUEST_NO REQUEST_NO,
               SMBPOGN_PROGRAM PROGRAM_CODE,
               ------------------------------AREA
               SMBAOGN_AREA AREA_CODE,
               ------------------ COURSES
               SMRDORQ_CAA_SEQNO CAA_SEQNO,
               SMRDORQ_MET_IND CRSE_MET_IND,
               SMRDORQ_SUBJ_CODE SUBJ_CODE,
               SMRDORQ_CRSE_NUMB_LOW CRSE_NUMB,
               P.SMRDOUS_CRN CRN,
               P.SMRDOUS_TERM_CODE TERM_CODE,
               P.SMRDOUS_GRDE_CODE GRDE_CODE,
               ADJ.SMRDOUS_SUBJ_CODE || ADJ.SMRDOUS_CRSE_NUMB ADJ_SUBJ
          FROM SMBPOGN PROG,
               SMBAOGN,
               SMRDORQ,
               SMRDOUS P,
               SMRDOUS ADJ
         WHERE     SMBPOGN_REQUEST_NO =
                      (SELECT MAX (SMBPOGN_REQUEST_NO)
                         FROM SMBPOGN
                        WHERE SMBPOGN_PIDM = PROG.SMBPOGN_PIDM)
               AND SMBAOGN_PIDM = SMBPOGN_PIDM
               AND SMBAOGN_REQUEST_NO = SMBPOGN_REQUEST_NO
               AND SMRDORQ_PIDM = SMBPOGN_PIDM
               AND SMRDORQ_REQUEST_NO = SMBPOGN_REQUEST_NO
               AND SMRDORQ_AREA = SMBAOGN_AREA
               AND SMRDORQ_SUBJ_CODE IS NOT NULL
               AND P.SMRDOUS_PIDM(+) = SMBPOGN_PIDM
               AND P.SMRDOUS_REQUEST_NO(+) = SMBPOGN_REQUEST_NO
               AND P.SMRDOUS_AREA(+) = SMBAOGN_AREA
               AND P.SMRDOUS_CAA_SEQNO(+) = SMRDORQ_CAA_SEQNO
               AND ADJ.SMRDOUS_PIDM(+) = SMBPOGN_PIDM
               AND ADJ.SMRDOUS_REQUEST_NO(+) = SMBPOGN_REQUEST_NO
               AND ADJ.SMRDOUS_AREA(+) = SMBAOGN_AREA
               AND ADJ.SMRDOUS_CAA_SEQNO(+) = SMRDORQ_CAA_SEQNO
               AND ADJ.SMRDOUS_SUBJ_CODE(+) || ADJ.SMRDOUS_CRSE_NUMB(+) <>
                      SMRDORQ_SUBJ_CODE || SMRDORQ_CRSE_NUMB_LOW
        UNION
        SELECT SMBPOGN_PIDM,                                     ------PROGRAM
               SMBPOGN_REQUEST_NO,
               SMBPOGN_PROGRAM,
               ------------------------------AREA
               SMBAOGN_AREA,
               ------------------ COURSES
               SMRDRRQ_CAA_SEQNO,
               NVL (P.SMRDOUS_EARNED_IND, 'N') MET_IND,
               SMRDRRQ_SUBJ_CODE,
               SMRDRRQ_CRSE_NUMB_LOW,
               P.SMRDOUS_CRN,
               P.SMRDOUS_TERM_CODE,
               P.SMRDOUS_GRDE_CODE,
               ADJ.SMRDOUS_SUBJ_CODE || ADJ.SMRDOUS_CRSE_NUMB ADJ_SUBJ
          FROM SMBPOGN PROG,
               SMBAOGN,
               SMRDRRQ,
               SMRDOUS P,
               SMRDOUS ADJ
         WHERE     SMBPOGN_REQUEST_NO =
                      (SELECT MAX (SMBPOGN_REQUEST_NO)
                         FROM SMBPOGN
                        WHERE SMBPOGN_PIDM = PROG.SMBPOGN_PIDM)
               AND SMBAOGN_PIDM = SMBPOGN_PIDM
               AND SMBAOGN_REQUEST_NO = SMBPOGN_REQUEST_NO
               AND SMRDRRQ_PIDM = SMBPOGN_PIDM
               AND SMRDRRQ_REQUEST_NO = SMBPOGN_REQUEST_NO
               AND SMRDRRQ_AREA = SMBAOGN_AREA
               AND P.SMRDOUS_PIDM(+) = SMBPOGN_PIDM
               AND P.SMRDOUS_REQUEST_NO(+) = SMBPOGN_REQUEST_NO
               AND P.SMRDOUS_AREA(+) = SMBAOGN_AREA
               AND P.SMRDOUS_CAA_SEQNO(+) = SMRDRRQ_CAA_SEQNO
               AND P.SMRDOUS_KEY_RULE(+) = SMRDRRQ_KEY_RULE
               AND P.SMRDOUS_RUL_SEQNO(+) = SMRDRRQ_RUL_SEQNO
               AND ADJ.SMRDOUS_PIDM(+) = SMBPOGN_PIDM
               AND ADJ.SMRDOUS_REQUEST_NO(+) = SMBPOGN_REQUEST_NO
               AND ADJ.SMRDOUS_AREA(+) = SMBAOGN_AREA
               AND ADJ.SMRDOUS_CAA_SEQNO(+) = SMRDRRQ_CAA_SEQNO
               AND ADJ.SMRDOUS_KEY_RULE(+) = SMRDRRQ_KEY_RULE
               AND ADJ.SMRDOUS_RUL_SEQNO(+) = SMRDRRQ_RUL_SEQNO
               AND ADJ.SMRDOUS_SUBJ_CODE(+) || ADJ.SMRDOUS_CRSE_NUMB(+) <>
                      SMRDRRQ_SUBJ_CODE || SMRDRRQ_CRSE_NUMB_LOW) COMP
 WHERE COMP.ST_PIDM = :PIDM
 AND COMP.REQUEST_NO=:REQUEST_NO
 AND COMP.AREA_CODE=:AREA_CODE
 AND COMP.SUBJ_CODE=:SUBJECT_CODE
 AND COMP.CRSE_NUMB=:COURSE_NUMBER