CREATE TABLE DEPT (DEPTNO NUMBER(2) NOT NULL, DNAME VARCHAR (15), LOC VARCHAR(15));
CREATE TABLE SALGRADE (GRADE NUMBER, LOSAL NUMBER, HISAL NUMBER);
CREATE TABLE EMP (EMPNO NUMBER(4) NOT NULL, ENAME VARCHAR(15), JOB VARCHAR(15), MGR NUMBER(4), HIREDATE DATE, SAL NUMBER(7, 2), COMM NUMBER(7, 2), DEPTNO NUMBER(2));
INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');
INSERT INTO SALGRADE VALUES (1, 702, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9000);
INSERT INTO EMP VALUES (7369, 'SMITH', 'CLERK', 7902, '17-DEC-80', 800, NULL, 20);
INSERT INTO EMP VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '20-FEB-81', 1600, 300, 30);
INSERT INTO EMP VALUES (7521, 'WARD', 'SALESMAN', 7698, '22-FEB-81', 1250, 500, 30);
INSERT INTO EMP VALUES (7655, 'JONES', 'MANAGER', 7839, '2-APR-81', 2975, NULL, 20);
INSERT INTO EMP VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '28-SEP-81', 1250, 1400, 30);
INSERT INTO EMP VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1-MAY-91', 2850, NULL, 30);
INSERT INTO EMP VALUES (7782, 'CLARK', 'MANAGER', 7839, '9-JUN-81', 2450, NULL, 10);
INSERT INTO EMP VALUES (7788, 'SCOTT', 'ANALYST', 7655, '21-MAR-87', 3000, NULL, 20);
INSERT INTO EMP VALUES (7839, 'KING', 'PRESIDENT', NULL, '12-NOV-81', 5000, 0, 10);
INSERT INTO EMP VALUES (7844, 'TURNER', 'SALESMAN', 7698, '18-SEP-81', 1500, NULL, 30);
INSERT INTO EMP VALUES (7876, 'ADAMS', 'CLERK', 7788, '24-APR-87', 1100, NULL, 20);
INSERT INTO EMP VALUES (7900, 'JAMES', 'CLERK', 7698, '3-DEC-81', 950, NULL, 30);
INSERT INTO EMP VALUES (7902, 'FORD', 'ANALYST', 7655, '3-DEC-81', 3000, NULL, 20);
INSERT INTO EMP VALUES (7934, 'MILLER', 'CLERK', 7782, '3-JAN-81', 1300, NULL, 10);
COMMIT;