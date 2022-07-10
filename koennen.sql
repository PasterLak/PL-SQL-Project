select * from koennen;

/
create or replace procedure AddKoennen
(p_minr in koennen.minr%type, 
p_fnr in koennen.fnr%type
)
is
begin
  insert into koennen(minr, fnr)
values (p_minr,p_fnr);
end AddKoennen;
/
execute AddKoennen(4,3);

/

create or replace procedure RemoveKoennen 
(p_minr in koennen.minr%type)
is
begin
   table_pkg.deleteRow('koennen', 'minr='||p_minr);
end RemoveKoennen;

/
create or replace function getFaehigkeitenAnzahl
(p_minr mitarbeiter.minr%type)
return number
is
 x number := 0;
begin
    select count(*)into x from koennen  where minr=p_minr;
    return x;
end;
/


drop trigger checkKoennen;

CREATE OR REPLACE TRIGGER checkKoennen
before insert on koennen
for each row
BEGIN

if getFaehigkeitenAnzahl(:new.minr) >= 5 then
dbms_output.put_line('Kein Mitarbeiter soll mehr als fünf Fähigkeiten haben!' );
raise_application_error (-20000, 'Kein Mitarbeiter soll mehr als fünf Fähigkeiten haben!');
end if;

END;

/


drop trigger t_updateKoennen;

CREATE OR REPLACE TRIGGER t_updateKoennen
before update on koennen
for each row
declare
begin
    raise_application_error (-20007, 'Man darf Update nicht benutzen!');
end;






