delete BU_DEV.TMP_TBL_KILANY ;
insert into BU_DEV.TMP_TBL_KILANY (col01,col02,col03,col04)

 SELECT  (SELECT SPBPERS_ssn
                    FROM SPBPERS
                   WHERE SPBPERS_Pidm = m.requester_pidm)
                    ssn , m.request_no ,
                 requester_pidm ,(select SORHSCH_GPA from SORHSCH where SORHSCH_PIDM=m.requester_pidm ) gpa
                 
                
                 
            FROM request_master m, sgbstdn b
           WHERE     sgbstdn_pidm = requester_pidm
                 AND sgbstdn_term_code_eff =
                        (SELECT MAX (x.sgbstdn_term_code_eff)
                           FROM sgbstdn x
                          WHERE x.sgbstdn_pidm = b.sgbstdn_pidm)
                 AND object_code = 'WF_TRANSFER'
                 AND request_status IN ('P')
                 AND EXISTS
                        (SELECT 1
                           FROM WF_REQUEST_FLOW
                          WHERE     REQUEST_NO = m.request_no
                                AND FLOW_SEQ =
                                       (SELECT MAX (FLOW_SEQ)
                                          FROM WF_REQUEST_FLOW
                                         WHERE REQUEST_NO = m.request_no)
                                AND FLOW_SEQ  >= 1
                                  )
                                   
                 AND EXISTS
                        (SELECT 1
                           FROM request_details d
                          WHERE     d.request_no = m.request_no
                                AND d.sequence_no = 1
                                AND d.item_code = 'TERM'
                                AND d.item_value = '144230')
                 
                 AND (   EXISTS
                            (SELECT 1
                               FROM request_details d
                              WHERE     d.request_no = m.request_no
                                    AND d.sequence_no = 1
                                    AND d.item_code = 'TRANSFER_COLLEGE'
                                    AND d.item_value in ('14','25','33','55'))
                      )
                 