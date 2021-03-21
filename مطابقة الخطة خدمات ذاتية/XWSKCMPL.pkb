/* Formatted on 8/20/2019 2:15:18 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PACKAGE BODY XWSKCMPL
AS
   PROCEDURE P_DISPLAY_COMPLIANCE
   IS
      L_IND   VARCHAR2 (50);

      CURSOR GET_COMPLIANCE_HDR
      IS
         SELECT F_GET_STD_ID (SMBPOGN_PIDM) ST_ID,
                F_GET_STD_NAME (SMBPOGN_PIDM) ST_NAME,
                STVCAMP_DESC CAMP,
                STVCOLL_DESC COLL,
                SMRPRLE_PROGRAM_DESC PROG,
                SMBPOGN_REQ_CREDITS_OVERALL REQ_CREDITS,
                SMBPOGN_ACT_CREDITS_OVERALL ACT_CREDITS,
                SMBPOGN_REQ_COURSES_OVERALL REQ_COURSES,
                SMBPOGN_ACT_COURSES_OVERALL ACT_COURSES,
                SMBPOGN_MET_IND,
                DECODE (SMBPOGN_MET_IND,
                        'Y', 'Ãäåì ãÊØáÈÇÊ ÇáÎØÉ ÇáÏÑÇÓíÉ',
                        'áã íäå ãÊØáÈÇÊ ÇáÎØÉ ÇáÏÑÇÓíÉ')
                   MEET_IND
           FROM SMBPOGN,
                STVCAMP,
                STVCOLL,
                SMRPRLE
          WHERE     SMBPOGN_PIDM = PIDM
                AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                            FROM SMBPOGN
                                           WHERE SMBPOGN_PIDM = PIDM)
                AND STVCAMP_CODE = SMBPOGN_CAMP_CODE
                AND STVCOLL_CODE = SMBPOGN_COLL_CODE
                AND SMRPRLE_PROGRAM = SMBPOGN_PROGRAM;

      CURSOR GET_COMPLIANCE_AREA
      IS
           SELECT SMRALIB_AREA_DESC area,
                  SMRALIB_AREA AREA_CODE,
                  DECODE (SMBAOGN_MET_IND,
                          'Y', 'ãÌÊÇÒ',
                          'ÛíÑ ãÌÊÇÒ')
                     MEET_IND,
                  SMBAOGN_REQ_CREDITS_OVERALL,
                  SMBAOGN_MET_IND MET_IND
             FROM SMBAOGN, SMRALIB
            WHERE     SMBAOGN_PIDM = PIDM
                  AND SMBAOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                              FROM SMBPOGN
                                             WHERE SMBPOGN_PIDM = PIDM)
                  AND SMRALIB_AREA = SMBAOGN_AREA
         ORDER BY SMRALIB_AREA_DESC;

      CURSOR GET_COURSES (
         P_AREA VARCHAR2)
      IS
         SELECT ROWNUM SERIAL,
                SCBCRSE_TITLE title,
                DECODE (SMRDORQ_MET_IND,
                        'Y', 'ãÌÊÇÒ',
                        'ÛíÑ ãÌÊÇÒ')
                   MEET_IND,
                SMRDORQ_SUBJ_CODE || SMRDORQ_CRSE_NUMB_LOW SUBJ_CODE,
                DECODE (SCBCRSE_CREDIT_HR_low,
                  0, SCBCRSE_CREDIT_HR_HIGH,
                  SCBCRSE_CREDIT_HR_LOW) SMRDORQ_ACT_CREDITS,
                SMRDORQ_MET_IND MET_IND
           FROM SMRDORQ, scbcrse c
          WHERE     SMRDORQ_PIDM = PIDM
                AND SMRDORQ_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                            FROM SMBPOGN
                                           WHERE SMBPOGN_PIDM = PIDM)
                AND SCBCRSE_SUBJ_CODE = SMRDORQ_SUBJ_CODE
                AND SCBCRSE_CRSE_NUMB = SMRDORQ_CRSE_NUMB_LOW
                AND SCBCRSE_EFF_TERM =
                       (SELECT MAX (SCBCRSE_EFF_TERM)
                          FROM scbcrse
                         WHERE     SCBCRSE_SUBJ_CODE = SMRDORQ_SUBJ_CODE
                               AND SCBCRSE_CRSE_NUMB = SMRDORQ_CRSE_NUMB_LOW)
                AND SMRDORQ_AREA = P_AREA;

      CURSOR GET_OPTIONAL_RULE_EXIST (
         P_AREA VARCHAR2)
      IS
         SELECT '1'
           FROM SMBDRRQ, SMRARUL r
          WHERE     SMBDRRQ_PIDM = PIDM
                AND SMBDRRQ_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                            FROM SMBPOGN
                                           WHERE SMBPOGN_PIDM = PIDM)
                AND SMRARUL_KEY_RULE = SMBDRRQ_KEY_RULE
                AND SMBDRRQ_AREA = SMRARUL_AREA
                AND SMRARUL_SEQNO = SMBDRRQ_CAA_SEQNO(+)
                AND SMRARUL_TERM_CODE_EFF =
                       (SELECT MAX (SMRARUL_TERM_CODE_EFF)
                          FROM SMRARUL
                         WHERE     SMRARUL_KEY_RULE = r.SMRARUL_KEY_RULE
                               AND SMRARUL_AREA = r.SMRARUL_AREA
                               AND SMRARUL_SEQNO = r.SMRARUL_SEQNO)
                AND SMBDRRQ_AREA = P_AREA;

      CURSOR GET_OPTIONAL_RULE (
         P_AREA VARCHAR2)
      IS
         SELECT SMBDRRQ_DESC,
                DECODE (SMBDRRQ_MET_IND,
                        'Y', 'ãÌÊÇÒ',
                        'ÛíÑ ãÌÊÇÒ')
                   MEET_IND,SMBDRRQ_MET_IND MET_IND ,
                SMBDRRQ_MAX_CRED_COND,
                SMBDRRQ_KEY_RULE,
                SMBDRRQ_AREA,
                SMRARUL_TERM_CODE_EFF 
           FROM SMBDRRQ, SMRARUL r
          WHERE     SMBDRRQ_PIDM = PIDM
                AND SMBDRRQ_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                            FROM SMBPOGN
                                           WHERE SMBPOGN_PIDM = PIDM)
                AND SMRARUL_KEY_RULE = SMBDRRQ_KEY_RULE
                AND SMBDRRQ_AREA = SMRARUL_AREA
                AND SMRARUL_SEQNO = SMBDRRQ_CAA_SEQNO(+)
                AND SMRARUL_TERM_CODE_EFF =
                       (SELECT MAX (SMRARUL_TERM_CODE_EFF)
                          FROM SMRARUL
                         WHERE     SMRARUL_KEY_RULE = r.SMRARUL_KEY_RULE
                               AND SMRARUL_AREA = r.SMRARUL_AREA
                               AND SMRARUL_SEQNO = r.SMRARUL_SEQNO)
                AND SMBDRRQ_AREA = P_AREA;

      CURSOR GET_OPTIOANL_COURSES (
         P_KEY_RULE         VARCHAR2,
         P_AREA             VARCHAR2,
         P_TERM_CODE_EFF    VARCHAR2)
      IS
         SELECT ROWNUM SEQ,
                SMRARUL_SUBJ_CODE || SMRARUL_CRSE_NUMB_LOW CRSE,
                SCBCRSE_TITLE TITLE,
                DECODE (SCBCRSE_CREDIT_HR_low,
                  0, SCBCRSE_CREDIT_HR_HIGH,
                  SCBCRSE_CREDIT_HR_LOW)
                   CRD_HR,(select 'Êã ÅÌÊíÇÒå  ' from smrdous where smrdous_pidm=pidm and   smrdous_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                            FROM SMBPOGN
                                           WHERE SMBPOGN_PIDM = PIDM) 
                                           and SMRDOUS_RUL_SEQNO =SMRARUL_SEQNO
                                            and SMRARUL_AREA=SMRDOUS_AREA
                                            and SMRDOUS_TERM_CODE_EFF=SMRARUL_TERM_CODE_EFF
                                           ) notes
           FROM SMRARUL r, SCBCRSE
          WHERE     SCBCRSE_SUBJ_CODE = SMRARUL_SUBJ_CODE
                AND SCBCRSE_CRSE_NUMB = SMRARUL_CRSE_NUMB_LOW
                AND SCBCRSE_EFF_TERM =
                       (SELECT MAX (SCBCRSE_EFF_TERM)
                          FROM scbcrse
                         WHERE     SCBCRSE_SUBJ_CODE = SMRARUL_SUBJ_CODE
                               AND SCBCRSE_CRSE_NUMB = SMRARUL_CRSE_NUMB_LOW)
                AND SMRARUL_KEY_RULE = P_KEY_RULE
                AND SMRARUL_AREA = P_AREA
                AND SMRARUL_TERM_CODE_EFF = P_TERM_CODE_EFF;

   BEGIN
      IF NOT twbkwbis.f_validuser (PIDM)
      THEN
         RETURN;
      END IF;

      twbkwbis.p_opendoc ('XWSKCMPL.P_DISPLAY_COMPLIANCE',
                          disp_exit_link   => TRUE);
      HTP.p (
         '<LINK REL="stylesheet" HREF="/css/responseTab.css" TYPE="text/css">');

      HTP.tableopen (cattributes => 'class="responstable"');
      HTP.TABLEROWOPEN;
      HTP.TABLEHEADER ('ãØÇÈÞÉ ÇáÎØÉ ÇáÏÑÇÓíÉ',
                       'CENTER',
                       ccolspan   => 5);
      HTP.tablerowclose;

      FOR H IN GET_COMPLIANCE_HDR
      LOOP
         HTP.TABLEROWOPEN;
         HTP.TABLEHEADER ('ÇáÑÞã ÇáÌÇãÚí ');
         HTP.TABLEDATA (H.ST_ID, ccolspan => 1);
         HTP.TABLEHEADER ('ÇáÇÓã');
         HTP.TABLEDATA (H.ST_NAME, ccolspan => 2);
         HTP.tablerowclose;
         HTP.TABLEROWOPEN;

         HTP.TABLEHEADER ('ÇáßáíÉ');
         HTP.TABLEDATA (H.COLL);
         HTP.TABLEHEADER ('ÇáÊÎÕÕ');
         HTP.TABLEDATA (H.PROG, ccolspan => 2);
         HTP.tablerowclose;
         HTP.TABLEROWOPEN;
         HTP.TABLEHEADER ('ÚÏÏ ÓÇÚÇÊ ÇáÎØÉ');
         HTP.TABLEDATA (H.REQ_CREDITS);
         HTP.TABLEHEADER ('ÚÏÏ ÇáÓÇÚÇÊ ÇáãÌÊÇÒÉ');
         HTP.TABLEDATA (H.ACT_CREDITS, ccolspan => 2);
         HTP.tablerowclose;
         /*HTP.TABLEROWOPEN;
         HTP.TABLEHEADER ('ÚÏÏ ãÞÑÑÇÊ ÇáÎØÉ');
         HTP.TABLEDATA (H.REQ_COURSES);
         HTP.TABLEHEADER ('ÚÏÏ ÇáãÞÑÑÇÊ ÇáãÌÊÇÒÉ');
         HTP.TABLEDATA (H.ACT_COURSES, ccolspan => 2);
         HTP.tablerowclose;*/
         HTP.TABLEROWOPEN;
         HTP.TABLEHEADER ('äÊíÌÉ ÇáãØÇÈÞÉ');



         HTP.TABLEDATA (
            HTF.bold (H.MEET_IND),
            'CENTER',
            ccolspan      => 5,
            cattributes   =>    'style="'
                             || CASE
                                   WHEN H.SMBPOGN_MET_IND = 'Y'
                                   THEN
                                      'color : green;'
                                   WHEN H.SMBPOGN_MET_IND = 'N'
                                   THEN
                                      'color : red;'
                                END
                             || '"');


         HTP.tablerowclose;


         FOR A IN GET_COMPLIANCE_AREA
         LOOP
            HTP.TABLEROWOPEN;
            HTP.TABLEHEADER (
               'ãÌãæÚÉ ÇáãÊØáÈÇÊ',
               'CENTER',
               ccolspan      => 2,
               cattributes   => 'style="background-color:#ccccff;color:black;"');
            /* HTP.TABLEHEADER ('ÚÏÏ ÓÇÚÇÊ ÇáãÓÊæì', 'CENTER',cattributes   =>    'style="background-color:#ccccff;color:black;"');
             HTP.TABLEHEADER ('äÊíÌÉ ÇáãØÇÈÞÉ', 'CENTER',cattributes   =>    'style="background-color:#ccccff;color:black;"');*/
            HTP.tablerowclose;
            HTP.TABLEROWOPEN;


            HTP.TABLEDATA (
               A.AREA,
               'CENTER',
               ccolspan      => 2,
               cattributes   => 'style="background-color:#bfbfbf;color:black;"');
            /*HTP.TABLEDATA (A.SMBAOGN_REQ_CREDITS_OVERALL, 'CENTER',cattributes   =>    'style="background-color:#bfbfbf;color:black;"');
            HTP.TABLEDATA (
               HTF.bold (A.MEET_IND),
               'CENTER',
               ccolspan      => 5,
               cattributes   =>    'style="background-color:#bfbfbf;'
                                || CASE
                                      WHEN A.MET_IND = 'Y'
                                      THEN
                                         'color : green;'
                                      WHEN A.MET_IND = 'N'
                                      THEN
                                         'color : red;'
                                   END
                                || '"');*/
            HTP.tablerowclose;
            HTP.TABLEROWOPEN;
            HTP.TABLEDATA ('',
                           'CENTER',
                           CCOLSPAN   => 5,
                           CROWSPAN   => 2);
            
