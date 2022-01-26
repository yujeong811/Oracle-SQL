2022-0114-01)�����Լ�(�׷��Լ�)
 - �־��� �ڷḦ Ư�� �÷�(��)�� �������� �׷�ȭ�ϰ� �� �׷쿡�� �հ�(SUM), ���(AVG), �󵾼�(COUNT), �ִ밪(MAX), �ּڰ�(MIN)�� ��ȯ�ϴ� �Լ�
 - SELECT ���� �����Լ��� ������ �Ϲ� �÷��� ���� ���Ǹ� �ݵ�� GROUP BY ���� ���Ǿ�� ��
 - �����Լ��� ���� �÷�(����)�� ������ �ο��� ��� HAVING���� ó��
 - �����Լ����� �ٸ� �����Լ��� ������ �� ����
 
 (�������)
   SELECT [�÷�list,]
           �׷��Լ�
     FROM ���̺��
   [WHERE ����]
   [GROUP BY �÷���[,�÷���2,...]
  [HAVING ����]
   [ORDER BY �÷���|�÷��ε��� [ASC|DESC][,...]];
   * GROUP BY �÷���1[,�÷���2,...] : �÷���1�� �������� �׷�ȭ�ϰ� �� �׷쿡�� �ٽ� '�÷���2'�� �׷�ȭ
   * SELECT ���� ���� �Ϲ��÷��� �ݵ�� GROUP BY ���� ����ؾ��ϸ�, SELECT ���� ������� ���� �÷��� GROUP BY ���� ��� ����
   * SELECT ���� �׷��Լ��� ���� ��� GROUP BY �� ����(���̺� ��ü�� �ϳ��� �׷����� ����)
   * SUM(expr), AVG(expr), COUNT(*|expr), MIN(expr), MAX(expr) --expr : �÷���

(��뿹)������̺��� �� �μ��� �޿��հ踦 ���Ͻÿ�  -- ~�� : GROUP BY�� ���, ~�� ���� �������϶� �÷��� ������ ���
       Alias�� �μ��ڵ�, �޿��հ�
       SELECT DEPARTMENT_ID AS �μ��ڵ�,
              SUM(SALARY) AS �޿��հ�
         FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
        
(��뿹)������̺��� �� �μ��� �޿��հ踦 ���ϵ� �޿��հ谡 100000�̻��� �μ��� ��ȸ�Ͻÿ� 
       Alias�� �μ��ڵ�, �޿��հ�
       SELECT DEPARTMENT_ID AS �μ��ڵ�,
              SUM(SALARY) AS �޿��հ�
         FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID
       HAVING SUM(SALARY) >= 100000
        ORDER BY 1;
       
(��뿹)������̺��� �� �μ��� ��ձ޿��� ���Ͻÿ�
       Alias�� �μ��ڵ�, �μ���, ��ձ޿�      
       SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
              B.DEPARTMENT_NAME AS �μ���,
              ROUND(AVG(SALARY),1) AS ��ձ޿�
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
(��뿹)��ǰ���̺��� �з��� ��ո��԰��� ��ȸ�Ͻÿ�
       SELECT PROD_LGU AS ��ǰ�з��ڵ�,
              ROUND(AVG(PROD_COST),-2) AS ��ո��Դܰ�
         FROM PROD
        GROUP BY PROD_LGU
        ORDER BY 1;
        
 ����]��ٱ������̺��� 2005�� 4�� ��ǰ�� �Ǹż������踦 ���Ͻÿ�.
     SELECT CART_PROD AS ��ǰ�ڵ�,
            SUM(CART_QTY) AS �Ǹż�������
       FROM CART
      WHERE SUBSTR(CART_NO,1,6) = '200504'
   -- WHERE CART_NO = '200504%'      
      GROUP BY CART_PROD
      ORDER BY 1;
 
 ����]��ٱ������̺��� 2005�� 4�� ��ǰ�� �Ǹż��� �հ谡 10�� �̻��� ��ǰ�� ��ȸ�Ͻÿ�. 
     SELECT CART_PROD AS ��ǰ�ڵ�,
            SUM(CART_QTY) AS �Ǹż����հ�
       FROM CART
      WHERE SUBSTR(CART_NO,1,6) = '200504'
   -- WHERE CART_NO = '200504%'
      GROUP BY CART_PROD
     HAVING SUM(CART_QTY) >= 10
      ORDER BY 1;
       
 ����]�������̺��� 2005�� 1��~6�� ���� �������踦 ���Ͻÿ�.
     SELECT EXTRACT(MONTH FROM BUY_DATE) AS ���Կ�,
            SUM(BUY_QTY) AS ���Լ�������,
            SUM(BUY_QTY * BUY_COST) AS ���Աݾ��հ�
       FROM BUYPROD
      WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
      GROUP BY EXTRACT(MONTH FROM BUY_DATE)
      ORDER BY 1;
     
 ����]�������̺��� 2005�� 1��~6�� ����, ��ǰ�� ���Աݾ� �հ谡 1000���� �̻��� ������ ��ȸ�Ͻÿ�.
     SELECT EXTRACT(MONTH FROM BUY_DATE) AS ���Կ�,
            BUY_PROD AS ��ǰ�ڵ�,
            SUM(BUY_QTY) AS ���Լ�������,
            SUM(BUY_QTY * BUY_COST) AS ���Աݾ��հ�
       FROM BUYPROD
      WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
      GROUP BY EXTRACT(MONTH FROM BUY_DATE), BUY_PROD
     HAVING SUM(BUY_QTY * BUY_COST) >= 10000000
      ORDER BY 1;
      
 ����]ȸ�����̺��� ���� ���ϸ��� �հ踦 ���Ͻÿ�
     Alias�� ����, ���ϸ����հ��̸�, ���п��� '����ȸ��'�� '����ȸ��'�� ���
     SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR  
                      SUBSTR(MEM_REGNO2,1,1) = '3' THEN
                       '����ȸ��'
             ELSE     
                       '����ȸ��'  
             END AS ����,
            SUM(MEM_MILEAGE) AS ���ϸ����հ�
       FROM MEMBER
      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR  
                         SUBSTR(MEM_REGNO2,1,1) = '3' THEN
                       '����ȸ��'
             ELSE     
                       '����ȸ��'  
             END
      ORDER BY 1;
      
 ����]ȸ�����̺��� ���ɴ뺰 ���ϸ��� �հ踦 ��ȸ�Ͻÿ�
     Alias�� ����, ���ϸ����հ��̸�, ���п��� '10��',...'70��'������ ���ɴ븦 ���   
     SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) -                        --���ɴ� ���� �� MEM_BIR ���
                  EXTRACT(YEAR FROM MEM_BIR),-1)||'��' AS ����,       
            SUM(MEM_MILEAGE) AS ���ϸ����հ�
       FROM MEMBER
      GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) -
                     EXTRACT(YEAR FROM MEM_BIR),-1)
      ORDER BY 1;
