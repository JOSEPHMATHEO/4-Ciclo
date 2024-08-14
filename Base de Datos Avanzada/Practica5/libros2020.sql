create or replace trigger t_numlibros
after insert on autorias
for each row 
begin

    update autores 
    set numlibros = numlibros + 1
    Where idautor = :new.idautor;

end;
/


begin 

    agregarautoria(2,1);
    
end;
/

create or replace trigger t_numlibros_2
after delete on autorias
for each row 
begin

    update autores 
    set numlibros = numlibros - 1
    Where idautor = :old.idautor;

end;
/


delete from autorias 
where idlibro = 1
    and idautor= 4;
    
    
/

create or replace trigger t_numlibros_3
after update of idautor on autorias
for each row 
begin

    update autores 
    set numlibros = numlibros - 1
    Where idautor = :old.idautor;
    
    update autores 
    set numlibros = numlibros + 1
    Where idautor = :new.idautor;

end;
/

update autorias 
set idautor = 4
where idlibro = 1
    and idautor = 3;
    
    
drop trigger t_numlibros;
drop trigger t_numlibros_2;
drop trigger t_numlibros_3;
/

create or replace trigger t_numlibros
after insert or update of idautor or delete on autorias
for each row 
begin

    if inserting then 
    
        update autores 
        set numlibros = numlibros + 1
        Where idautor = :new.idautor;
      
    elsif updating then 

        update autores 
        set numlibros = numlibros - 1
        Where idautor = :old.idautor;
        
        update autores 
        set numlibros = numlibros + 1
        Where idautor = :new.idautor;
        
    else
    
        update autores 
        set numlibros = numlibros - 1
        Where idautor = :old.idautor;
    
    end if;
    
end;
/

create or replace trigger t_limite_autorias
before insert on autorias
for each row 
declare 
    c_aut int;
begin

    select count(*) into c_aut
    from autorias 
    where idlibro = :new.idlibro;
    
    if c_aut >= 3 then
        raise_application_error(-20344,
        'Error: se ha superadi el numero de autorias permitido');
    end if;
end;


begin
agregarautoria(1,3);
end;
/

