set serveroutput on;

create or replace package table_pkg is
    procedure deleteRow (
        p_table_name varchar2,
        p_conditions varchar2 := null
    );

end table_pkg;
/

create or replace package body table_pkg is

    procedure execute (
        p_stmt varchar2
    ) is
    begin
        dbms_output.put_line(p_stmt);
        execute immediate p_stmt;
    end;

    procedure deleteRow (
        p_table_name varchar2,
        p_conditions varchar2 := null
    ) is
        v_stmt varchar2(200) := 'DELETE FROM ' || p_table_name;
    begin
        if p_conditions is not null then
            v_stmt := v_stmt
                      || ' WHERE '
                      || p_conditions;
        end if;

        execute(v_stmt);
    exception
        when no_data_found then
            dbms_output.put_line('Row not found!');
        when too_many_rows then
            dbms_output.put_line('More Than One Row found!!');
        when others then
            dbms_output.put_line('Error!');
    end;

end table_pkg;
