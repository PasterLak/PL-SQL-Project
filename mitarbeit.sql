select * from mitarbeit;

/
create or replace procedure AddMitarbeit 
(p_minr in mitarbeit.minr%type, 
p_fnr in mitarbeit.fnr%type, 
p_pnr in mitarbeit.pnr%type
)
is
begin
   insert into mitarbeit(minr, fnr, pnr)
values (p_minr, p_fnr, p_pnr);
end AddMitarbeit;
/
execute AddMitarbeit(4,2,33);

/

create or replace procedure RemoveMitarbeit 
(p_minr in mitarbeit.minr%type)
is
begin
   table_pkg.deleteRow('mitarbeit', 'minr='||p_minr);
end RemoveMitarbeit;


/
create or replace function getCurrentPersonalAnzahl
(p_pnr projekt.pnr%type)
return number
is
 anzahl number := 0;
begin
    select count(*)into anzahl from mitarbeit where pnr=p_pnr;
    dbms_output.put_line(anzahl);
    return anzahl;
end;


/
create or replace function mitarbeiterCanIt
(p_minr mitarbeiter.minr%type, p_fnr faehigkeit.fnr%type)
return number
is
 x number := 0;
begin
    select count(*) into x from koennen where minr=p_minr and fnr = p_fnr;
    return x;
end;

/

drop trigger t_addMitarbeiterToProjekt;

CREATE OR REPLACE TRIGGER t_addMitarbeiterToProjekt
before insert on mitarbeit
for each row
declare
maxPersonal number;
countProjektleiter number;
BEGIN
select maxp into maxPersonal from projekt where pnr = 542;
select count(*) into countProjektleiter from mitarbeit where fnr = 0 and pnr = :new.pnr;

if mitarbeiterCanIt(:new.minr, :new.fnr) = 0 then
    raise_application_error (-20006, 'Der Mitarbeiter hat keine Faehigkeit!');
    end if;
    
if getCurrentPersonalAnzahl(:new.pnr) = 3 and countProjektleiter = 0 and :new.fnr != 0 then
    dbms_output.put_line('Add Projektleiter!' );
    raise_application_error (-20007, 'Dieses Projekt braucht einen Projektleiter!');
end if;

if getCurrentPersonalAnzahl(:new.pnr) < maxPersonal then
    if :new.fnr = 0 and countProjektleiter >= 1 then
        raise_application_error (-20005, 'Das Projekt hat schon einen Projektleiter!');  
    end if;
end if;

if getCurrentPersonalAnzahl(:new.pnr) >= maxPersonal then
dbms_output.put_line('Dieses Projekt hat schon genug Mitarbeiter!' );
raise_application_error (-20001, 'Dieses Projekt hat schon genug Mitarbeiter!');
end if;

END;
/

drop trigger t_updateMitarbeit;

CREATE OR REPLACE TRIGGER t_updateMitarbeit
before update on mitarbeit
for each row
declare
begin
    raise_application_error (-20007, 'Man darf Update nicht benutzen!');
end;

