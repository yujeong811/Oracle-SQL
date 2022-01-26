2022-0121-02)SUBQUERY
 - SQL���� �ȿ� �� �ٸ� SELECT���� �����ϴ� ���
 - JOIN�̳� ���⵵�� �����ϱ� ���� ���
 - ��� SUBQUERY���� ( )�ȿ� ����ؾ���. ��, INSERT���� ���Ǵ� SUBQUERY�� ����
 - ���������� WHERE�� ��� ����� ���� ���� �� �ݵ�� ������ �����ʿ� ��ġ
 - ���������� �з�
   * �����ġ�� ���� : �Ϲݼ�������(SELECT ��), ��ø��������(WHERE ��), IN-line��������(FROM��)
   * ������������ ���迡 ���� : ���ü� ���� ��������(���������� ���� ���̺�� JOIN ���� ������ ��������),
                           ���ü� �ִ� ��������(���������� ���� ���̺�� JOIN���� ����� ��������)
   * ��ȯ�Ǵ� ��/���� ���� : ���Ͽ�|���߿� / ������|������
                         �������� => ���Ǵ� �����ڿ� ���� ����
 - �˷����� ���� ���ǿ� �ٰ��� ������ �˻��ϴ� SELECT�� � Ȱ�� 
 - ���������� ����Ǳ� ���� �ѹ� �����Ѵ�.
 
 ��뿹)������̺��� ������� ����ӱݺ��� ���� �޿��� �޴� ������� �����ȣ,�����,�μ��ڵ�,�޿��� ��ȸ�Ͻÿ�
 (IN-LINE VIEW ��������)
  (�������� : ������� �����ȣ, �����, �μ��ڵ�, �޿��� ��ȸ)
   SELECT A.EMPLOYEE_ID AS �����ȣ,
          A.EMP_NAME AS �����,
          A.DEPARTMENT_ID AS �μ��ڵ�,
          A.SALARY AS �޿�     
     FROM HR.EMPLOYEES A, (����ӱ�) B
    WHERE A.SALARY > B.����ӱ�
    ORDER BY 3;
     
  (�������� : ����ӱ��� ���)     
   SELECT AVG(SALARY) AS ASAL
     FROM HR.EMPLOYEES
     
  (����)      
   SELECT A.EMPLOYEE_ID AS �����ȣ,
          A.EMP_NAME AS �����,
          A.DEPARTMENT_ID AS �μ��ڵ�,
          A.SALARY AS �޿�     
     FROM HR.EMPLOYEES A, (SELECT AVG(SALARY) AS ASAL
                             FROM HR.EMPLOYEES) B
    WHERE A.SALARY > B.ASAL 
    ORDER BY 3;
     
  (��ø ��������)      
   SELECT EMPLOYEE_ID AS �����ȣ,
          EMP_NAME AS �����,
          DEPARTMENT_ID AS �μ��ڵ�,
          SALARY AS �޿�     
     FROM HR.EMPLOYEES
    WHERE SALARY > (SELECT AVG(SALARY)       --���� ����ŭ �ݺ�
                        FROM HR.EMPLOYEES) 
    ORDER BY 3;  
     
 ��뿹)ȸ�����̺��� ȸ���� ������ �ִ븶�ϸ����� �����ִ� ȸ�������� ��ȸ�Ͻÿ�
       Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���
  (�������� : ȸ����ȣ, ȸ����, ����, ���ϸ��� ��ȸ)
   SELECT MEM_ID AS ȸ����ȣ, 
          MEM_NAME AS ȸ����, 
          MEM_JOB AS ����, 
          MEM_MILEAGE AS ���ϸ���
     FROM MEMBER
    WHERE (MEM_JOB, MEM_MILEAGE) = (��������)
    
  (�������� : ȸ���� ������ �ִ븶�ϸ���)    
   SELECT MEM_JOB,
          MAX(MEM_MILEAGE)
     FROM MEMBER
    GROUP BY MEM_JOB;
 
  (����)  
   SELECT MEM_ID AS ȸ����ȣ, 
          MEM_NAME AS ȸ����, 
          MEM_JOB AS ����, 
          MEM_MILEAGE AS ���ϸ���
     FROM MEMBER
    WHERE (MEM_JOB, MEM_MILEAGE) IN (SELECT MEM_JOB,
                                            MAX(MEM_MILEAGE)
                                       FROM MEMBER
                                      GROUP BY MEM_JOB);                                      
  (EXISTS ������ ���)                                       
   SELECT A.MEM_ID AS ȸ����ȣ, 
          A.MEM_NAME AS ȸ����, 
          A.MEM_JOB AS ����, 
          A.MEM_MILEAGE AS ���ϸ���
     FROM MEMBER A
    WHERE EXISTS (SELECT 1
                    FROM (SELECT MEM_JOB,
                                 MAX(MEM_MILEAGE) AS BMILE
                            FROM MEMBER 
                           GROUP BY MEM_JOB) B
                   WHERE A.MEM_JOB = B.MEM_JOB
                     AND A.MEM_MILEAGE = B.BMILE);                                      
 
 ��뿹)��ǰ���̺��� ��ǰ�� �ǸŰ��� ����ǸŰ����� ū ��ǰ�� ��ȸ�Ͻÿ�
       Alias�� ��ǰ��ȣ, ��ǰ��, �ǸŰ�, ����ǸŰ�
   SELECT A.PROD_ID AS ��ǰ��ȣ, 
          A.PROD_NAME AS ��ǰ��, 
          A.PROD_PRICE AS �ǸŰ�,
          B.BPRICE AS ����ǸŰ�
     FROM PROD A, (SELECT ROUND(AVG(PROD_PRICE)) AS BPRICE
                     FROM PROD) B
    WHERE A.PROD_PRICE > B.BPRICE;
       
 ��뿹)��ٱ������̺��� ȸ���� �ִ� ���ż����� ����� ��ǰ�� ��ȸ�Ͻÿ�
       Alias�� ȸ����ȣ, ȸ����, ��ǰ��, ���ż���  
  (�������� : ȸ����ȣ, ȸ����, ��ǰ��, ���ż���)          
   SELECT C.CART_MEMBER AS ȸ����ȣ,
          A.MEM_NAME AS ȸ����,
          B.PROD_NAME AS ��ǰ��, 
          C.CART_QTY AS ���ż���
     FROM MEMBER A, PROD B, CART C
    WHERE A.MEM_ID = C.CART_MEMBER
      AND B.PROD_ID = C.CART_PROD       
      AND C.CART_QTY IN (ȸ���� �ִ� ���� ����)  
    ORDER BY 1;
    
  (�������� : ȸ���� �ִ� ���ż���)   
   SELECT D.CART_MEMBER,
          MAX(D.CART_QTY)
     FROM CART D
    GROUP BY CART_MEMBER;
          
  (����1)        
   SELECT C.CART_MEMBER AS ȸ����ȣ,
          A.MEM_NAME AS ȸ����,
          B.PROD_NAME AS ��ǰ��, 
          C.CART_QTY AS ���ż���
     FROM MEMBER A, PROD B, CART C
    WHERE A.MEM_ID = C.CART_MEMBER
      AND B.PROD_ID = C.CART_PROD
      AND (C.CART_MEMBER, C.CART_QTY) IN (SELECT D.CART_MEMBER,
                                                 MAX(D.CART_QTY)
                                            FROM CART D
                                           GROUP BY CART_MEMBER) 
    ORDER BY 1;
  
  (����2)        
   SELECT C.CART_MEMBER AS ȸ����ȣ,
          A.MEM_NAME AS ȸ����,
          B.PROD_NAME AS ��ǰ��, 
          C.CART_QTY AS ���ż���
     FROM MEMBER A, PROD B, CART C
    WHERE A.MEM_ID = C.CART_MEMBER
      AND B.PROD_ID = C.CART_PROD
      AND C.CART_QTY = (SELECT MAX(D.CART_QTY)
                          FROM CART D
                         WHERE D.CART_MEMBER = C.CART_MEMBER) 
    ORDER BY 1;     
     
  
  