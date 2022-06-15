/* *************************************
SQL : 대소문자 구분 안함. (값은 구분)

SELECT 기본 구문 - 연산자, 컬럼 별칭
select 컬럼명, 컬럼명 [, .....]  => 조회할 컬럼 지정. *: 모든 컬럼
from   테이블명                 => 조회할 테이블 지정.
where 제약조건
group by 그룹화 할 기준 컬럼
having 조건
order by 정렬기준 컬럼 [asc|desc]
*************************************** */
/* select 문 실행 순서
select      --- 5
from    	--- 1
where 		--- 2
group by	--- 3
having		--- 4
order by    --- 6
​
*/

-- EMP 테이블의 모든 컬럼의 모든 항목을 조회.
select emp_id,
	   emp_name,
       job, 
       mgr_id,
       salary,
       comm_pct,
       dept_name
from   emp;

select * from emp; -- * : 모든 컬럼

-- EMP 테이블의 직원 ID(emp_id), 직원 이름(emp_name), 업무(job) 컬럼의 값을 조회.
select emp_id, emp_name, job from emp;

-- EMP 테이블의 업무(job) 어떤 값들로 구성되었는지 조회. - 동일한 값은 하나씩만 조회되도록 처리. (컬럼이 categorical(분류) 형식)
select distinct job from emp; -- distinct : 중복 값 제거 


-- EMP 테이블의 부서명(dept_name)이 어떤 값들로 구성되었는지 조회 - 동일한 값은 하나씩만 조회되도록 처리.
select distinct dept_name from emp;

-- EMP 테이블에서 emp_id는 직원ID, emp_name은 직원이름, hire_date는 입사일, salary는 급여, dept_name은 소속부서 별칭으로 조회한다.
	-- select 컬럼명 (as) 별칭 : 컬럼명으로 조회한 것을 별칭으로 명명
    --  별칭에 컬럼명으로 못사용하는 문자(공백)를 쓸 경우 " "로 감싼다. 
select emp_id as "직원 ID", -- emp_id에서 조회한 결과를 직원ID로 출력
	   emp_name as "직원 이름", -- as 생략가능 
       hire_date "입사일", 
       salary "급여",
       dept_name "소속 부서"
from   emp;



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



/* **************************************
연산자 
- 산술 연산자 
	+, -, *, /, %, mod, div
- date/time/datetime 
    - +, - : 마지막 항목(date:일, time: 초, datetime: 초)의 값을 +/- => 계산 결과가 정수형으로 반환된다. (ex:20100102)
- 여러개 값을 합쳐 문자열로 반환
	- concat(값, 값, ...) 
- 피연산자가 null인경우 결과는 null
- 연산은 그 컬럼의 모든 값들에 일률적으로 적용된다.
- 같은 컬럼을 여러번 조회할 수 있다.
************************************** */
-- 산술연산 
select 10 as a, 20 as b; -- select 절에 문자/숫자를  넣어 확인 시 from 생략 가능

select 20 + 30,
	   20 - 10,
       20 * 3,
       20 / 3,
	   20 % 3, -- 나머지 연산자
       20 mod 3, -- 나머지 연산자
       20 div 3; -- 몫만 출력
       
select 20 + null; -- null : 없는 값, 모르는 값

-- 문자열 병합 
select concat('이름 : ', '홍길동'),
	   concat('나이 : ', 20); -- 문자열과 모든 타입의 값을 합칠 때 사용.
       
-- 날짜/시간 + -       # cast() : 타입 변환 함수
select cast('2022-05-25' as date) - 3;
select cast('10:30:30' as time) - 5;

-- EMP 테이블에서 직원의 이름(emp_name), 급여(salary) 그리고  급여 + 1000 한 값을 조회.
select emp_name,
	   salary,
       salary + 1000
from   emp;

-- 같은 행 연산
select salary,
	   comm_pct,
       salary * comm_pct -- 같은 행의 salary 와 comm_pct 를 연산 
from   emp;


-- TODO : EMP 테이블의 업무(job)이 어떤 값들로 구성되었는지 조회 - 동일한 값은 하나씩만 조회되도록 처리
select distinct job from emp;

