-- TEST DATABANK

select * from mitarbeiter;
/

create or replace procedure AddMitarbeiter 
(p_minr in mitarbeiter.minr%type, 
p_name in mitarbeiter.name%type 
)
is
begin
   insert into mitarbeiter(minr, name)
    values (p_minr, p_name);
end AddMitarbeiter;

/

create or replace procedure RemoveMitarbeiter 
(p_minr in mitarbeiter.minr%type)
is
begin
   table_pkg.deleteRow('mitarbeiter', 'minr='||p_minr);
end RemoveMitarbeiter;
/


execute AddMitarbeiter(4, 'ggg');
/
execute RemoveMitArbeiter(44);


create or replace procedure ShowWoArbeitet
(p_minr integer) is
    cursor c_cursor is 
    select pnr from mitarbeit where minr = p_minr;
    v_container c_cursor%rowtype;
    v_pname varchar2(255);
begin

    open c_cursor;
    fetch c_cursor into v_container;
    if c_cursor%notfound then
        RAISE_APPLICATION_ERROR
  (-20004, 'Keine Daten gefunden.');
    end if;
    if c_cursor%found then
        while c_cursor%found loop
        select pname into v_pname from projekt where pnr = v_container.pnr;
        dbms_output.put_line('Projekt: ' || v_pname);
        fetch c_cursor into v_container;
        end loop;
    end if;
    close c_cursor;
end;
    
/
execute ShowWoArbeitet(42);

/


create or replace procedure ShowFaehigkeiten
(p_minr integer) is
    cursor c_cursor is 
    select fnr from koennen where minr = p_minr;
    v_container c_cursor%rowtype;
    v_art varchar2(255);
begin

    open c_cursor;
    fetch c_cursor into v_container;
    if c_cursor%notfound then
        RAISE_APPLICATION_ERROR
  (-20004, 'Keine Daten gefunden.');
    end if;
    if c_cursor%found then
        while c_cursor%found loop
        select art into v_art from faehigkeit where fnr = v_container.fnr;
        dbms_output.put_line('Skill: ' || v_art);
        fetch c_cursor into v_container;
        end loop;
    end if;
    close c_cursor;
end;

/

execute ShowFaehigkeiten(42);

/

create or replace procedure AnWieVielProjektenArbeitet
(p_minr mitarbeiter.minr%type)
is
 x number := 0;
begin
    select count(*)into x from mitarbeit where p_minr=p_minr;
    dbms_output.put_line('Arbeitet an: ' ||x); 
end;

/

execute AnWieVielProjektenArbeitet(42);

/

drop trigger t_updateMitarbeiter;

CREATE OR REPLACE TRIGGER t_updateMitarbeiter
before update on mitarbeiter
for each row
declare
begin
    raise_application_error (-20007, 'Man darf Update nicht benutzen!');
end;