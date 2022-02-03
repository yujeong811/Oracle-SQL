2022-0119-01)
 문제]사원테이블 등을 이용하여 미국내에 위치한 부서별 사원수와 평균임금을 조회하시오.
     Alias는 부서번호, 부서명, 사원수, 평균임금
     SELECT A.DEPARTMENT_ID AS 부서번호,
            B.DEPARTMENT_NAME AS 부서명, 
            COUNT(*) AS 사원수, 
            ROUND(AVG(A.SALARY)) AS 평균임금
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C,
            HR.COUNTRIES D
      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        AND B.LOCATION_ID = C.LOCATION_ID
        AND C.COUNTRY_ID = D.COUNTRY_ID
        AND LOWER(D.COUNTRY_NAME) LIKE '%america%'
      GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
      ORDER BY 1;
               
 문제]장바구니테이블(CART)에서 2005년 매출자료를 분석하여 거래처별, 상품별 매출현황을 조회하시오.
     Alias는 거래처코드, 거래처명, 상품명, 매출수량합계, 매출금액합계
     (일반 JOIN)        
     SELECT A.BUYER_ID AS 거래처코드,
            A.BUYER_NAME AS 거래처명,
            B.PROD_NAME AS 상품명,
            SUM(C.CART_QTY) AS 매출수량, 
            SUM(C.CART_QTY * B.PROD_PRICE) AS 매출금액
       FROM BUYER A, PROD B, CART C
      WHERE A.BUYER_ID = B.PROD_BUYER
        AND B.PROD_ID = C.CART_PROD
        AND SUBSTR(C.CART_NO,1,4) = '2005'
      GROUP BY A.BUYER_ID, A.BUYER_NAME, B.PROD_NAME
      ORDER BY 1;
      
     (ANSI JOIN)     
     SELECT A.BUYER_ID AS 거래처코드,
            A.BUYER_NAME AS 거래처명,
            B.PROD_NAME AS 상품명,
            SUM(C.CART_QTY) AS 매출수량, 
            SUM(C.CART_QTY * B.PROD_PRICE) AS 매출금액
       FROM BUYER A
      INNER JOIN PROD B ON(A.BUYER_ID = B.PROD_BUYER)
      INNER JOIN CART C ON(B.PROD_ID = C.CART_PROD)
        AND SUBSTR(C.CART_NO,1,4) = '2005'
     -- AND C.CART_NO LIKE '2005%'
      GROUP BY A.BUYER_ID, A.BUYER_NAME, B.PROD_NAME
      ORDER BY 1; 
      