-- TODO : EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션_PCT(comm_pct), 급여에 커미션_PCT를 곱한 값을 조회.
select emp_id "ID",
	   emp_name "이름",
       salary "급여",
       comm_pct "커미션 PCT",
       salary * comm_pct "급여 * 커미션 PCT"
from   emp;

-- TODO:  EMP 테이블에서 급여(salary)을 연봉으로 조회. (곱하기 12)
select salary "급여",
	   salary * 12 "연봉"
from emp;

-- TODO : EMP 테이블에서 직원이름(emp_name)과 급여(salary)을 조회. 급여 앞에 $를 붙여 조회.
select emp_name "직원 이름",
	   concat('$', salary) "급여"
from   emp; 



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  



/* *************************************
where 절을 이용한 행 선택 
where 컬럼 연산자 피연산자 값 - 칼럼의 값들과 연산 시 True 인 행만 조회(Filter개념)
************************************* */
-- EMP 테이블에서 직원_ID(emp_id)가 110인 직원의 이름(emp_name)과 부서명(dept_name)을 조회
select emp_name,
	   dept_name
from   emp
where  emp_id = 110;
 
-- EMP 테이블에서 'Sales' 부서에 속하지 않은 직원들의 ID(emp_id), 이름(emp_name),  부서명(dept_name)을 조회.
select emp_id,
	   emp_name,
	   dept_name
from   emp
where  dept_name <> 'Sales';
-- where dept_name != 'Sales';

-- EMP 테이블에서 급여(salary)가 $10,000를 초과인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select emp_id,
	   emp_name,
	   salary
from   emp
where  salary > 10000;
 
-- EMP 테이블에서 커미션비율(comm_pct)이 0.2~0.3 사이인 직원의 ID(emp_id), 이름(emp_name), 커미션비율(comm_pct)을 조회.
select emp_id,
	   emp_name,
	   comm_pct
from   emp
where  comm_pct between 0.2 and 0.3; -- 0.2, 0.3 포함

-- EMP 테이블에서 커미션을 받는 직원들 중 커미션비율(comm_pct)이 0.2~0.3 사이가 아닌 직원의 ID(emp_id), 이름(emp_name), 커미션비율(comm_pct)을 조회.
select emp_id,
	   emp_name,
	   comm_pct
from   emp
where  comm_pct not between 0.2 and 0.3;

-- EMP 테이블에서 업무(job)가 'IT_PROG' 거나 'ST_MAN' 인 직원의  ID(emp_id), 이름(emp_name), 업무(job)을 조회.
select emp_id,
	   emp_name,
	   job
from   emp
where  job in ('IT_PROG', 'ST_MAN');
-- where job = 'IT_PROG' or job = 'ST_MAN';

-- EMP 테이블에서 업무(job)가 'IT_PROG' 나 'ST_MAN' 가 아닌 직원의  ID(emp_id), 이름(emp_name), 업무(job)을 조회.
select emp_id,
	   emp_name,
	   job
from   emp
where  job not in ('IT_PROG', 'ST_MAN');
-- where job != 'IT_PROG' and job != 'ST_MAN';

/*
XX로 시작 : 'XX%'
XX로 끝 :  '%XX'
XX가 포함된 : '%XX%'
*/

-- EMP 테이블에서 직원 이름(emp_name)이 S로 시작하는 직원의  ID(emp_id), 이름(emp_name)을 조회.
select emp_id,
	   emp_name
from   emp
where  emp_name like 'S%';  -- like : 문자열 부분 일치 비교연산.   % : 0글자 이상 

-- EMP 테이블에서 직원 이름(emp_name)이 S로 시작하지 않는 직원의  ID(emp_id), 이름(emp_name)을 조회
select emp_id,
	   emp_name
from   emp
where  emp_name not like 'S%';

-- EMP 테이블에서 직원 이름(emp_name)이 en으로 끝나는 직원의  ID(emp_id), 이름(emp_name)을 조회
select emp_id,
	   emp_name
from   emp
where  emp_name like '%en';

