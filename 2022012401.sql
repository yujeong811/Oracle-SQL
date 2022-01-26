2022-0124-01)
 ��뿹)2005�� ��� �ŷ�ó�� ���Աݾ��հ踦 ��ȸ�Ͻÿ�  --���  : outer join, ~�� : group by
       Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ�    --(�Ϲ����� �ܺ�����--��������)
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��,
              SUM(B.BUY_QTY * C.PROD_COST) AS ���Աݾ��հ�
         FROM BUYER A, BUYPROD B, PROD C
        WHERE B.BUY_PROD(+) = C.PROD_ID
          AND A.BUYER_ID = C.PROD_BUYER
          AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231')
        GROUP BY A.BUYER_ID, A.BUYER_NAME
        ORDER BY 1;
        
   (ANSI �ܺ�����)
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��,
              SUM(B.BUY_QTY * C.PROD_COST) AS ���Աݾ��հ�
         FROM BUYER A
         LEFT OUTER JOIN PROD C ON(A.BUYER_ID = C.PROD_BUYER)
         LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD = C.PROD_ID
          AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231'))  --WHERE���� ���� ���� ���ó�� 12�� ����
        GROUP BY A.BUYER_ID, A.BUYER_NAME
        ORDER BY 1;       
        
   (SUBQUERY ��� �ܺ�����)        
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��,
              SUM(B.BUY_QTY * C.PROD_COST) AS ���Աݾ��հ�
         FROM BUYER A, (2005�⵵ �ŷ�ó�� ���Աݾװ��) B
         
   (SUBQUERY : 2005�⵵ �ŷ�ó�� ���Աݾװ��)   
       SELECT A.BUYER_ID AS BID,
              SUM(B.BUY_QTY * C.PROD_COST) AS BSUM 
         FROM BUYER A, PROD C, BUYPROD B
        WHERE C.PROD_ID = B.BUY_PROD
          AND A.BUYER_ID = C.PROD_BUYER
          AND EXTRACT(YEAR FROM B.BUY_DATE) = '2005'
        GROUP BY A.BUYER_ID;
        
   (����)
       SELECT D.BUYER_ID AS �ŷ�ó�ڵ�, 
              D.BUYER_NAME AS �ŷ�ó��,
              NVL(E.BSUM,0) AS ���Աݾ��հ�
         FROM BUYER D, (SELECT A.BUYER_ID AS BID,
                               SUM(B.BUY_QTY * C.PROD_COST) AS BSUM 
                          FROM BUYER A, PROD C, BUYPROD B
                         WHERE C.PROD_ID = B.BUY_PROD
                           AND A.BUYER_ID = C.PROD_BUYER
                           AND EXTRACT(YEAR FROM B.BUY_DATE) = '2005'
                         GROUP BY A.BUYER_ID) E 
        WHERE D.BUYER_ID = E.BID(+)
        ORDER BY 1;
        
       
 ��뿹)ȸ�����̺��� ������ �ڿ����� ȸ������ ���ϸ������� �� ���� ���ϸ����� �����ϰ� �ִ� ȸ�������� ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���
   (�������� : ȸ����ȣ, ȸ����, ����, ���ϸ���)    
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_JOB AS ����,
              MEM_MILEAGE AS ���ϸ���
         FROM MEMBER
        WHERE MEM_MILEAGE > (������ �ֺ��� ȸ������ ���ϸ���)
        ORDER BY 1;
 
   (SUBQUERY : ������ �ֺ��� ȸ������ ���ϸ���)    
       SELECT MEM_MILEAGE
         FROM MEMBER
        WHERE MEM_JOB = '�ڿ���';
 
   (����)
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_JOB AS ����,
              MEM_MILEAGE AS ���ϸ���
         FROM MEMBER
        WHERE MEM_MILEAGE > ALL (SELECT MEM_MILEAGE      --������ ������
                                   FROM MEMBER
                                  WHERE MEM_JOB = '�ڿ���')
        ORDER BY 1;   
