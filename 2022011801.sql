2022-0118-01) TABLE JOIN
 - 데이터베이스 설계에 정규화 과정을 수행하면 테이블이 분활되고 필요한 자료를 조회하기 위해 복수개의 테이블이
   공통의 컬럼을 기준으로 연산에 참여 해야함 => 조인 연산
 - 관계형 데이터 베이스의 기본연산
 - 종류
  * 내부조인(INNER JOIN)과 외부조인(OUTER JOIN)
  * 일반조인과 ANSI JOIN
  * 동등조인(EQUI JOIN)과 비동등조인(NON EQUI JOIN)  --대부분의 조인 : 동등 조인
  
 1. Cartesian Product 
  - 조인조건이 생략되었거나 잘못 기술된 경우 
  - ANSI JOIN 에서는 Cross Join 이라고 함
  - 조인의 결과는 최악의 경우 행의 수를 곱의 결과와 열의 수를 더한 결과 반환
  - 불가피하게 필요한 경우가 아니면 사용하지 말아야 함
  
 (사용형식)
  SELECT 컬럼list 
    FROM 테이블명1 [별칭1],테이블명2 [별칭2][,테이블명3 [별칭3],...]
   WHERE 조인조건1       --테이블의 갯수가 n개일때 조인은 최소한 n-1개가 나와야 한다
    [AND 조인조건2, ...]
     AND 일반조건]
     
 (CROSS JOIN문 형식)  
  SELECT 컬럼list 
    FROM 테이블명1 [별칭1]
   CROSS JOIN 테이블명2[별칭2]
  [CROSS JOIN 테이블명3[별칭3] 
                    :
  [WHERE 일반조건];
  
 사용예)
   SELECT COUNT(*) FROM CART;
   SELECT COUNT(*) FROM PROD;
   SELECT 207 * 74 FROM DUAL;
   
   SELECT COUNT(*) 
     FROM CART, PROD, BUYPROD;
  --WHERE CART_QTY != PROD_QTYSALE;
    
   SELECT COUNT(*)
     FROM CART
    CROSS JOIN PROD
    CROSS JOIN BUYPROD;
    
 2. Equi Join --대부분의 조인
  - 조인조건문에 동등연산자('=')가 사용
  - 사용된 테이블의 수가 N개일때 조인조건은 적어도 N-1개 이상 이어야 함
  - ANSI에서는 INNER JOIN 사용을 권고함
  
  (기술형식-일반 조인문)
   SELECT [테이블명.|테이블별칭.]컬럼명 [AS 컬럼별칭][,]
                            :
          [테이블명.|테이블별칭.]컬럼명 [AS 컬럼별칭]
     FROM 테이블명[별칭],테이블명[별칭][,테이블명[별칭],...]
    WHERE 조인조건
     [AND 조인조건]
          :
     [AND 일반조건];
     
  (기술형식-ANSI 조인문)
   SELECT [테이블명.|테이블별칭.]컬럼명 [AS 컬럼별칭][,]
                            :
          [테이블명.|테이블별칭.]컬럼명 [AS 컬럼별칭]
     FROM 테이블명1[별칭]
    INNER JOIN 테이블명2[별칭] ON(조인조건 [AND 일반조건])
   [INNER JOIN 테이블명3[별칭] ON(조인조건 [AND 일반조건])]
   [WHERE 일반조건];    
    - 테이블명1과 테이블명2는 반드시 조인 가능해야함
     
 사용예)상품테이블과 분류테이블을 이용하여 판매가가 10만원 이상인 상품을 조회하시오.
       Alias는 상품코드,상품명,분류코드,분류명,판매가
     (일반 JOIN)
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              A.PROD_LGU AS 분류코드,
              B.LPROD_NM AS 분류명,
              A.PROD_PRICE AS 판매가
         FROM PROD A, LPROD B
        WHERE A.PROD_PRICE >= 100000   --일반조건
          AND A.PROD_LGU = B.LPROD_GU  --조인조건
        ORDER BY 5 DESC;
     
     (ANSI JOIN)
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              A.PROD_LGU AS 분류코드,
              B.LPROD_NM AS 분류명,
              A.PROD_PRICE AS 판매가
         FROM PROD A
        INNER JOIN LPROD B ON(A.PROD_LGU = B.LPROD_GU
          AND A.PROD_PRICE >= 100000)
        ORDER BY 5 DESC;
        
 사용예)2005년 6월 회원별 구매현황을 조회하시오
       Alias는 회원번호,회원명,구매금액합계
     (일반 JOIN)       
       SELECT A.CART_MEMBER AS 회원번호,
              B.MEM_NAME AS 회원명,
              SUM(A.CART_QTY * C.PROD_PRICE) AS 구매금액합계
         FROM CART A, MEMBER B, PROD C
        WHERE A.CART_MEMBER = B.MEM_ID  --조인조건 : 회원명 추출
          AND A.CART_PROD = C.PROD_ID   --조인조건 : 단가 추출
          AND A.CART_NO LIKE '200506%'  --일반조건
        GROUP BY A.CART_MEMBER, B.MEM_NAME;
        
     (ANSI JOIN)
       SELECT A.CART_MEMBER AS 회원번호,
              B.MEM_NAME AS 회원명,
              SUM(A.CART_QTY * C.PROD_PRICE) AS 구매금액합계
         FROM CART A
        INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID)
        INNER JOIN PROD C ON(C.PROD_ID = A.CART_PROD
          AND A.CART_NO LIKE '200506%')
     -- WHERE A.CART_NO LIKE '200506%'  --일반조건
        GROUP BY A.CART_MEMBER, B.MEM_NAME;

 사용예)미국내에 위치한 부서별 인원수와 평균임금을 조회하시오
       Alias 부서코드,부서명,인원수,평균임금
     (일반 JOIN)         
       SELECT A.DEPARTMENT_ID AS 부서코드,
              B.DEPARTMENT_NAME AS 부서명,
              COUNT(*) AS 인원수,
              ROUND(AVG(A.SALARY)) AS 평균임금
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
     (ANSI JOIN)
       SELECT A.DEPARTMENT_ID AS 부서코드,
              B.DEPARTMENT_NAME AS 부서명,
              COUNT(*) AS 인원수,
              ROUND(AVG(A.SALARY)) AS 평균임금
         FROM HR.EMPLOYEES A
        INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
       
 문제]2005년 1월 ~ 6월 각 거래처별 매입현황을 조회하시오.
     Alias 거래처코드,거래처명,매입금액합계  --BUYPROD, BUYER
     (일반 JOIN)   
       SELECT A.BUYER_ID AS 거래처코드,
              A.BUYER_NAME AS 거래처명,
              SUM(C.BUY_QTY * C.BUY_COST) AS 매입금액합계
         FROM BUYER A, PROD B, BUYPROD C
        WHERE A.BUYER_ID = B.PROD_BUYER
          AND B.PROD_ID = C.BUY_PROD
          AND C.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
        GROUP BY A.BUYER_ID, A.BUYER_NAME
        ORDER BY 1;
        
     (ANSI JOIN)      
       SELECT A.BUYER_ID AS 거래처코드,
              A.BUYER_NAME AS 거래처명,
              SUM(C.BUY_QTY * C.BUY_COST) AS 매입금액합계
         FROM BUYER A
        INNER JOIN PROD B ON(A.BUYER_ID = B.PROD_BUYER)
        INNER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD)
          AND C.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
        GROUP BY A.BUYER_ID, A.BUYER_NAME
        ORDER BY 1;
        
 문제]2005년 4월 ~ 6월 각 상품별 매출현황을 조회하시오.
     Alias는 상품코드, 상품명, 매출수량합계, 매출금액합계
     (일반 JOIN)     
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              SUM(B.CART_QTY) AS 매출수량합계,
              SUM(B.CART_QTY * A.PROD_PRICE) AS 매출금액합계
         FROM PROD A, CART B
        WHERE A.PROD_ID = B.CART_PROD
          AND SUBSTR(B.CART_NO,1,8) BETWEEN '20050401' AND '20050630'
        GROUP BY A.PROD_ID, A.PROD_NAME
        ORDER BY 1;
     
     (ANSI JOIN)     
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              SUM(B.CART_QTY) AS 매출수량합계,
              SUM(B.CART_QTY * A.PROD_PRICE) AS 매출금액합계
         FROM PROD A
        INNER JOIN CART B ON(A.PROD_ID = B.CART_PROD)
          AND SUBSTR(B.CART_NO,1,8) BETWEEN '20050401' AND '20050630'
        GROUP BY A.PROD_ID, A.PROD_NAME
        ORDER BY 1; 
          
 문제]2005년 4월 ~ 6월 각 상품별 매입현황을 조회하시오.
     Alias는 상품코드, 상품명, 매입수량합계, 매입금액합계   
     (일반 JOIN)     
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              SUM(B.BUY_QTY) AS 매입수량합계,
              SUM(B.BUY_QTY * B.BUY_COST) AS 매입금액합계
         FROM PROD A, BUYPROD B
        WHERE A.PROD_ID = B.BUY_PROD
          AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
        GROUP BY A.PROD_ID, A.PROD_NAME
        ORDER BY 1;
     
     (ANSI JOIN)     
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              SUM(B.BUY_QTY) AS 매입수량합계,
              SUM(B.BUY_QTY * B.BUY_COST) AS 매입금액합계
         FROM PROD A
        INNER JOIN BUYPROD B ON(A.PROD_ID = B.BUY_PROD)
          AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
        GROUP BY A.PROD_ID, A.PROD_NAME
        ORDER BY 1;      
     
 문제]2005년 4월 ~ 6월 각 상품별 매입/매출현황을 조회하시오.
     Alias는 상품코드, 상품명, 매입금액합계, 매출금액합계 
     (일반 JOIN)     
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              SUM(B.BUY_QTY * A.PROD_COST) AS 매입금액합계,
              SUM(C.CART_QTY * A.PROD_PRICE) AS 매출금액합계
         FROM PROD A, BUYPROD B, CART C
        WHERE A.PROD_ID = B.BUY_PROD
          AND A.PROD_ID = C.CART_PROD
          AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
          AND SUBSTR(C.CART_NO,1,6) BETWEEN '200504' AND '200506'
        GROUP BY A.PROD_ID, A.PROD_NAME
        ORDER BY 1;            
     
     (ANSI JOIN)     
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              SUM(B.BUY_QTY * A.PROD_COST) AS 매입금액합계,
              SUM(C.CART_QTY * A.PROD_PRICE) AS 매출금액합계
         FROM PROD A
        INNER JOIN BUYPROD B ON(A.PROD_ID = B.BUY_PROD)
        INNER JOIN CART C ON(A.PROD_ID = C.CART_PROD)
          AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
          AND SUBSTR(C.CART_NO,1,6) BETWEEN '200504' AND '200506'
        GROUP BY A.PROD_ID, A.PROD_NAME
        ORDER BY 1;         
        
     (SUBQUERY 사용)             
       SELECT A.PROD_ID AS 상품코드,
              A.PROD_NAME AS 상품명,
              BSUM AS 매입금액합계,
              CSUM AS 매출금액합계
         FROM PROD A,
             (SELECT CC.BUY_PROD AS BID,
                     SUM(CC.BUY_QTY * BB.PROD_COST) AS BSUM
                FROM PROD BB, BUYPROD CC
               WHERE BB.PROD_ID = CC.BUY_PROD
                 AND CC.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
               GROUP BY CC.BUY_PROD) B,
             (SELECT CC.CART_PROD AS CID,
                     SUM(CC.CART_QTY * BB.PROD_PRICE) AS CSUM
                FROM PROD BB, CART CC
               WHERE BB.PROD_ID = CC.CART_PROD
                 AND SUBSTR(CC.CART_NO,1,6) BETWEEN '200504' AND '200506'
               GROUP BY CC.CART_PROD) C
        WHERE A.PROD_ID = B.BID(+)
          AND A.PROD_ID = C.CID(+)
        ORDER BY 1;
     