-- EMP 테이블에서 직원 이름(emp_name)의 세 번째 문자가 “e”인 모든 사원의 이름을 조회
select emp_id,
	   emp_name
from   emp
where  emp_name like '__e%'; -- _ : 1글자  

-- EMP 테이블에서 직원의 이름에 '%' 가 들어가는 직원의 ID(emp_id), 직원이름(emp_name) 조회
	-- 패턴문자를 조회조건에서 literal로 사용해야 하는 경우 escape 구문을 이용해 패턴문자를 검색문자로 표시하는 특수문자를 지정한다.
select emp_id,
	   emp_name
from   emp
where  emp_name like '%#%%' escape '#'; -- # 패턴문자가 오면 literal

-- EMP 테이블에서 부서명(dept_name)이 null인 직원의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.
select emp_id,
	   emp_name,
       dept_name
from   emp
where  dept_name is null;

-- 부서명(dept_name) 이 NULL이 아닌 직원의 ID(emp_id), 이름(emp_name), 부서명(dept_name) 조회
select emp_id,
	   emp_name,
       dept_name
from   emp
-- where  dept_name is not null;
where  not (dept_name is null);

/*
like => not like
between a and b => not between a and b
in => not in
is => is not
*/


-- TODO : EMP 테이블에서 업무(job)가 'IT_PROG'인 직원들의 모든 컬럼의 데이터를 조회. 
select * from emp
where  job = 'IT_PROG';

-- TODO : EMP 테이블에서 업무(job)가 'IT_PROG'가 아닌 직원들의 모든 컬럼의 데이터를 조회. 
select * from emp
where  job != 'IT_PROG';

-- TODO : EMP 테이블에서 이름(emp_name)이 'Peter'인 직원들의 모든 컬럼의 데이터를 조회
select * from emp
where  emp_name = 'Peter';

-- TODO: EMP 테이블에서 급여(salary)가 $10,000 이상인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select emp_id,
	   emp_name,
       salary
from   emp
where  salary >= 10000;

-- TODO : EMP 테이블에서 급여(salary)가 $3,000 미만인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select emp_id,
	   emp_name,
       salary
from   emp
where  salary < 3000;

-- TODO : EMP 테이블에서 급여(salary)가 $3,000 이하인 직원의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select emp_id,
	   emp_name,
       salary
from   emp
where  salary <= 3000;

-- TODO : 급여(salary)가 $4,000에서 $8,000 사이에 포함된 직원들의 ID(emp_id), 이름(emp_name)과 급여(salary)를 조회
select emp_id,
	   emp_name,
       salary
from   emp
where  salary between 4000 and 8000;

-- TODO : 급여(salary)가 $4,000에서 $8,000 사이에 포함되지 않는 모든 직원들의  ID(emp_id), 이름(emp_name), 급여(salary)를 표시
select emp_id,
	   emp_name,
       salary
from   emp
where  salary not between 4000 and 8000;

-- TODO : EMP 테이블에서 2007년 이후 입사한 직원들의  ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회.
	-- 참고 : date/datatime에서 년도만 추출: year(값). ex) year('2020-10-10') => 2020
select emp_id,
	   emp_name,
       hire_date
from   emp
where  year(hire_date) > 2006;

-- TODO : EMP 테이블에서 2004년에 입사한 직원들의 ID(emp_id), 이름(emp_name), 입사일(hire_date)을 조회.
select emp_id,
	   emp_name,
       hire_date
from   emp
where  year(hire_date) = 2004;

-- TODO : EMP 테이블에서 2005년 ~ 2007년 사이에 입사(hire_date)한 직원들의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date)을 조회.
select emp_id,
	   emp_name,
       hire_date
from   emp
where  year(hire_date) between 2005 and 2007;

-- TODO : EMP 테이블에서 직원의 ID(emp_id)가 110, 120, 130 인 직원의  ID(emp_id), 이름(emp_name), 업무(job)을 조회
select emp_id,
	   emp_name,
       job
from   emp
where  emp_id in (110, 120, 130);

-- TODO : EMP 테이블에서 부서(dept_name)가 'IT', 'Finance', 'Marketing' 인 직원들의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.
select emp_id,
	   emp_name,
       dept_name
