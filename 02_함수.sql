use hr;
/* ***********************************************
단일행 함수 : 행별로 처리하는 함수. 문자/숫자/날짜/변환 함수 
	- 단일행은 selec, where절에 사용가능, 컬럼에 적용
다중행 함수 : 여러행을 묶어서 한번에 처리하는 함수 => 집계함수, 그룹함수
	- 다중행은 where절에는 사용 불가. (sub query 이용)
* ***********************************************/

/* ***************************************************************************************************************
함수 - 문자열관련 함수
 char_length(v) : v의 글자수 반환
 concat(v1, v2[, ..]) : 값들을 합쳐 하나의 문자열로 반환
 format(숫자, 소수부 자릿수) : 정수부에 단위 구분자 "," 를 표시하고 지정한 소수부 자리까지만 문자열로 만들어 반환
 upper(v), lower(v) : v를 모두 대문자/소문자 로 변환
 insert(기준문자열, 위치, 길이, 삽입문자열) : 기준문자열의 위치(1부터 시작)에서부터 길이까지 지우고 삽입문자열을 삽입
 replace(기준문자열, 원래문자열, 바꿀문자열) : 기준문자열의 원래문자열을 바꿀문자열로 반환
 left(기준문자열, 길이), right(기준문자열, 길이) : 기준문자열에서 왼쪽(left), 오른쪽(right)의 길이만큼의 문자열을 반환
 substring(기준문자열, 시작위치, 길이) : 기준문자열에서 시작위치부터 길이 개수의 글자 만큼 삭제 후 반환, 길이 생략 시 마지막까지 삭제
 substring_index(기준문자열, 구분자, 개수) : 기준문자열을 구분자를 기준으로 나눈 뒤 개수만큼 반환, 개수: 양수 – 앞에서 부터 개수,  음수 – 뒤에서 부터 개수만큼 반환
 ltrim(문자열), rtrim(문자열), trim(문자열) : 문자열에서 왼쪽(ltrim), 오른쪽(rtrim), 양쪽(trim)의 공백을 제거, 중간공백은 유지
 trim(방향  제거할문자열  from 기준문자열) : 기준문자열에서 방향에 있는 제거할문자열을 제거
									  방향: both (앞,뒤), leading (앞), trailing (뒤)
 lpad(기준문자열, 길이, 채울문자열), rpad(기준문자열, 길이, 채울문자열) : 기준문자열을 길이만큼 늘린 뒤 남는 길이만큼 채울문자열로 왼쪽(lpad), 오른쪽(rpad)에 채움.
													         기준문자열 글자수가 길이보다 많을 경우 나머지는 삭제
 *************************************************************************************************************** */

select upper('aBcDe'), lower('aBcDe');
select char_length('aaaaaa');
select format(1000000, 0); 
select format(1234567.898765);
select concat('홍길동', '님');
select concat('나이 : ', 30, ' 세');
select concat('$', format(30000, 0)); 
select insert(1234567890, 2, 5, '안녕하세요'); -- 2번째에서 5글자를 '안녕하세요'로 변경
select replace('aaaabbbaaacccaddda', a, '가'); -- a를 모두 '가'로 변경
select left('1234567890', 5); -- 대상문자열을 좌측에서 5글자를 반환
select right('1234567890', 5); -- 대상문자열을 우측에서 5글자를 반환
select substring('1234567890', 4, 3); -- 4번째 글자부터 3글자를 반환
select substring('1234567890', 4); -- 4번째 글자부터 나머지 모두 반환
select trim('     aaaaa     ') as "v"; -- 좌우공백 제거
select ltrim('     aaaaa     ') as "v"; -- 좌측공백 제거
select rtrim('     aaaaa     ') as "v"; -- 우측공백 제거
select trim(both '-' from '-----aaaaa-----') as "v"; -- 공백이외의 좌우 문자 제거
select trim(leading '-' from '-----aaaaa-----') as "v"; -- 공백이외의 좌측 문자 제거
select trim(trailing '-' from '-----aaaaa-----') as "v"; -- 공백이외의 우측 문자 제거
select lpad('abcd', 10, ' ') as "v"; -- 10글자로 글자를 채움, 모자란 곳은 좌측부터 채움
select rpad('abcd', 10, ' ') as "v"; -- 10글자로 글자를 채움, 모자란 곳은 우측부터 채움
select lpad('abcdefghijk', 5, ' ') as "v"; -- 기존 글자수가 설정한 수보다 많을 경우 설정한 수만큼만 반환


