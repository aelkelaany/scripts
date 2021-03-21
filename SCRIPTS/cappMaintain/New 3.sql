select      GLBEXTR_SELECTION  ,COUNT(*) from 
(SELECT  
       f_get_std_name (GLBEXTR_KEY)as  "«·«”„",
        NEW_COMP.SMBPOGN_REQUEST_NO "REQUEST NEW", NEW_COMP.SMBPOGN_ACTIVITY_DATE AS "NEW DATE",
       NEW_COMP.SMBPOGN_PROGRAM as "«·»—‰«„Ã",
       NEW_COMP.SMBPOGN_ACT_CREDITS_OVERALL as "«·”«⁄«  »⁄œ",
       OLD_COMP.SMBPOGN_REQUEST_NO old_req#,OLD_COMP.SMBPOGN_ACTIVITY_DATE AS "OLD DATE",
       OLD_COMP.SMBPOGN_PROGRAM old_prog,
       OLD_COMP.SMBPOGN_ACT_CREDITS_OVERALL as "«·”«⁄«  ﬁ»·" ,
       OLD_COMP.SMBPOGN_COLL_CODE   as "«·ﬂ·Ì…" ,GLBEXTR_SELECTION
        , row_number() over ( partition by NEW_COMP.SMBPOGN_PROGRAM order by GLBEXTR_KEY nulls last ) rank
  FROM GLBEXTR, SMBPOGN NEW_COMP, SMBPOGN OLD_COMP
 WHERE     GLBEXTR_SELECTION LIKE 'CAPP_STD_%38'
       AND NEW_COMP.SMBPOGN_PIDM = GLBEXTR_KEY
       AND OLD_COMP.SMBPOGN_PIDM = GLBEXTR_KEY
       AND NEW_COMP.SMBPOGN_REQUEST_NO =
              (SELECT MAX (SMBPOGN_REQUEST_NO)
                 FROM SMBPOGN
                WHERE     SMBPOGN_PIDM = NEW_COMP.SMBPOGN_PIDM
                       )
       AND OLD_COMP.SMBPOGN_REQUEST_NO =
              (SELECT MAX (SMBPOGN_REQUEST_NO) 
                 FROM SMBPOGN
                WHERE     SMBPOGN_PIDM = OLD_COMP.SMBPOGN_PIDM
                AND SMBPOGN_ACTIVITY_DATE<SYSDATE-15
                       )
                  --    and NEW_COMP.SMBPOGN_ACT_COURSES_OVERALL=0--<>old_COMP.SMBPOGN_ACT_COURSES_OVERALL
                        and NEW_COMP.SMBPOGN_ACT_CREDITS_OVERALL=old_COMP.SMBPOGN_ACT_CREDITS_OVERALL
                       AND NEW_COMP.SMBPOGN_REQUEST_NO >OLD_COMP.SMBPOGN_REQUEST_NO
                       )
                       GROUP BY  GLBEXTR_SELECTION
                       ORDER BY 1
                       
                       
                        
                       
                       