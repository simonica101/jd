-- truncate / drop table
alter session set current_schema = me;

-- get rid of all rows (DML)
delete from details;

-- get rid of all rows (DDL)
truncate table details;

-- get rid of the table (DDL)
drop table details;