-- EMP 테이블에서 직원의 이름(emp_name)을 모두 대문자, 소문자, 이름 글자수를 조회
select upper(emp_name),
	   lower(emp_name),
       char_length(emp_name)
from   emp;


--  TODO : EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary),부서(dept_name)를 조회. 
	--  단 직원이름(emp_name)은 모두 대문자, 부서(dept_name)는 모두 소문자로 출력.
select emp_id,
	   upper(emp_name) "emp_name",
       salary,
       lower(dept_name) "dept_name"
from   emp;

-- TODO : EMP 테이블에서 직원의 이름(emp_name)이 PETER인 직원의 모든 정보를 조회하시오. (emp_name의 값들의 대소문자와 상관없이 조회)
select * from emp
where  upper(emp_name) = 'PETER';

-- TODO : 직원 이름(emp_name)의 자릿수를 15자리로 맞추고 15자가 안되는 이름의 경우 공백을 앞에 붙여 조회.
select lpad(emp_name, 15, ' ') "emp_name"
from   emp; 
    
-- TODO : EMP 테이블에서 이름(emp_name)이 10글자 이상인 직원들의 이름(emp_name)과 이름의 글자수 조회
select emp_name,
	   char_length(emp_name) "글자수"
from   emp
where  char_length(emp_name) >= 10;



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



/* **************************************************************************
함수 - 숫자관련 함수
 abs(값) : 절대값 반환
 round(값, 자릿수) : 자릿수이하에서 반올림 (양수 - 실수부, 음수 - 정수부, 기본값: 0-0이하에서 반올림이므로 정수로 반올림)
 truncate(값, 자릿수) : 자릿수이하에서 절삭-버림(자릿수: 양수 - 실수부, 음수 - 정수부, 기본값: 0)
 ceil(값) : 값보다 큰 정수중 가장 작은 정수. 소숫점 이하 올린다. 
 floor(값) : 값보다 작은 정수중 가장 작은 정수. 소숫점 이하를 버린다. 내림
 sign(값) : 숫자 n의 부호를 정수로 반환(1-양수, 0, -1-음수)
 mod(n1, n2) : n1 % n2
************************************************************************** */

select abs(-20);
select sign(-10), sign(0), sign(10);

-- ceil/floor : 자리수 지정 불가, 결과값은 항상 정수로 출력
select ceil(4.321), ceil(9.876);
select floor(4.321), floor(9.876);

-- round()/truncate() : 자리수 지정 가능 
select round(50.12), -- 정수, 위치의 자리가 0(1의 자리)
	   round(50.56),
       round(50.56789, 2), -- 소수점 2번째 자리 아래에서 반올림
       round(50.56789, 0),
       round(567890.56789, -2);

select truncate(50.12, 0),  
	   truncate(50.67, 0), -- 내림 
       truncate(50.234567, 0),
       truncate(567890.56789, -2);


-- TODO : EMP 테이블에서 각 직원에 대해 직원ID(emp_id), 이름(emp_name), 급여(salary) 그리고 15% 인상된 급여(salary)를 조회하는 질의를 작성하시오.
	-- (단, 15% 인상된 급여는 올림해서 정수로 표시하고, 별칭을 "SAL_RAISE"로 지정.)
select emp_id,
	   emp_name,
       salary,
       ceil(salary * 1.15) "SAL_RAISE"
from emp;

-- TODO : 위의 SQL문에서 인상 급여(sal_raise)와 급여(salary) 간의 차액을 추가로 조회 
	-- (직원ID(emp_id), 이름(emp_name), 15% 인상급여, 인상된 급여와 기존 급여(salary)와 차액)
select emp_id,
	   emp_name,
       ceil(salary * 1.15) "SAL_RAISE",
       ceil(salary * 1.15) - salary "SAL_SUB"
from emp;

--  TODO : EMP 테이블에서 커미션이 있는 직원들의 직원_ID(emp_id), 이름(emp_name), 커미션비율(comm_pct), 커미션비율(comm_pct)을 8% 인상한 결과를 조회.
	-- (단 커미션을 8% 인상한 결과는 소숫점 이하 2자리에서 반올림하고 별칭은 comm_raise로 지정)
