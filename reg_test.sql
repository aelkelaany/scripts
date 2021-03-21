 --SELECT F_GET_STD_ID(114839) FROM DUAL
DECLARE
   CURSOR sftregs_cur
   IS
      SELECT *
        FROM SATURN.SFTREGS
       WHERE     SFTREGS_TERM_CODE = '143920'
             AND SFTREGS_PIDM = 114839
             AND SFTREGS_CRN = '17136';

   sftregs_row    sftregs%ROWTYPE;
   scbcrse_row    scbcrse%ROWTYPE;
   ssbsect_row    ssbsect%ROWTYPE;

   sobterm_row    sobterm%ROWTYPE;

   CURSOR sobterm_cur
   IS
      SELECT *
        FROM sobterm
       WHERE SOBTERM_TERM_CODE = f_get_param ('GENERAL', 'CURRENT_TERM', 1);

   stcr_err_ind   VARCHAR2 (150);
   appr_err       VARCHAR2 (150);

   CURSOR ssbsect_cur (
      p_crn VARCHAR2)
   IS
      SELECT *
        FROM ssbsect
       WHERE     ssbsect_term_code =
                    f_get_param ('GENERAL', 'CURRENT_TERM', 1)
             AND ssbsect_crn = p_crn;

   CURSOR scbcrse_cur (
      p_subj_code    VARCHAR2,
      p_crse_numb    NUMBER)
   IS
      SELECT *
        FROM scbcrse s
       WHERE     s.SCBCRSE_EFF_TERM =
                    (SELECT MAX (SCBCRSE_EFF_TERM)
                       FROM scbcrse
                      WHERE     scbcrse_subj_code = s.scbcrse_subj_code
                            AND scbcrse_crse_numb = s.scbcrse_crse_numb
                            AND SCBCRSE_EFF_TERM <=
                                   f_get_param ('GENERAL', 'CURRENT_TERM', 1))
             AND s.scbcrse_subj_code = p_subj_code
             AND s.scbcrse_crse_numb = p_crse_numb;

BEGIN
   OPEN sftregs_cur;

   FETCH sftregs_cur INTO sftregs_row;

   CLOSE sftregs_cur;

   OPEN sobterm_cur;

   FETCH sobterm_cur INTO sobterm_row;

   CLOSE sobterm_cur;

   OPEN ssbsect_cur (sftregs_row.sftregs_crn);

   FETCH ssbsect_cur INTO ssbsect_row;

   CLOSE ssbsect_cur;

   OPEN scbcrse_cur (ssbsect_row.ssbsect_subj_code,
                     ssbsect_row.ssbsect_crse_numb);

   FETCH scbcrse_cur INTO scbcrse_row;

   CLOSE scbcrse_cur;

   -- =======================================================
   -- This procedure performs edits based on a single course
   -- Checks approval code restrictions.
   -- Checks level restrictions.
   -- Checks college restrictions.
   -- Checks degree restrictions.
   -- Checks program restrictions.
   -- Checks major restrictions.
   -- Checks campus restrictions.
   -- Checks class restrictions.
   -- Checks repeat restrictions
   -- Checks capacity.
   -- =======================================================
   sfkedit.p_pre_edit (sftregs_row,                                      --out
                       stcr_err_ind,                                     --out
                       appr_err,                                         --out
                       
                       'N',--old_stvrsts_row.stvrsts_incl_sect_enrl,
                       'N',                --old_stvrsts_row.stvrsts_wait_ind,
                       'N',--stvrsts_row.stvrsts_incl_sect_enrl,
                       'N',--stvrsts_row.stvrsts_wait_ind,
                       sobterm_row.sobterm_appr_severity,
                       sobterm_row.sobterm_levl_severity,
                       sobterm_row.sobterm_coll_severity,
                       sobterm_row.sobterm_degree_severity,
                       sobterm_row.sobterm_program_severity,
                       sobterm_row.sobterm_majr_severity,
                       sobterm_row.sobterm_camp_severity,
                       sobterm_row.sobterm_clas_severity,
                       sobterm_row.sobterm_capc_severity,
                       sobterm_row.sobterm_rept_severity,
                       sobterm_row.sobterm_rpth_severity,
                       sobterm_row.sobterm_dept_severity,
                       sobterm_row.sobterm_atts_severity,
                       sobterm_row.sobterm_chrt_severity,
                       '',--sgrclsr_clas_code,
                       scbcrse_row.scbcrse_max_rpt_units,
                       scbcrse_row.scbcrse_repeat_limit,
                       ssbsect_row.ssbsect_sapr_code,
                       ssbsect_row.ssbsect_reserved_ind,
                       ssbsect_row.ssbsect_seats_avail,
                       ssbsect_row.ssbsect_wait_count,
                       ssbsect_row.ssbsect_wait_capacity,
                       ssbsect_row.ssbsect_wait_avail,
                       'WA');
                        IF ssbsect_row.ssbsect_tuiw_ind = 'Y'
      THEN
         sftregs_row.sftregs_waiv_hr := '0';
      ELSE
         sftregs_row.sftregs_waiv_hr := sftregs_row.sftregs_bill_hr;
      END IF;

      sftregs_row.sftregs_activity_date := SYSDATE;

      IF stcr_err_ind = 'Y'
      THEN
         sftregs_row.sftregs_rsts_code :=
                                     SUBSTR (f_stu_getwebregsrsts ('D'), 1, 2);
         sftregs_row.sftregs_vr_status_type :=
             sfkfunc.f_get_rsts_type(sftregs_row.sftregs_rsts_code);
         sftregs_row.sftregs_remove_ind := 'Y';
         sftregs_row.sftregs_rec_stat := 'N';
      END IF;

      bwcklibs.p_add_sftregs (sftregs_row);
                       dbms_output.put_line(stcr_err_ind||'stcr_err_ind');
                       dbms_output.put_line(appr_err||'appr_err');
                       dbms_output.put_line(SFTREGS_ROW.SFTREGS_RMSG_CDE||'SFTREGS_RMSG_CDE');
                       dbms_output.put_line(SFTREGS_ROW.SFTREGS_MESSAGE||'SFTREGS_MESSAGE');
                       
                       
END;

sfbetrm

sfrstcr
ssbsect
sfkmods

bwskfreg
BWLKOSTM
BWLKFFCS