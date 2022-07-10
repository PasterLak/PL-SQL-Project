select * from faehigkeit;

/

create or replace procedure AddFaehigkeit 
(p_fnr in faehigkeit.fnr%type, 
p_art in faehigkeit.art%type 
)
is
begin
   insert into faehigkeit(fnr, art)
    values (p_fnr, p_art);
end AddFaehigkeit;

/

create or replace procedure RemoveFaehigkeit 
(p_fnr in faehigkeit.fnr%type
)
is
begin
   table_pkg.deleteRow('faehigkeit', 'fnr=' || p_fnr);
end RemoveFaehigkeit;

/

drop trigger t_updateFaehigkeit;

CREATE OR REPLACE TRIGGER t_updateFaehigkeit
before update on faehigkeit
for each row
declare
begin
    raise_application_error (-20007, 'Man darf Update nicht benutzen!');
end;