------------------------------------------------------------------      
     SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR                 --���ɴ� ���� �� MEM_REGNO2 ���
                      SUBSTR(MEM_REGNO2,1,1) = '2' THEN
            TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
              (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900), -1)
            ELSE 
            TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
              (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 2000), -1)  
            END ||'��' AS ����,
            SUM(MEM_MILEAGE) AS ���ϸ����հ�
       FROM MEMBER    
      GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                         SUBSTR(MEM_REGNO2,1,1) = '2' THEN
            TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
              (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900), -1)
            ELSE 
            TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
              (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 2000), -1)  
            END
      ORDER BY 1;
     
��뿹)��ü����� ��ձ޿��� ����Ͻÿ�
      SELECT ROUND(AVG(SALARY)) AS ��ձ޿�,
             SUM(SALARY) AS �޿��հ�,
             COUNT(*) AS �����
        FROM HR.EMPLOYEES;
       
��뿹)������� �޿��� ��ձ޿����� ���� ��������� ��ȸ
      Alias�� �����ȣ, �����, �μ��ڵ�, �����ڵ�, �޿�, ��ձ޿�
      SELECT A.EMPLOYEE_ID AS �����ȣ, 
             A.EMP_NAME AS �����,
             A.DEPARTMENT_ID AS �μ��ڵ�,
             A.JOB_ID AS �����ڵ�,
             A.SALARY AS �޿�,
             B.ASAL AS ��ձ޿�
        FROM HR.EMPLOYEES A, (SELECT ROUND(AVG(SALARY)) AS ASAL FROM HR.EMPLOYEES) B
       WHERE A.SALARY < B.ASAL
       ORDER BY 3;
----------------------------------------------------------------------------------------       
      SELECT EMPLOYEE_ID AS �����ȣ, 
             EMP_NAME AS �����,
             DEPARTMENT_ID AS �μ��ڵ�,
             JOB_ID AS �����ڵ�,
             SALARY AS �޿�,
             (SELECT ROUND(AVG(SALARY)) FROM HR.EMPLOYEES) AS ��ձ޿�
        FROM HR.EMPLOYEES
       WHERE SALARY < (SELECT ROUND(AVG(SALARY)) AS ASAL FROM HR.EMPLOYEES)
       ORDER BY 3;
        