from   emp
where  dept_name in ("IT", "Finance", "Marketing");


-- TODO : EMP 테이블에서 'Sales' 와 'IT', 'Shipping' 부서(dept_name)가 아닌 직원들의 ID(emp_id), 이름(emp_name), 부서명(dept_name)을 조회.
select emp_id,
	   emp_name,
       dept_name
from   emp
where  dept_name not in("Sales", "IT", "Shipping");

-- TODO : EMP 테이블에서 업무(job)에 'SA'가 들어간 직원의 ID(emp_id), 이름(emp_name), 업무(job)를 조회
select emp_id,
	   emp_name,
       job
from   emp
where  job like "%SA%";

-- TODO : EMP 테이블에서 업무(job)가 'MAN'로 끝나는 직원의 ID(emp_id), 이름(emp_name), 업무(job)를 조회
select emp_id,
	   emp_name,
       job
from   emp
where  job like "%MAN";

-- TODO : EMP 테이블에서 커미션이 없는(comm_pct가 null인)  모든 직원의 ID(emp_id), 이름(emp_name), 급여(salary) 및 커미션비율(comm_pct)을 조회
select emp_id,
	   emp_name,
       salary,
       comm_pct
from   emp
where  comm_pct is null;

-- TODO : EMP 테이블에서 커미션을 받는 모든 직원의 ID(emp_id), 이름(emp_name), 급여(salary) 및 커미션비율(comm_pct)을 조회
select emp_id,
	   emp_name,
       salary,
       comm_pct
from   emp
where  comm_pct is not null;

-- TODO : EMP 테이블에서 관리자 ID(mgr_id)가 없는(상사가 없는) 직원의 ID(emp_id), 이름(emp_name), 업무(job), 소속부서(dept_name)를 조회
select emp_id,
	   emp_name,
       job
       dept_name
from   emp
where  mgr_id is null;

-- TODO : EMP 테이블에서 연봉(salary * 12) 이 200,000 이상인 직원들의 모든 정보를 조회.
select *
from   emp
where salary > 166667; -- 200000 / 12 = 166666.666.... 
-- where salary * 12 >= 200000;



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --



/* *************************************
 WHERE 조건이 여러개인 경우
 AND
 OR
 not
 
 참 and 참 -> 참: 조회 결과 행
 거짓 or 거짓 -> 거짓: 조회 결과 행이 아님.
 
 연산 우선순위 : and > or
 
 where 조건1 and 조건2 or 조건3
 1. 조건 1 and 조건2
 2. 1결과 or 조건3
 
 or를 먼저 하려면 where 조건1 and (조건2 or 조건3)
	-- 그렇지 않으면 where (조건1 and 조건2) or 조건3으로 연산
 **************************************/
  
--  EMP 테이블에서 업무(job)가 'SA_REP' 이고 급여(salary)가 $9,000인 직원의 직원의 ID(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 조회.
select emp_id,
	   emp_name,
       job,
       salary
from   emp
where  job = 'SA_REP' and salary = 9000; 

--  EMP 테이블에서 업무(job)가 'FI_ACCOUNT' 거나 급여(salary)가 $8,000 이상인 직원의 ID(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 조회.
select emp_id,
	   emp_name,
       job,
       salary
from   emp
where  job = 'FI_ACCOUNT' or salary >= 8000; 


-- TODO : EMP 테이블에서 부서(dept_name)가 'Sales'이고 업무(job)가 'SA_MAN'이고 급여가 $13,000 이하인 직원의 ID(emp_id), 이름(emp_name), 업무(job), 급여(salary), 부서(dept_name)를 조회
select emp_id,
	   emp_name,
       job,
       salary,
       dept_name
from   emp
where  dept_name = 'Sales' and job = 'SA_MAN' and salary <= 13000; 

-- TODO : EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 부서(dept_name)가 'Shipping' 이고 2005년이후 입사한 직원들의  ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date),부서(dept_name)를 조회
select emp_id,
	   emp_name,
       job,
       hire_date,
       dept_name
from   emp
where  job like "%MAN%" and dept_name = 'Shipping' and year(hire_date) > 2004;

-- TODO : EMP 테이블에서 입사년도가 2004년인 직원들과 (입사년도와 상관없이) 급여가 $20,000 이상인 직원들의 ID(emp_id), 이름(emp_name), 입사일(hire_date), 급여(salary)를 조회.
select emp_id,
	   emp_name,
       hire_date,
       salary
from   emp
where   year(hire_date) = 2004 or salary >= 20000;

-- TODO : EMP 테이블에서, 부서이름(dept_name)이  'Executive'나 'Shipping' 이면서 급여(salary)가 6000 이상인 사원의 모든 정보 조회. 
select * from emp
where dept_name in ('Executive', 'Shipping') and salary >= 6000;

-- TODO : EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중에서 부서이름(dept_name)이 'Marketing' 이거나 'Sales'인 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)를 조회
select emp_id,
	   emp_name,
       job,
       dept_name
