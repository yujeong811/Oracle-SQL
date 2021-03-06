2022-0111-02)숫자함수
 1)수학적 함수
  - ABS, SIGN, SQRT, POWER 등이 제공
  - ABS(n1) : n1의 절대값
  - SIGN(n1) : n1의 부호에 따라 양수이면 1, 음수이면 -1, 0이면 0을 반환
  - SQRT(n1) : n1의 평방근 값 반환 --루트값
  - POWER(n1,n2) : n1의 n2승 값 
  
사용예)
  SELECT ABS(100), ABS(-100),
         SIGN(-9000), SIGN(-0.0009), SIGN(100000), SIGN(0.000001), SIGN(0),
         SQRT(10), SQRT(81),
         POWER(2,10), POWER(2,32)
    FROM DUAL;
    
 2)GREATEST(n1[,n2,...]), LEAST(n1[,n2,...])
   - GREATEST(n1[,n2,...]) : 제시된 n1[,n2,...]에서 가장 큰 값을 반환
   - LEAST(n1[,n2,...]) : 제시된 n1[,n2,...]에서 가장 작은 값을 반환

 사용예) 
   SELECT GREATEST(100,500,20),
          GREATEST('홍길동','홍길순','강감찬')  --첫글자부터 비교 홍 > 강 / 동 < 순
     FROM DUAL;
     
 사용예)회원테이블에서 마일리지가 1000이하인 회원의 마일리지를 1000으로 바꾸어 조회하시오
       Alias는 회원번호, 회원명, 직업, 마일리지이다.
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명, 
              MEM_JOB AS 직업, 
              MEM_MILEAGE AS 원본마일리지,
              GREATEST(MEM_MILEAGE, 1000) AS 마일리지
         FROM MEMBER;
      
       SELECT MAX(MEM_MILEAGE),
              MIN(MEM_MILEAGE)
         FROM MEMBER;
   
 3)ROUND(n1,1), TRUNC(n1,1)
  - ROUND(n1,1) : 제시된 수 n1에서 소숫점이하 1+1번째 자리에서 반올림하여 1자리까지 반환
  - TRUNC(n1,1) : 제시된 수 n1에서 소숫점이하 1+1번째 자리에서 내림하여 1자리까지 반환
  - 1이 생략되면 0으로 간주
  - 1이 음수이면 정수(소숫점이상)부분의 1번째 자리에서 반올림(ROUND) 또는 내림(TRUNC)
   
 4)FLOOR(n1), CEIL(n1)
   - FLOOR(n1) : n1과 같거나 작은수 중 제일 큰 정수
   - CEIL(n1) : n1과 같거나 큰수 중 제일 작은 정수 => 소숫점 이하의 값이 존재하면 무조건 반올림한 값 반환 
   - 급여, 세금 등 금액에 관련된 항목에 주로 사용
   
사용예)
  SELECT FLOOR(12.987), FLOOR(12), FLOOR(-12.987), FLOOR(-12),
         CEIL(12.987), CEIL(12), CEIL(-12.987), CEIL(-12)
    FROM DUAL;
    
 5)MOD(n1, e), REMAINDER(n1, e)
   - MOD(n1, e) : n1을 e로 나눈 나머지 반환
   - REMAINDER(n1, e) : n1을 e로 나눈 몫의 소숫점이하가 0.5보다 크면(나머지가 e의 중간값보다 크면) 다음 몫이 되기위한 값 반환
   - 내부적 처리 방법이 상이
   - MOD : 나머지 = n1 - e * FLOOR(n1 / e)
   - REMAINDER : 나머지 = n1 - e * ROUND(n1 / e)
   
  ex) MOD(15, 4)
      15 - 4 * FLOOR(15 / 4)
      15 - 4 * FLOOR(3.75)
      15 - 4 * 3
      15 - 12 = 3
      
      REMAINDER(15, 4)
      15 - 4 * ROUND(15 / 4)
      15 - 4 * ROUND(3.75)
      15 - 4 * 4
      15 - 16 = -1      
      
  ex) MOD(13, 4)
      13 - 4 * FLOOR(13 / 4)
      13 - 4 * FLOOR(3.25)
      13 - 4 * 3
      13 - 12 = 1
      
      REMAINDER(13, 4)
      13 - 4 * ROUND(13 / 4)
      13 - 4 * ROUND(3.25)
      13 - 4 * 3
      13 - 12 = 1     
   
 사용예)
   SELECT CASE MOD((TRUNC(SYSDATE) - TO_DATE('00010101')-1),7)
               WHEN 0 THEN '일요일'
               WHEN 1 THEN '월요일'
               WHEN 2 THEN '화요일'
               WHEN 3 THEN '수요일'
               WHEN 4 THEN '목요일'
               WHEN 5 THEN '금요일'
               ELSE '토요일'
          END AS 요일
     FROM DUAL;
     
 5)WIDTH_BUCKET(val,min,max,b) --하한 값은 범위에 포함되지만, 상한 값은 범위에 포함되지 않음   
   - 하한 값 min에서 상한 값 max를 b개의 구간으로 나누었을때 제시된 값 val이 어느 구간에 속하는지를 판단하여 구간의 index를 반환
   
 사용예)회원테이블에 각 회원들의 마일리지를 입력받아 마일리지 1000~9000 사이를 9개 구간으로 구분할때 그 값이 어느구간에 속하는지 판별하시오.
       Alias는 회원번호, 회원명, 마일리지, 구간값
       SELECT MEM_ID AS 회원번호, 
              MEM_NAME AS 회원명, 
              MEM_MILEAGE AS 마일리지, 
              WIDTH_BUCKET(MEM_MILEAGE,1000,9000,9) AS 구간값 
         FROM MEMBER;
   
 사용예)회원테이블에 각 회원들의 마일리지를 입력받아 마일리지 1000~9000 사이를 9개 구간으로 구분할때 그 값이 어느구간에 속하는지 판별하여
       등급을 나타내시오. 단, 많은 마일리지를 가지고 있는 회원이 1등급임
       Alias는 회원번호, 회원명, 마일리지, 등급   
       SELECT MEM_ID AS 회원번호, 
              MEM_NAME AS 회원명, 
              MEM_MILEAGE AS 마일리지, 
              WIDTH_BUCKET(MEM_MILEAGE,9000,1000,9) AS 등급 
           -- 10 - WIDTH_BUCKET(MEM_MILEAGE,1000,9000,9) AS 등급 
         FROM MEMBER;   
   
 사용예)사원테이블에서 사원들의 급여가 2000-5000 사이에 속하면 '저임금 사원', 5001-10000 사이에 속하면 '평균임금 사원',
       10001-25000 사이에 속하면 '고임금 사원'을 비고난에 출력하시오
       Alias는 사원번호, 사원명, 부서코드, 직무코드, 급여
       SELECT EMPLOYEE_ID AS 사원번호, 
              FIRST_NAME||' '||LAST_NAME AS 사원명,
              DEPARTMENT_ID AS 부서코드,
              JOB_ID AS 직무코드,
              SALARY AS 급여,
              CASE WIDTH_BUCKET(SALARY,1,25000,5)
                   WHEN 1 THEN '저임금 사원'
                   WHEN 2 THEN '평균임금 사원'
                   ELSE '고임금 사원'
              END AS 비고      
         FROM HR.EMPLOYEES;
  