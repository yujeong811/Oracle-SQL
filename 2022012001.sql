2022-0120-01)�ܺ�����(OUTER JOIN)
 - ���ο� �����ϴ� ���̺� �� �ڷ��� ������ ���� ���� �������� ���� ���̺� NULL���� ÷���Ͽ� ������ ����
 - �Ϲݿܺ������� �������� ����� ������ ���̺��� �÷���
   �ڿ� �ܺ����� ������ '(+)'�� �߰�
 - �ܺ����� ������ �������� ��� ��� '(+)'�����ڸ� �߰��ؾ���
 - �ϳ��� ���̺��� ���ÿ� �ټ����� �ܺ����ο� ������ �� ����. (A=B(+) AND C=B(+)�� ������ ����)
   ��, A,B,C ���̺��� �ܺ� ���ο� �����ϴ� ��� A�� �������� B���̺���, C�� �������� B���̺��� ���ÿ� �ܺ����� �� �� ����. 
 - �Ϲ����ǰ� �ܺ����������� ���ÿ� ���Ǹ� ��Ȯ�� ����� ���� �� ����.
 
 (�������-�Ϲݿܺ�����)
   SELECT �÷�list
     FROM ���̺��[��Ī],���̺��[��Ī],...
    WHERE �÷���=�÷���(+)
   
 (�������-ANSI�ܺ�����)  --�ܺ������� ANSI�� �� ��Ȯ
   SELECT �÷�list
     FROM ���̺��1[��Ī1],...
    LEFT|RIGHT|FULL OUTER JOIN ���̺��2[��Ī2] 
          ON(��������[AND �Ϲ�����])
                    :
    LEFT|RIGHT|FULL OUTER JOIN ���̺��n[��Īn] 
          ON(��������[AND �Ϲ�����])                    
    [WHERE �Ϲ�����] 
      
    * FROM ������ ����� '���̺��1'�� �ڷᰡ '���̺��2'���� ������ LEFT, ������ RIGHT, ���� ��� �����ϸ� FULL ���
    * '���̺��1'�� '���̺��2'�� �ݵ�� ���� ������ ��
    * ��Ÿ ���� ���μ����� �������ΰ� ����
    
 ��뿹)��ǰ���̺��� ��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�.
       Alias�� �з��ڵ�, �з���, ��ǰ�� ��
    (��ǰ���̺��� ���� �з��ڵ��� ��)
       SELECT COUNT(DISTINCT PROD_LGU)
         FROM PROD; 
         
    (�Ϲݿܺ�����)
       SELECT B.PROD_LGU AS �з��ڵ�,  
              A.LPROD_NM AS �з���,
              COUNT(*) AS "��ǰ�� ��"  
         FROM LPROD A, PROD B
        WHERE B.PROD_LGU(+) = A.LPROD_GU
        GROUP BY B.PROD_LGU, A.LPROD_NM
        ORDER BY 1;
        
       SELECT A.LPROD_GU AS �з��ڵ�,  --�з��ڵ尡 ���� ������ ���
              A.LPROD_NM AS �з���,
              COUNT(B.PROD_ID) AS "��ǰ�� ��"  
         FROM LPROD A, PROD B
        WHERE B.PROD_LGU(+) = A.LPROD_GU
        GROUP BY A.LPROD_GU, A.LPROD_NM
        ORDER BY 1; 
        
    (ANSI�ܺ�����)        
       SELECT A.LPROD_GU AS �з��ڵ�,
              A.LPROD_NM AS �з���,
              COUNT(B.PROD_ID) AS "��ǰ�� ��"  
         FROM LPROD A
         LEFT OUTER JOIN PROD B ON(B.PROD_LGU = A.LPROD_GU)
        GROUP BY A.LPROD_GU, A.LPROD_NM
        ORDER BY 1;
        
 ��뿹)2005�� 7�� ��� ��ǰ�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�.
       Alias�� ��ǰ�ڵ�,��ǰ��,�Ǹż����հ�,�Ǹűݾ�
    (�Ϲݿܺ�����)       
       SELECT B.PROD_ID AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��,
              SUM(A.CART_QTY) AS �Ǹż����հ�,
              SUM(A.CART_QTY * B.PROD_PRICE) AS �Ǹűݾ�
         FROM CART A, PROD B
        WHERE B.PROD_ID = A.CART_PROD(+)
          AND A.CART_NO LIKE '200507%'
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
    (ANSI�ܺ�����)        
       SELECT B.PROD_ID AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��,
              NVL(SUM(A.CART_QTY),0) AS �Ǹż����հ�,
              NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS �Ǹűݾ�
         FROM CART A
        RIGHT OUTER JOIN PROD B ON(B.PROD_ID = A.CART_PROD
              AND A.CART_NO LIKE '200507%')
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;       
       
 **���� ���ǿ� �´� ��� �������̺��� �����ϰ� ���� �ڷḦ �Է��Ͻÿ�      -- ���� : ������ ������ ���� ����
   1)���̺�� : REMAIN
   2)�÷�
 --------------------------------------------------------------
   �÷���        ������Ÿ��(ũ��)    NULLABLE    PK/FK    DEFAULT
 --------------------------------------------------------------
  REMAIN_YEAR    CHAR(4)           N.N       PK
  PROD_ID        VARCHAR2(10)      N.N       PK&FK
  REMAIN_J_00    NUMBER(5)                              0          --�������
  REMAIN_O       NUMBER(5)                              0          --������
  REMAIN_I       NUMBER(5)                              0          --�԰����
  REMAIN_J_99    NUMBER(5)                              0          --�⸻���
  REMAIN_DATE    DATE                                 SYSDATE      --��¥
 --------------------------------------------------------------       
       
  CREATE TABLE REMAIN(
    REMAIN_YEAR    CHAR(4),      
    PROD_ID        VARCHAR2(10),     
    REMAIN_J_00    NUMBER(5) DEFAULT 0,                                    
    REMAIN_O       NUMBER(5) DEFAULT 0,                                     
    REMAIN_I       NUMBER(5) DEFAULT 0,                                     
    REMAIN_J_99    NUMBER(5) DEFAULT 0,                                   
    REMAIN_DATE    DATE DEFAULT SYSDATE,
    CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR, PROD_ID),
    CONSTRAINT fk_remain_prod FOREIGN KEY(PROD_ID)
      REFERENCES PROD(PROD_ID));
      
 (�����ڷ� �Է�) 
   =>��ǰ���̺��� ��ǰ�ڵ�� ������� ���������̺�(REMAIN)�� ��ǰ�ڵ�� ������� ����
     1)�⵵ : '2005'
     2)��ǰ�ڵ� : ��ǰ���̺��� ��ǰ�ڵ�
     3)����, �⸻��� : ��ǰ���̺��� �������(PROD_PROPERSTOCK)
     
   INSERT INTO REMAIN(REMAIN_YEAR, PROD_ID, REMAIN_J_00, REMAIN_J_99, REMAIN_DATE)
     SELECT '2005', PROD_ID, PROD_PROPERSTOCK, PROD_PROPERSTOCK, TO_DATE('20041231')
       FROM PROD;
      
   COMMIT;
   SELECT * FROM REMAIN;
   
 ��뿹)2005�� 1�� ��� ��ǰ�� ���Լ����� ��ȸ�Ͽ� ���������̺��� �����Ͻÿ�.
   (2005�� 1�� ��� ��ǰ�� ���Լ����� ��ȸ)
    SELECT PROD_ID,
           NVL(SUM(BUY_QTY),0)
      FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON(B.PROD_ID = A.BUY_PROD
       AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
     GROUP BY PROD_ID;
 
   (���������̺� ����) 
    UPDATE REMAIN R
       SET REMAIN_I = (SELECT REMAIN_I + A.ISUM
                         FROM (SELECT B.PROD_ID AS PID,
                                      NVL(SUM(BUY_QTY),0) AS ISUM
                                 FROM BUYPROD A
                                RIGHT OUTER JOIN PROD B ON(B.PROD_ID = A.BUY_PROD
                                  AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
                                GROUP BY B.PROD_ID) A
                        WHERE R.PROD_ID = A.PID),
           REMAIN_J_99 = (SELECT REMAIN_J_99 + A.ISUM
                            FROM (SELECT B.PROD_ID AS PID,
                                         NVL(SUM(BUY_QTY),0) AS ISUM
                                    FROM BUYPROD A
                                   RIGHT OUTER JOIN PROD B ON(B.PROD_ID = A.BUY_PROD
                                     AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
                                   GROUP BY B.PROD_ID) A
                           WHERE R.PROD_ID = A.PID),      
           REMAIN_DATE = TO_DATE('20050201');
       
    SELECT * FROM REMAIN;
    ROLLBACK;   
    COMMIT;
    
    UPDATE REMAIN R
       SET (R.REMAIN_I, R.REMAIN_J_99, R.REMAIN_DATE) = 
           (SELECT R.REMAIN_I + C.ISUM,               --����, ���� ��ġ�ؾ���
                   R.REMAIN_J_99 + C.ISUM,
                   TO_DATE('20050201')
              FROM (SELECT BUY_PROD AS PID,           --2005�� 1�� ��ǰ�� ���Լ������� ����
                           SUM(BUY_QTY) AS ISUM
                      FROM BUYPROD         
                     WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')   --�������� �ᵵ �������
                     GROUP BY BUY_PROD) C
             WHERE R.PROD_ID = C.PID)
     WHERE R.PROD_ID IN (SELECT DISTINCT BUY_PROD
                           FROM BUYPROD
                          WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')); 
                          
 ** ��ǰ���̺� ��ǰ�� ���ϸ����� ��ǰ�ǸŰ��� 0.01%�� �����Ͽ� �����Ͻÿ�.
    UPDATE PROD
       SET PROD_MILEAGE = ROUND(PROD_PRICE * 0.0001);
       
    SELECT PROD_ID, PROD_PRICE, PROD_MILEAGE
      FROM PROD;
 
    COMMIT; 
    
 ** ȸ�����̺��� ȸ�����ϸ����� 2005�� ��� �����ڷḦ �����Ͽ� �����Ͻÿ�.
    (2005�� ȸ����, ��ǰ�� �����������)
     SELECT MEM_ID, 
            CART_PROD,
            NVL(SUM(CART_QTY),0)
       FROM CART A
      RIGHT OUTER JOIN MEMBER B ON(B.MEM_ID = A.CART_MEMBER
            AND A.CART_NO LIKE '2005%')
      GROUP BY MEM_ID, CART_PROD
      ORDER BY 1;
       
    (2005�� ȸ���� ���ſ� ���� ���ϸ���)       
     SELECT B.MEM_ID AS BMID,
            SUM(B.CSUM * C.PROD_MILEAGE) AS BSUM
       FROM (SELECT MEM_ID, 
                    CART_PROD,
                    NVL(SUM(CART_QTY),0) AS CSUM
               FROM CART A
              RIGHT OUTER JOIN MEMBER B ON(B.MEM_ID = A.CART_MEMBER
                    AND A.CART_NO LIKE '2005%')
              GROUP BY MEM_ID, CART_PROD
              ORDER BY 1) B, 
             PROD C
      WHERE B.CART_PROD = C.PROD_ID
      GROUP BY B.MEM_ID;
    
    (ȸ�����̺��� ���ϸ��� UPDATE)
     UPDATE MEMBER M
        SET MEM_MILEAGE = 
            (SELECT D.BSUM
               FROM (SELECT B.MEM_ID AS BMID,
                            SUM(B.CSUM * C.PROD_MILEAGE) AS BSUM
                       FROM (SELECT MEM_ID, 
                                    CART_PROD,
                                    NVL(SUM(CART_QTY),0) AS CSUM
                               FROM CART A
                              RIGHT OUTER JOIN MEMBER B ON(B.MEM_ID = A.CART_MEMBER
                                    AND A.CART_NO LIKE '2005%')
                              GROUP BY MEM_ID, CART_PROD
                              ORDER BY 1) B, 
                             PROD C
                      WHERE B.CART_PROD = C.PROD_ID
                      GROUP BY B.MEM_ID) D
               WHERE M.MEM_ID = D.BMID) 
       WHERE M.MEM_ID IN (SELECT DISTINCT CART_MEMBER
                            FROM CART
                           WHERE CART_NO LIKE '2005%');
        
     SELECT MEM_ID, MEM_MILEAGE
       FROM MEMBER;  
       