create  FUNCTION has_completed_crse_srvy_wrp (p_pidm NUMBER)
        RETURN CHAR
    IS
        
    BEGIN
        return xwcksrvc.has_completed_crse_srvy(p_pidm);
    END;
    
    
    grant execute on bu_apps.has_completed_crse_srvy_wrp   to public ;
    create public synonym has_completed_crse_srvy_wrp for  bu_apps.has_completed_crse_srvy_wrp ; 