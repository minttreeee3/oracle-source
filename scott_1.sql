-- 2. 숫자함수
-- 1) ROUND, TRUNC, CEIL, FLOOR, MOD 

-- round : 반올림
-- round(숫자, 반울림 위치(선택)) 
SELECT
    round(1234.5678)      AS round,       --소수점 첫째 자리에서 반올림
    round(1234.5678, 0)   AS round0,               --소수점 첫째 자리에서 반올림
    round(1234.5678, 1)   AS round1,               --소수점 둘째 자리에서 반올림
    round(1234.5678, 2)   AS round2,               --소수점 셋째 자리에서 반올림
    round(1234.5678, - 1) AS round_minus1,    --자연수 첫째 자리에서 반올림
    round(1234.5678, - 2) AS round_minus2      --자연수 둘째 자리에서 반올림
FROM
    dual;

-- trunc : 특정위치에서 버리는 함수
-- trunc(숫자, 반울림 위치(선택)) 
SELECT
    trunc(1234.5678)      AS trunc,       --소수점 첫째 자리에서 버림
    trunc(1234.5678, 0)   AS trunc0,               --소수점 첫째 자리에서 버림
    trunc(1234.5678, 1)   AS trunc1,               --소수점 둘째 자리에서 버림
    trunc(1234.5678, 2)   AS trunc2,               --소수점 셋째 자리에서 버림
    trunc(1234.5678, - 1) AS trunc_minus1,    --자연수 첫째 자리에서 버림
    trunc(1234.5678, - 2) AS trunc_minus2      --자연수 둘째 자리에서 버림
FROM
    dual;

-- ceil(숫자), floor(숫자) : 입력된 숫자와 가장 가까운 큰 정수 / 작은 정수 
SELECT
    ceil(3.14),
    floor(3.14),
    ceil(- 3.14),
    floor(- 3.14)
FROM
    dual;


-- mod(숫자, 나눌수) : 나머지값 (자바에서의 %) 
SELECT
    mod(15, 6),
    mod(10, 2),
    mod(11, 2)
FROM
    dual;



-- 날짜 함수
-- 날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일수 이후의 날짜 
-- 날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이
-- 날짜 데이터 + 날짜 데이터 : 연산불가능

-- 1) sysdate 함수 : 오라클 데이터베이스 서버가 설치된 os의 현재날짜와 시간을 가져옴
SELECT
    sysdate,
    sysdate - 1 AS yesterday,
    sysdate + 1 AS tomorrow
FROM
    dual;
    
-- 2) add_months(날짜, 더할 개월수) : 몇 개월 이후 날짜 구하기
SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;

-- 입사 50주년이 되는 날짜 구하기
-- empno, ename, hiredate, 입사50주년날짜 조회
SELECT
    empno,
    ename,
    hiredate,
    add_months(hiredate, 600)
FROM
    emp;
    
-- 3) MONTHS_BETWEEN (첫번째날짜, 두번째날짜) : 두 날짜 데이터간의 날짜 차이를 개월수로 계산하여 출력
  
-- 입사 45년 미만인 사원데이터 조회
-- empno, ename, hiredate

SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;

-- 현재 날짜와 6개월 후 날짜가 출력
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    dual;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS months1,
    months_between(sysdate, hiredate)        AS months2,
    trunc(months_between(sysdate, hiredate)) AS months3
FROM
    emp;