from   emp
where  job like "%MAN%" and dept_name in ('Shipping', 'Sales');

-- TODO : EMP 테이블에서 업무(job)에 'MAN'이 들어가는 직원들 중 급여(salary)가 $10,000 이하이 거나 2008년 이후 입사한 직원의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date), 급여(salary)를 조회
select emp_id,
	   emp_name,
       job,
       hire_date,
       salary
from   emp
where  job like "%MAN%" and (salary <= 10000 or year(hire_date) > 2007);   



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  



/* *******************************************************************
order by를 이용한 정렬
- order by절은 select문의 마지막에 온다.
- order by 정렬기준컬럼 정렬방식 [, ...]
    - 정렬기준컬럼 지정 단위: 컬럼이름, 컬럼의순번(select절의 선언 순서), 별칭(alias) 
     select salary 급여, hire_date from emp ...
	 에서 salary 컬럼 기준 정렬을 설정할 경우. 
     order by salary 또는 1 또는 급여
    - 정렬방식
        - ASC : 오름차순, 기본방식(생략가능)
        - DESC : 내림차순
		
문자열 오름차순 : 특수문자 -> 숫자 -> 대문자 -> 소문자 -> 한글     
Date 오름차순 : 과거 -> 미래
null 오름차순 : 맨 처음에 나온다.

ex)
order by salary asc, emp_id desc
- salary로 전체 정렬을 하고 salary가 같은 행은 emp_id로 정렬.
******************************************************************* */

--  직원들의 전체 정보를 직원 ID(emp_id)가 큰 순서대로 정렬해 조회
select * from emp
order by emp_id desc;

--  직원들의 id(emp_id), 이름(emp_name), 업무(job), 급여(salary)를 업무(job) 순서대로 (A -> Z) 조회하고 업무(job)가 같은 직원들은 급여(salary)가 높은 순서대로 2차 정렬해서 조회.
select emp_id,
	   emp_name,
       job,
       salary
from   emp
order by job, salary desc; -- job을 오름차순으로 1차 정렬 후, salary를 내림차순으로 2차 정렬 (job의 값이 같은 경우 내 정렬)

-- 부서명을 부서명(dept_name)의 오름차순으로 정렬해 조회하시오.
select * from emp
order by dept_name;


-- TODO : 급여(salary)가 $5,000을 넘는 직원의 ID(emp_id), 이름(emp_name), 급여(salary)를 급여가 높은 순서부터 조회
select emp_id,
	   emp_name,
       salary
from   emp
where  salary > 5000
-- order by salary desc;
order by 3 desc; -- select 절의 3번째 컬럼을 기준으로 정렬

-- TODO : EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 입사일(hire_date)을 입사일(hire_date) 순서로 조회.
select emp_id,
	   emp_name,
       job,
       hire_date
from   emp
order by 4;

-- TODO : EMP 테이블에서 ID(emp_id), 이름(emp_name), 급여(salary), 입사일(hire_date)을 
	-- 급여(salary) 오름차순으로 정렬하고 급여(salary)가 같은 경우는 먼저 입사한(hire_date) 순서로 정렬.
select emp_id,
	   emp_name,
       salary,
       hire_date
from   emp
order by 3, 4;   
