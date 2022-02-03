2022-0119-02)
 2. NON-EQUI JOIN
   - �������ǹ��� '='������ �̿��� �����ڰ� ���Ǵ� ����
   
 ** HR ������ �޿��� ���� ���ǥ�� �ۼ��Ͻÿ�
  1)���̺�� : SAL_GRADE
  2)�÷���
 ---------------------------------------
     GRADE     LOW_SAL     MAX_SAL
 ---------------------------------------
       1         1000        2999
       2         3000        4999
       3         5000        7999
       4         8000       12999
       5        13000       19999
       6        20000       40000
 ---------------------------------------   
  3)�⺻Ű : GRADE
  
  CREATE TABLE SAL_GRADE(
    GRADE NUMBER(2) PRIMARY KEY,
    LOW_SAL NUMBER(6),
    MAX_SAL NUMBER(6))
  
  INSERT INTO SAL_GRADE VALUES(1, 1000, 2999);  
  INSERT INTO SAL_GRADE VALUES(2, 3000, 4999);  
  INSERT INTO SAL_GRADE VALUES(3, 5000, 7999);  
  INSERT INTO SAL_GRADE VALUES(4, 8000, 12999);  
  INSERT INTO SAL_GRADE VALUES(5, 13000, 19999);  
  INSERT INTO SAL_GRADE VALUES(6, 20000, 40000);  
  
  SELECT * FROM SAL_GRADE;
  COMMIT;
  
 ��뿹)HR������ ������̺��� �޿��� ���� ����� ��ȸ�Ͽ� ����Ͻÿ�
       Alias�� �����ȣ, �����, �μ���, �޿�, ����̴�
       SELECT A.EMPLOYEE_ID AS �����ȣ, A.EMP_NAME AS �����,
              B.DEPARTMENT_NAME AS �μ���,
              A.SALARY AS �޿�,
              C.GRADE AS ���
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, 
              SAL_GRADE C
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
          AND (A.SALARY >= C.LOW_SAL AND A.SALARY <= C.MAX_SAL)
        ORDER BY 2;
        
 ��뿹)������̺��� ������� ��ձ޿����� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�
       Alias�� �����ȣ, �����, ������, �޿�
       SELECT A.EMPLOYEE_ID AS �����ȣ, 
              A.EMP_NAME AS �����,
              B.JOB_TITLE AS ������, 
              A.SALARY AS �޿�
         FROM HR.EMPLOYEES A, HR.JOBS B,
              (SELECT AVG(SALARY) AS ASAL  --��ձ޿� ����
                 FROM HR.EMPLOYEES) C
        WHERE A.JOB_ID = B.JOB_ID
          AND A.SALARY > C.ASAL
        ORDER BY 4 DESC;
       
 ����]������̺��� �μ��� ����ӱ��� ���ϰ� �ش�μ��� ���� ��� �� �ڱ�μ��� ��� �޿����� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�       
      Alias�� �����ȣ, �����, �μ���, �μ���ձ޿�, �޿�
      SELECT A.EMPLOYEE_ID AS �����ȣ,
             A.EMP_NAME AS �����,
             B.DEPARTMENT_NAME AS �μ���, 
             ROUND(C.SAL) AS �μ���ձ޿�,
             A.SALARY AS �޿�
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
            (SELECT DEPARTMENT_ID AS DEI,                     
                    AVG(SALARY) AS SAL                  
               FROM HR.EMPLOYEES
              GROUP BY DEPARTMENT_ID) C
       WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
         AND B.DEPARTMENT_ID = C.DEI
         AND A.SALARY > C.SAL
       ORDER BY 1;
     
    
     �������� : 2022�� 1�� 28��
     ������ : ��������(SEM-PC D:\��������\Oracle\homework01)
     ���ϸ� : �޸��� ���� Ȱ���Ͽ� TXT �Ǵ� DOC �Ǵ� HWP���Ϸ� �����Ͽ� ����
             ���ϸ��� �̸��ۼ�����.TXT EX)ȫ�浿20220127.TXT
     
       
       
       
  
  
  