-- 4) next_day(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
-- last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
SELECT
    sysdate,
    next_day(sysdate, '금요일'),
    last_day(sysdate)
FROM
    dual;

-- 날짜의 반올림, 버림 : ROUND, TRUNC
-- CC : 네 자리 연도의 끝 두자리를 기준으로 사용 
--  2023년인 경우 2050이하이므로 2001년으로 처리
SELECT
    sysdate,
    round(sysdate, 'CC')   AS format_cc,
    round(sysdate, 'YYYY') AS format_yyyy,
    round(sysdate, 'DDD')  AS format_ddd,
    round(sysdate, 'HH')   AS format_hh
FROM
    dual;



-- 형변환 함수 : 자료형을 형 변환
-- NUMBER, VARCHAR2, DATE

SELECT
    empno,
    ename,
    empno + '500'    -- 자동형변환 일어나서 연산됨
FROM
    emp
WHERE
    ename = 'FORD';

SELECT
    empno,
    ename,
    'abcd' + empno    -- 문자+숫자는 안됨 오류남
FROM
    emp
WHERE
    ename = 'FORD';


-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
-- TO_NUMBER() : 문자 데이터를 숫자 데이터로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

-- 원하는 출력형태로 날짜출력하기 : TO_CHAR 주로사용됨
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
FROM
    dual;
    
-- MON, MONTH : 월이름
-- DDD : 365일 중에서 며칠
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD')    AS 현재날짜,
    to_char(sysdate, 'YYYY')          AS 현재연도,
    to_char(sysdate, 'MM')            AS 현재월,
    to_char(sysdate, 'MON')           AS 현재월2,
    to_char(sysdate, 'DD')            AS 현재일자,
    to_char(sysdate, 'DDD')           AS 현재일자2,
    to_char(sysdate, 'HH12:MI:SS AM') AS 현재시간
FROM
    dual;

-- SAL 필드에 , 나 통화 표시를 하고 싶다면?
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l
FROM
    emp;


-- TO_NUMBER(문자열데이터, '인식할 숫자형태')
SELECT
    1300 - '1500',
    '1300' + 1500
FROM
    dual;

SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')       -- ,가 들어가면 문자임
FROM
    dual;
    
-- TO_DATE(문자열데이터, '인색될 날짜 형태')
SELECT
    TO_DATE('2018-07-18', 'YYYY-MM-DD') AS todate1,
    TO_DATE('20210708', 'YYYY-MM-DD')   AS todate2
FROM
    dual;

SELECT
    TO_DATE('2023-03-21') - TO_DATE('2023-02-01')
FROM
    dual;



-- 널처리 함수
-- NULL + 300 => NULL

-- NVL(데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + comm,
    nvl(comm, 0),
    sal + nvl(comm, 0)
FROM
    emp;

-- NVL2(데이터, 널이 아닐경우 반환할 데이터, 널일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    comm,
    nvl2(comm, 'O', 'X'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;

-- DECODE 함수 / CASE 문
-- DECODE (검사대상이 될 데이터, 조건1, 조건1이 일치할때 실행할 구문... 나열) 
-- EMP테이블에 직책이 MANAGER인 사람은 급여의 10%인상, SALESMAN인 사람은 5%, ANALYST인 사람은 그대로, 나머지는 3%인상된 급여 출력

SELECT
    empno,
    ename,
    job,
    sal,
    decode(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05,
           'ANALYST', sal, sal * 1.03) AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE job
        WHEN 'MANAGER'  THEN
            sal * 1.1
        WHEN 'SALESMAN' THEN
            sal * 1.05
        WHEN 'ANALYST'  THEN
            sal
        ELSE
            sal * 1.03
    END AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE
        WHEN comm IS NULL THEN
            '해당사항 없음'
        WHEN comm = 0 THEN
            '수당없음'
        WHEN comm > 0 THEN
            '수당 : ' || comm
    END AS comm_text
FROM
    emp;
    





-- 다중행(집계) 함수 : SUM, COUNT, MAX, MIN, AVG

--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
SELECT
    SUM(sal)
FROM
    emp;

SELECT
    SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;

--SUM() : NULL은 알아서 제외하고 합계를 구해줌
SELECT
    SUM(comm)
FROM
    emp;

SELECT
    COUNT(sal)
FROM
    emp;


--COUNT() : NULL은 제외하고 갯수를 세어줌
SELECT
    COUNT(comm)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp
WHERE
    deptno = 30;


-- MAX
SELECT
    MAX(sal)
FROM
    emp;
-- MAX에 날짜넣으면 최신날짜가 나옴
SELECT
    MAX(hiredate)
FROM
    emp;

--부서번호가 20인 사원중에 제일 오래된 입사일
SELECT
    MIN(hiredate)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal)
FROM
    emp;




-- GROUP BY : 결과 값을 원하는 열로 묶어 출력
-- GROUB BY에 쓴것만 SELECT 에 쓸수있음

-- 부서별 SAL 평균 구하기
SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 10;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    AVG(sal),
    deptno
FROM
    emp
GROUP BY
    deptno;

-- 부서별 추가수당 평균 구하기
SELECT
    deptno,
    AVG(comm)
FROM
    emp
GROUP BY
    deptno;


-- GROUP BY + HAVING : GROUP BY절에 조건을 줄때
-- HAVING : 그룹화된 대상에 출력제한 걸때

-- 각 부서의 직책별 평균급여구하기 (단, 평균급여가 2000이상인 그룹만 출력)
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000        --그룹함수 조건은 WHERE로 못함 
ORDER BY
    deptno,
    job;

-- 1)from구문실행  2)where실행  3)group by  4)having  5)select  6)order by 
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
WHERE
    sal <= 3000
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

