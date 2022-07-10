-- CREATE TABLES
drop table mitarbeiter;
drop table projekt;
drop table faehigkeit;
drop table koennen;
drop table mitarbeit;

create table mitarbeiter (
    minr int primary key,
    name varchar(255)
);

create table projekt (
    pnr   int primary key,
    pname varchar(255),
    kunde varchar(255),
    maxp  int
);

create table faehigkeit (
    fnr int primary key,
    art varchar(255)
);

create table koennen (
    minr int not null,
    foreign key ( minr )
        references mitarbeiter ( minr ),
    fnr  int not null,
    foreign key ( fnr )
        references faehigkeit ( fnr )
);

create table mitarbeit (
    minr int not null,
    foreign key ( minr )
        references mitarbeiter ( minr ),
    fnr  int not null,
    foreign key ( fnr )
        references faehigkeit ( fnr ),
    pnr  int not null,
    foreign key ( pnr )
        references projekt ( pnr )
);

-- INSERT MITARBEITER
insert into mitarbeiter(minr, name)
values (3, 'Vlad Lenn');
insert into mitarbeiter(minr, name)
values (4, 'Marvin');
insert into mitarbeiter(minr, name)
values (5, 'Lola');
insert into mitarbeiter(minr, name)
values (42, 'Erwin Meier');

-- INSERT PROJEKT
insert into projekt(pnr, pname, kunde, maxp)
values (542, 'Studierendengebühren', 'Ministerium', 10);
insert into projekt(pnr, pname, kunde, maxp)
values (33, 'Startup', 'Privat', 4);

-- INSERT FAEHIGKEIT
insert into faehigkeit(fnr, art)
values (0, 'Projektleiter');
insert into faehigkeit(fnr, art)
values (1, 'Java-Programmierer');
insert into faehigkeit(fnr, art)
values (2, 'C#-Programmierer');
insert into faehigkeit(fnr, art)
values (3, 'Lisp-Programmierer');

-- INSERT KOENNEN
insert into koennen(minr, fnr)
values (42, 1);
insert into koennen(minr, fnr)
values (3, 0);
insert into koennen(minr, fnr)
values (4, 2);
insert into koennen(minr, fnr)
values (5, 3);

-- INSERT MITARBEIT
insert into mitarbeit(minr, fnr, pnr)
values (42, 1, 542);