select emp_id,
	   emp_name,
       comm_pct,
       round(comm_pct * 1.08, 2) "comm_raise"
from emp
where comm_pct is not null;



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



/* ***************************************************************************************************************
함수 - 날짜관련 계산 및 함수
date/time/datetime : +, - 사용 => date(일), time(시간), datetime(초)의 값을 +/- => 계산 결과가 정수형으로 반환된다.

now() : 현재 datetime
curdate() : 현재 date
curtime() : 현재 time
year(날짜), month(날짜), day(날짜) : 날짜 또는 일시의 년, 월, 일 을 반환한다.
hour(시간), minute(시간), second(시간), microsecond(시간) : 시간 또는 일시의 시, 분, 초, 밀리초를 반환한다.
date(), time() : datetime 에서 날짜(date), 시간(time)만 추출한다.

날짜 연산
adddate/subdate(DATETIME/DATE/TIME,  INTERVAL 값  단위)
	날짜에서 특정 일시만큼 더하고(add) 빼는(sub) 함수.
    단위: MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER(분기-3개월), YEAR
timestampdiff(옵션, 일시 1, 일시 2) : [일시2 - 일시1]를 옵션 기준으로 계산
datediff(날짜1, 날짜2) : [날짜1 – 날짜2] 일수를 반환
timediff(시간1, 시간2) : [시간1 - 시간2] 한 시간을 계산해서 반환 (뺀 결과를 시:분:초 로 반환)
dayofweek(날짜) : 날짜의 요일을 정수로 반환 (1 : 일요일 ~ 7 : 토요일)

date_format(일시, 형식문자열): 일시를 원하는 형식의 문자열로 반환
*************************************************************************************************************** */

select adddate(now(), interval 2 day); -- now에서 2일 후 
select subdate(now(), interval 2 day); -- now에서 2일 전
select datediff(now(), '2021-05-26'); -- now에서 2021-05-26을 뺀 날
select timediff(curtime(), '11:40:50'); -- 현재시각과 설정시간의 차
select date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초 %W');

-- TODO: EMP 테이블에서 부서이름(dept_name)이 'IT'인 직원들의 '입사일(hire_date)로 부터 10일 전', 입사일, '입사일로 부터 10일 후' 의 날짜를 조회. 
select adddate(hire_date, interval -10 day) "10일 전",
	   hire_date,
       adddate(hire_date, interval 10 day) "10일 후"
from   emp
where  dept_name = 'IT';

-- TODO : 부서가 'Purchasing' 인 직원의 이름(emp_name), 입사 6개월 전과 입사일(hire_date), 6개월 후 날짜를 조회.
select emp_name,
	   adddate(hire_date, interval -6 month) "입사 6개월 전",
       hire_date,
       adddate(hire_date, interval 6 month) "입사 6개월 후"
from   emp
where  dept_name = 'Purchasing';

-- TODO : ID(emp_id)가 200인 직원의 이름(emp_name), 입사일(hire_date)를 조회. 입사일은 yyyy년 mm월 dd일 형식으로 출력.
select emp_name,
       date_format(hire_date, '%Y년 %m월 %d일') "hire_date"
from   emp
where  emp_id = 200;

--  TODO : 각 직원의 이름(emp_name), 근무 개월수 (입사일에서 현재까지의 달 수)를 계산하여 조회. 근무개월수 내림차순으로 정렬.
select emp_name,
       timestampdiff(month, hire_date, curdate()) "근무개월수"
from emp
order by 2 desc;

-- TODO : ID(emp_id)가 100인 직원이 입사한 요일을 조회
select concat(substring('월화수목금토일', dayofweek(hire_date), 1), '요일') "입사요일"
from   emp
where  emp_id = 100;



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



/* *************************************************************************************
함수 - 조건 처리함수
ifnull (기준컬럼(값), 기본값) : 기준컬럼(값)이 NULL값이면 기본값을 출력하고 NULL이 아니면 기준컬럼 값을 출력
if (조건수식, 참, 거짓) : 조건수식이 True이면 참을 False이면 거짓을 출력한다.
nullif(컬럼1, 컬럼2) : 컬럼1과 컬럼2가 같으면 NULL을 반환, 다르면 컬럼1을 반환
coalesce(ex1, ex2, ex3, .....) : ex1 ~ exn 중 null이 아닌 첫번째 값 반환.
************************************************************************************* */

