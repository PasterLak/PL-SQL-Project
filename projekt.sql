select * from projekt;
/



create or replace procedure AddProjekt 
(p_pnr in projekt.pnr%type, 
p_pname in projekt.pname%type,
p_kunde in projekt.kunde%type,
p_maxp in projekt.maxp%type 
)
is
begin
   insert into projekt(pnr, pname, kunde, maxp)
values (p_pnr, p_pname, p_kunde, p_maxp);   
end AddProjekt;

/

create or replace procedure RemoveProjekt 
(p_pnr in projekt.pnr%type)
is
begin
   table_pkg.deleteRow('projekt', 'pnr='||p_pnr);
end RemoveProjekt;

/

create or replace procedure ShowTeam
(p_pnr integer) is
    cursor c_cursor is 
    select * from mitarbeit where pnr = p_pnr;
    v_container c_cursor%rowtype;
    v_mitarbeiterName varchar2(255);
    countMitarbeiter number;
    projektName varchar2(255) := 'null';
begin
    open c_cursor;
    fetch c_cursor into v_container;
    if c_cursor%notfound then
        RAISE_APPLICATION_ERROR
  (-20004, 'Keine Daten gefunden.');
    end if;
    select pname into projektName from projekt where pnr = p_pnr;
    dbms_output.put_line('Projekt Info: ' || projektName);
    select count(*) into countMitarbeiter from mitarbeit where pnr = p_pnr;
        dbms_output.put_line('Count: ' || countMitarbeiter);
    if c_cursor%found then
        while c_cursor%found loop
        
        select name into v_mitarbeiterName from mitarbeiter where minr = v_container.minr;
        if v_container.fnr = 0 then
        dbms_output.put_line('Projektleiter: ' || v_mitarbeiterName);
        else    
        dbms_output.put_line('Mitarbeiter: ' || v_mitarbeiterName);
        end if;
        fetch c_cursor into v_container;
        end loop;
    end if;
    close c_cursor;
end;

/

execute ShowTeam(542);

/

drop trigger t_updateProjekt;

CREATE OR REPLACE TRIGGER t_updateProjekt
before update on projekt
for each row
declare
begin
    raise_application_error (-20007, 'Man darf Update nicht benutzen!');
end;