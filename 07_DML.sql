-- autocommit : sql문 실생 시 마다 commit 처리(최종적용) - 1
select @@autocommit;
-- @@autocommit 값 : 1이면 autocommit

-- autocommit 해제 @@autocommit 값을 0으로 설정
set autocommit = 0;

-- emp 테이블의 모든 행 삭제
delete from emp; 

-- 실행취소
rollback;

-- 최종적용
 commit;
 


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



/* *********************************************************************
INSERT 문 - 행 추가
구문
 - 한행추가 :
   - INSERT INTO 테이블명 (컬럼 [, 컬럼]) VALUES (값 [, 값[])
   - 모든 컬럼에 값을 넣을 경우 컬럼 지정구문은 생략 할 수 있다.

 - 조회결과(select)를 INSERT 하기 (subquery 이용)
   - INSERT INTO 테이블명 (컬럼 [, 컬럼])  SELECT 구문
	 - INSERT할 컬럼과 조회한(subquery) 컬럼의 개수와 타입이 맞아야 한다.
	 - 모든 컬럼에 다 넣을 경우 컬럼 설정은 생략할 수 있다.
************************************************************************ */

-- 세로운 행 추가
insert into emp values (300, '홍길동', 'AC_ACCOUNT', 205, '2022-05-31', 4000, null, 'Accounting');

-- 특정 행 값만 추가할 경우 특정 열을 지정하여 삽입
-- (mgr_id, salary, comm_pct, dept_name : Nullable 컬럼)
insert into emp (emp_id, emp_name, job, hire_date) values (301, '유관순', 'AC_ACCOUNT', '2020-10-20');

insert into emp values (303, '이순신', 'AC_ACCOUNT', 205, '2020-01-03', 10000, 0.1, null);

-- 신규 테이블 생성
create table emp_copy (
	emp_id int,
    emp_name varchar(20), 
    salary decimal(7,2)
);

-- 직원 중 'IT' 부서의 직원들만 emp_copy에 저장
insert into emp_copy (emp_id, emp_name, salary) select emp_id, emp_name, salary from emp where dept_name = 'It';


-- TODO 부서별 직원의 급여에 대한 통계 테이블 생성 후 emp의 다음 조회결과를 insert. 집계: 합계, 평균, 최대, 최소, 분산, 표준편차

-- salary 통계 데이터를 저장할 테이블
drop table if exists salary_stat;
create table salary_stat(
	dept_name  varchar(30),
    sum double, 
    avg double, 
    max double, 
    min double, 
    var double, 
    stddev double
);

-- 테이블에 삽입
insert into salary_stat 
select  dept_name, 
		sum(salary),
        round(avg(salary),3),
        max(salary),
        min(salary),
        round(variance(salary),3),
        round(stddev(salary),3)
from emp
group by dept_name;



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



/* *********************************************************************
UPDATE : 테이블의 컬럼의 값을 수정
UPDATE 테이블명
SET    변경할 컬럼 = 변경할 값  [, 변경할 컬럼 = 변경할 값]
[WHERE 제약조건]
 - UPDATE: 변경할 테이블 지정
 - SET: 변경할 컬럼과 값을 지정
 - WHERE: 변경할 행을 선택. 
*********************************************************************** */

-- 직원 ID가 200인 직원의 급여를 5000으로 변경
update emp          -- table 선택
set salary = 5000   -- 변경 값 설정
where emp_id = 200; -- 변경 대상 행 지정

-- 직원 ID가 200인 직원의 급여를 10% 인상한 값으로 변경.
update emp
set salary = salary * 1.1
where emp_id = 200;

-- 부서 ID가 100인 직원의 커미션 비율을 0.2로 salary는 3000을 더한 값으로, 상사_id는 100 변경.
update emp
set comm_pct = 0.2,
	salary = salary + 3000,
    mgr_id = 100
where dept_id = 100;

-- 부서 ID가 100인 직원의 커미션 비율을 null 로 변경.
update emp
set comm_pct = null
where dept_id = 100;


-- TODO: 부서 ID가 100인 직원들의 급여를 100% 인상
update emp
set salary = salary * 2
where dept_id = 100;

-- TODO: IT 부서의 직원들의 급여를 3배 인상
update emp
set salary = salary * 3
where dept_id = (select dept_id from dept where dept_id ='IT');

-- TODO: EMP 테이블의 모든 데이터를 MGR_ID는 NULL로 HIRE_DATE 는 현재일시로 COMM_PCT는 0.5로 수정.
update emp
set mgr_id = null,
	hire_date = curdate(),
    comm_pct = 0.5; 



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



/* *********************************************************************
DELETE : 테이블의 행을 삭제
구문 
 - DELETE FROM 테이블명 [WHERE 제약조건]
   - WHERE: 삭제할 행을 선택
************************************************************************ */

-- 부서테이블에서 부서_ID가 200인 부서 삭제
delete from dept
where dept_id = 200;

-- 부서테이블에서 부서_ID가 10인 부서 삭제
delete from dept
where dept_id = 10;

-- TODO: 부서 ID가 없는 직원들을 삭제
delete from emp
where dept_id is null;

-- TODO: 담당 업무(emp.job_id)가 'SA_MAN'이고 급여(emp.salary) 가 12000 미만인 직원들을 삭제. 
delete from emp
where job_id = 'SA_MAN' and salary < 12000;

-- TODO: comm_pct 가 null이고 job_id 가 IT_PROG인 직원들을 삭제
delete from emp
where comm_pct is null and job_id = 'IT_PROG';