HTP.TABLEROWOPEN;
            HTP.tablerowclose;
            HTP.TABLEROWOPEN;
            HTP.TABLEHEADER ('ãÓáÓá', 'CENTER');
            HTP.TABLEHEADER ('ÇáãÞÑÑ', 'CENTER', ccolspan => 2);
            HTP.TABLEHEADER ('ÚÏÏ ÇáÓÇÚÇÊ  ', 'CENTER');
            HTP.TABLEHEADER ('äÊíÌÉ ÇáãÞÑÑ', 'CENTER');
            HTP.tablerowclose;

            FOR C IN GET_COURSES (A.AREA_CODE)
            LOOP
               HTP.TABLEROWOPEN;
               HTP.TABLEDATA (C.SERIAL, 'CENTER');
               HTP.TABLEDATA (C.SUBJ_CODE, 'CENTER', ccolspan => 1);
               HTP.TABLEDATA (C.title , ccolspan => 1);
               HTP.TABLEDATA (C.SMRDORQ_ACT_CREDITS, 'CENTER');
               HTP.TABLEDATA (
                  HTF.bold (C.MEET_IND),
                  'CENTER',
                  ccolspan      => 5,
                  cattributes   =>    'style="'
                                   || CASE
                                         WHEN C.MET_IND = 'Y'
                                         THEN
                                            'color : green;'
                                         WHEN C.MET_IND = 'N'
                                         THEN
                                            'color : red;'
                                      END
                                   || '"');
               HTP.tablerowclose;
            END LOOP;

            OPEN GET_OPTIONAL_RULE_EXIST ( (A.AREA_CODE));

            FETCH GET_OPTIONAL_RULE_EXIST INTO L_IND;

            CLOSE GET_OPTIONAL_RULE_EXIST;

            IF L_IND = '1'
            THEN
            L_IND:='0';
               HTP.TABLEROWOPEN;
               HTP.TABLEHEADER (htf.bold( 'ÇáãÞÑÑÇÊ ÇáÇÎÊíÇÑíÉ'),
                                'CENTER' ,CCOLSPAN=>5, cattributes   =>    'style=" color:brown;background-color:#98FB98"');
               HTP.tablerowclose;



               FOR O IN GET_OPTIONAL_RULE (A.AREA_CODE)
               LOOP
                  HTP.TABLEROWOPEN;
                  HTP.TABLEHEADER ('æÕÝ ÇáÞÇÚÏÉ', 'CENTER');
                  HTP.TABLEHEADER ('ÚÏÏ ÇáÓÇÚÇÊ ÇáãÔÑæØÉ',
                                   'CENTER');
                  HTP.TABLEHEADER ('äÊíÌÉ ÇáÇÎÊíÇÑí', 'CENTER',ccolspan      => 5);
                  HTP.tablerowclose;
                  HTP.TABLEROWOPEN;
                  HTP.TABLEDATA (O.SMBDRRQ_DESC, 'CENTER');
                  HTP.TABLEDATA (O.SMBDRRQ_MAX_CRED_COND, 'CENTER');
                  HTP.TABLEDATA (
                  HTF.bold (O.MEET_IND),
                  'CENTER',
                  ccolspan      => 5,
                  cattributes   =>    'style="'
                                   || CASE
                                         WHEN O.MET_IND = 'Y'
                                         THEN
                                            'color : green;'
                                         WHEN O.MET_IND = 'N'
                                         THEN
                                            'color : red;'
                                      END
                                   || '"');
                  HTP.tablerowclose;
                  HTP.TABLEROWOPEN;
                  HTP.TABLEHEADER ('ãÓáÓá', 'CENTER');
                  HTP.TABLEHEADER ('ÇáãÞÑÑ', 'CENTER', CCOLSPAN => 2);
                  HTP.TABLEHEADER ('ÚÏÏ ÇáÓÇÚÇÊ', 'CENTER');
                  HTP.TABLEHEADER ('ãáÇÍÙÇÊ', 'CENTER');
                  HTP.tablerowclose;

                  FOR OC
                     IN GET_OPTIOANL_COURSES (O.SMBDRRQ_KEY_RULE,
                                              O.SMBDRRQ_AREA,
                                              O.SMRARUL_TERM_CODE_EFF)
                  LOOP
                     HTP.TABLEROWOPEN;
                     HTP.TABLEDATA (OC.SEQ,'CENTER');
                     HTP.TABLEDATA (OC.CRSE,'CENTER');
                     HTP.TABLEDATA (OC.TITLE);
                     HTP.TABLEDATA (OC.CRD_HR,'CENTER');
                     HTP.TABLEDATA (OC.notes,'CENTER');
                     HTP.tablerowclose;
                  END LOOP;
               END LOOP;
            END IF;

            HTP.tablerowclose;
            HTP.TABLEROWOPEN;
            HTP.TABLEDATA ('',
                           'CENTER',
                           CCOLSPAN   => 5,
                           CROWSPAN   => 2);
            

            HTP.tablerowclose;
            HTP.TABLEROWOPEN;
         END LOOP;
          
      END LOOP;

      HTP.tableclose;
   END P_DISPLAY_COMPLIANCE;
END;