select ifnull(null, '기본값');
select ifnull(20, '기본값');
select comm_pct, ifnull(comm_pct, 0) from emp;

select if(1 != 0, 'True', 'False');
select if(comm_pct is null, '커미션 없음', comm_pct) from emp;

select nullif(10, 20);
select nullif(10, 10);
select ifnull(nullif(10, 10), '같은 값');

select coalesce(null, null, null, 10, 20, 30);

-- TODO : EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 업무(job), 부서(dept_name)을 조회. 부서가 없는 경우 '부서미배치'를 출력.
select emp_id,
	   emp_name,
       job,
       ifnull(dept_name, '부서미배치') "dept_name"
from emp;

-- TODO: EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 커미션 (salary * comm_pct)을 조회. 커미션이 없는 직원은 0이 조회되록 한다.
select emp_id,
	   emp_name,
       salary,
       salary * ifnull(comm_pct, 0) "salary * comm_pct"
from emp;



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



/* *************************************
CASE 문
case문 동등비교
case 컬럼 when 비교값 then 출력값
              [when 비교값 then 출력값]
              [else 출력값]
              end
              
case문 조건문
case when 조건 then 출력값
       [when 조건 then 출력값]
       [else 출력값]
       end

************************************* */

select dept_name,
	   case ifnull(dept_name, 1) when 'IT' then '전산실'
								 when 'Finance' then '회계부'
                                 when 1 then '부서 없음'
								 else dept_name
	   end as "부서명"
from emp;	

/*
if dept_name==null:
    return '부서없음'
elif dept_name=='IT':
    return '전산실'
elif dept_name=='Finance':
    return '회계부'
else:
    return dept_name    
*/

-- EMP테이블에서 급여와 급여의 등급을 조회하는데 급여 등급은 10000이상이면 '1등급', 10000미만이면 '2등급' 으로 나오도록 조회
select salary,
	   case when salary >= 10000 then '1등급'
			else '2등급'
	   end as "salary level"
from   emp;


-- TODO : EMP 테이블에서 업무(job)이 'AD_PRES'거나 'FI_ACCOUNT'거나 'PU_CLERK'인 직원들의 ID(emp_id), 이름(emp_name), 업무(job)을 조회.  
	-- 업무(job)가 'AD_PRES'는 '대표', 'FI_ACCOUNT'는 '회계', 'PU_CLERK'의 경우 '구매'가 출력되도록 조회
select emp_id,
	   emp_name,
       case job when 'AD_PRES' then '대표'
				when 'FI_ACCOUNT' then '회계'
                when 'PU_CLERK' then '구매'
	   end as "job"
from   emp
where job in ('AD_PRES', 'FI_ACCOUNT', 'PU_CLERK');

-- TODO : EMP 테이블에서 부서이름(dept_name)과 급여 인상분을 조회.
	-- 급여 인상분은 부서이름이 'IT' 이면 급여(salary)에 10%를 'Shipping' 이면 급여(salary)의 20%를 'Finance'이면 30%를 나머지는 0을 출력
select dept_name,
	   case dept_name when 'IT' then salary * 0.1
					  when 'Shipping' then salary * 0.2
                      when 'Finance' then salary * 0.3
                      else 0
	   end as "급여 인상분"
from   emp;

-- TODO : EMP 테이블에서 직원의 ID(emp_id), 이름(emp_name), 급여(salary), 인상된 급여를 조회한다. 
	-- 단 급여 인상율은 급여가 5000 미만은 30%, 5000이상 10000 미만는 20% 10000 이상은 10% 로 한다.
select emp_id,
	   emp_name,
       salary,
	   case when salary < 5000 then salary * 1.3
			when salary between 5000 and 9999 then salary * 1.2
            else salary * 1.1
	   end as "인상 급여"
from   emp;


--  case 를 이용한 정렬
	--  직원들의 모든 정보를 조회한다. 단 정렬은 업무(job)가 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' 순서대로 먼저나오도록 한다. (나머지 JOB은 상관없음)
select * from emp
order by case job when 'ST_CLERK' then 1
				  when 'IT_PROG' then 2
                  when 'PU_CLERK' then 3
                  when 'SA_MAN' then 4
                  else job
                  end;