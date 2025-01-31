select * from team;
select * from player;

-- Get all the players of CSK

select id from team where label='CSK';

select * from player where team_id = (select id from team where label=$1);

select * from player p where p.price =(select max(price) from player);

select * from player p where p.price=(select max(price) from player p where p.price <(select max(price) from player));


-- Group functions


select min(price),max(price),avg(price),sum(price) from player;

select team_id,sum(price) from player group by team_id;

select t.name, t."label" , sum(p.price) as total_amount,min(price) as min_amount,max(price) as max_amount,avg(price) as avg_amount from player p inner join team t on p.team_id = t.id group by t.name,t."label" ;





-- Classical Scott database (EMP, DEPT, SALGRADE) for PostgreSQL
-- See: https://github.com/rsp/pg-scott


-- DDL - Data Definition Language:

begin;

create table dept (
  deptno integer,
  dname  text,
  loc    text,
  constraint pk_dept primary key (deptno)
);

create table emp (
  empno    integer,
  ename    text,
  job      text,
  mgr      integer,
  hiredate date,
  sal      integer,
  comm     integer,
  deptno   integer,
  constraint pk_emp primary key (empno),
  constraint fk_mgr foreign key (mgr) references emp (empno),
  constraint fk_deptno foreign key (deptno) references dept (deptno)
);

create table salgrade (
  grade integer,
  losal integer,
  hisal integer,
  constraint pk_salgrade primary key (grade)
);

/*
create table bonus (
  ename text,
  job   text,
  sal   integer,
  comm  integer
);
*/


-- DML - Data Manipulation Language:

insert into dept (deptno,  dname,        loc)
       values    (10,     'ACCOUNTING', 'NEW YORK'),
                 (20,     'RESEARCH',   'DALLAS'),
                 (30,     'SALES',      'CHICAGO'),
                 (40,     'OPERATIONS', 'BOSTON');

insert into salgrade (grade, losal, hisal)
       values        (1,      700,  1200),
                     (2,     1201,  1400),
                     (3,     1401,  2000),
                     (4,     2001,  3000),
                     (5,     3001,  9999);

insert into emp (empno, ename,    job,        mgr,   hiredate,     sal, comm, deptno)
       values   (7369, 'SMITH',  'CLERK',     7902, '1980-12-17',  800, NULL,   20),
                (7499, 'ALLEN',  'SALESMAN',  7698, '1981-02-20', 1600,  300,   30),
                (7521, 'WARD',   'SALESMAN',  7698, '1981-02-22', 1250,  500,   30),
                (7566, 'JONES',  'MANAGER',   7839, '1981-04-02', 2975, NULL,   20),
                (7654, 'MARTIN', 'SALESMAN',  7698, '1981-09-28', 1250, 1400,   30),
                (7698, 'BLAKE',  'MANAGER',   7839, '1981-05-01', 2850, NULL,   30),
                (7782, 'CLARK',  'MANAGER',   7839, '1981-06-09', 2450, NULL,   10),
                (7788, 'SCOTT',  'ANALYST',   7566, '1982-12-09', 3000, NULL,   20), -- date fixed
                (7839, 'KING',   'PRESIDENT', NULL, '1981-11-17', 5000, NULL,   10),
                (7844, 'TURNER', 'SALESMAN',  7698, '1981-09-08', 1500,    0,   30),
                (7876, 'ADAMS',  'CLERK',     7788, '1983-01-12', 1100, NULL,   20), -- date fixed
                (7900, 'JAMES',  'CLERK',     7698, '1981-12-03',  950, NULL,   30),
                (7902, 'FORD',   'ANALYST',   7566, '1981-12-03', 3000, NULL,   20),
                (7934, 'MILLER', 'CLERK',     7782, '1982-01-23', 1300, NULL,   10);

commit;


select * from emp;
select * from dept;
select * from salgrade;

-- empno, ename, dname,loc and salary of all employees

select e.empno,e.ename,d.dname,d.loc,e.sal from emp e inner join dept d on e.deptno=d.deptno;


-- empno, ename, dname,loc, salary and grade of all employees

select e.empno,e.ename,d.dname,d.loc,e.sal,s.grade from emp e inner join dept d on e.deptno=d.deptno inner join
salgrade s on e.sal between s.losal and s.hisal;

