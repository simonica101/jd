-- run this script as me to populate the ME schema

alter session set current_schema = me;

create table coders
as
    select employee_id as coder_id, first_name, last_name, hire_date, salary
    from hr.employees
    where department_id = 60;

alter table coders modify coder_id int primary key;
alter table coders add constraint coders_name_uq unique (first_name, last_name);

insert into coders (coder_id, first_name, last_name, hire_date, salary)
values (108, 'Tim', 'Ice', sysdate, 5760);

commit;

-- a procedure on coders

create or replace procedure get_coder_salary(
	p_coder_id in coders.coder_id%type,
    p_salary out coders.salary%type) is
begin
	select salary
	into p_salary
	from coders
	where coder_id = p_coder_id;
end;
/

create table teams(
	team_id integer primary key,
	name varchar(25),
    leader_id integer unique,
    constraint teams_leader_fk foreign key(leader_id) references coders(coder_id)
);

insert into teams(team_id, name, leader_id) values(1, 'red', 103);
insert into teams(team_id, name, leader_id) values(2, 'blue', 107);
insert into teams(team_id, name, leader_id) values(3, 'green', 105);

commit;

create table team_coder(
	team_id integer,
    coder_id integer,
	constraint team_coder_pk primary key(team_id, coder_id),
    constraint team_coder_fk foreign key(team_id) references teams(team_id),
    constraint coder_team_fk foreign key(coder_id) references coders(coder_id)
);

insert into team_coder values(1, 104);
insert into team_coder values(1, 106);
insert into team_coder values(1, 108);
insert into team_coder values(2, 105);
insert into team_coder values(2, 106);
insert into team_coder values(2, 107);
insert into team_coder values(3, 105);
insert into team_coder values(3, 106);
insert into team_coder values(3, 103);

commit;
