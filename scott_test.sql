-- [실습1] 
--EMP테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 하루 근무시간을 8시간으로 보았을 때 사원들의 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여 결과를 출력한다. 
--단, 하루 급여는 소수점 셋째자리에서 버리고, 시급은 두번째 소수점에서 반올림

SELECT
    empno,
    ename,
    sal,
    trunc(sal / 21.5, 2)      AS day_pay,
    round(sal /(21.5 * 8), 1) AS time_pay
FROM
    emp;
    

-- [실습2]
-- EMP테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원들이 정직원이 되는 날짜(R-JOB)를 YYYY-MM-DD형식으로 아래와 같이 출력하시오.
-- 단, 추가수당이 없는 사원의 추가수당은 N/A로 출력


SELECT
    empno,
    ename,
    hiredate,
    to_char(next_day(add_months(hiredate, 3), '월요일'), 'YYYY-MM-DD') AS r_job,
    nvl(to_char(comm), 'N/A')       --NVL 쓸때 양쪽 타입이 같아야됨 
FROM
    emp;


-- [실습3]
-- EMP테이블의 모든 사원을 대상으로 직속 상관의 사원 번호(MGR)를 다음과 같은 조건을 기준으로 변환해서 CHG_MGR열에 출력하시오

SELECT EMPNO, ENAME, MGR,
CASE
WHEN MGR IS NULL THEN '0000'
WHEN SUBSTR(TO_CHAR(MGR),1,2)='75' THEN '5555'
WHEN SUBSTR(TO_CHAR(MGR),1,2)='76' THEN '6666'
WHEN SUBSTR(TO_CHAR(MGR),1,2)='77' THEN '7777'
WHEN SUBSTR(TO_CHAR(MGR),1,2)='78' THEN '8888'
ELSE TO_CHAR(MGR)
END AS CHG_MGR
FROM EMP;



SELECT
    empno,
    ename,
   MGR,
    decode(SUBSTR(TO_CHAR(MGR),1,2), NULL, '0000', '75', '5555','76','6666','77','7777','78','8888',SUBSTR(TO_CHAR(MGR),1 ) AS CHG_MGR
FROM
    emp;
    
    
-- [실습1]
-- 부서번호, 평균급여, 최고급여, 최저급여, 사원수 출력
select deptno, floor(avg(sal)) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(deptno)
from emp
group by deptno
order by deptno desc;

-- [실습2]
-- 같은 직책에 종사하는 사원이 3명이상인 직책과 인원수를 출력
select job, count(*) 
from emp
group by job
having count(job)>=3; 

-- [실습3] 
select to_char(hiredate,'yyyy') as hire_year, deptno, count(*) as cnt
from emp
group by to_char(hiredate,'yyyy'), deptno;



