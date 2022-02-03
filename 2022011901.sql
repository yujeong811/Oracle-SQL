2022-0119-01)
 ����]������̺� ���� �̿��Ͽ� �̱����� ��ġ�� �μ��� ������� ����ӱ��� ��ȸ�Ͻÿ�.
     Alias�� �μ���ȣ, �μ���, �����, ����ӱ�
     SELECT A.DEPARTMENT_ID AS �μ���ȣ,
            B.DEPARTMENT_NAME AS �μ���, 
            COUNT(*) AS �����, 
            ROUND(AVG(A.SALARY)) AS ����ӱ�
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C,
            HR.COUNTRIES D
      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        AND B.LOCATION_ID = C.LOCATION_ID
        AND C.COUNTRY_ID = D.COUNTRY_ID
        AND LOWER(D.COUNTRY_NAME) LIKE '%america%'
      GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
      ORDER BY 1;
               
 ����]��ٱ������̺�(CART)���� 2005�� �����ڷḦ �м��Ͽ� �ŷ�ó��, ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
     Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ��, ��������հ�, ����ݾ��հ�
     (�Ϲ� JOIN)        
     SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
            A.BUYER_NAME AS �ŷ�ó��,
            B.PROD_NAME AS ��ǰ��,
            SUM(C.CART_QTY) AS �������, 
            SUM(C.CART_QTY * B.PROD_PRICE) AS ����ݾ�
       FROM BUYER A, PROD B, CART C
      WHERE A.BUYER_ID = B.PROD_BUYER
        AND B.PROD_ID = C.CART_PROD
        AND SUBSTR(C.CART_NO,1,4) = '2005'
      GROUP BY A.BUYER_ID, A.BUYER_NAME, B.PROD_NAME
      ORDER BY 1;
      
     (ANSI JOIN)     
     SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
            A.BUYER_NAME AS �ŷ�ó��,
            B.PROD_NAME AS ��ǰ��,
            SUM(C.CART_QTY) AS �������, 
            SUM(C.CART_QTY * B.PROD_PRICE) AS ����ݾ�
       FROM BUYER A
      INNER JOIN PROD B ON(A.BUYER_ID = B.PROD_BUYER)
      INNER JOIN CART C ON(B.PROD_ID = C.CART_PROD)
        AND SUBSTR(C.CART_NO,1,4) = '2005'
     -- AND C.CART_NO LIKE '2005%'
      GROUP BY A.BUYER_ID, A.BUYER_NAME, B.PROD_NAME
      ORDER BY 1; 
      