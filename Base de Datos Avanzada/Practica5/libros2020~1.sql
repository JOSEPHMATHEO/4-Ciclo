
create or replace function autores_libro (lib number)


RETURN varchar2

IS
    resultado varchar2(1000) := '';
    cursor c_autores is 
    
                    select x.nombreautor
                    from autorias a
                         inner join autores x on a.idautor = x.idautor
                    where a.idlibro = lib;
                    
BEGIN

    for r_aut in c_autores loop
        resultado := resultado || ', ' || r_aut.nombreautor;
    end loop;
    
    RETURN substr(resultado,3);
       
END;
/