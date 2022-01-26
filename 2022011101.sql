2022-0111-01)
 3)LPAD(c1,n[,c2]),RPAD(c1,n[,c2]) 
  - ���ǵ� �������� ũ��(n)���� c1���ڿ��� ä��� ���� ���� ����(LPAD) �Ǵ� ������(RPAD)�� c2�� ä��
  - c2�� �����Ǹ� ������ ä��
  - ��ǥ��ȣ���� � �ַ� ���Ǿ���
  
��뿹)��ǰ���̺��� ��ǰ���� ����ϵ� ���� ���� ������ '*'�� ä�� ����Ͻÿ�.
      SELECT LPAD(PROD_NAME,40,'*'),
             RPAD(PROD_NAME,40,'*')
        FROM PROD;
        
      SELECT LPAD(EMP_NAME,30), SALARY
        FROM HR.EMPLOYEES;
        
      SELECT LPAD(SALARY,8,'*')
        FROM HR.EMPLOYEES;
        
 5)LTRIM(c1[,c2]), RTRIM(c1[,c2])
  - �־��� ���ڿ� �ǿ�����(RTRIM) �Ǵ� ����(LTRIM)�� ���ڿ��� c2�� ��ġ�ϸ� ����
  - c2�� �����Ǹ� ������ ����
  
**ȸ�����̺�(MEMBER)�� ������ �����͸� �����Ͽ� CUSTOMER ���̺��� �����ϰ� �̸� �÷�(MEM_NAME)�� ������ Ÿ���� CHAR(20)���� �����Ͻÿ�.
  CREATE TABLE CUSTOMER AS
    SELECT MEM_ID,MEM_NAME,MEM_MILEAGE
      FROM MEMBER;
      
  ALTER TABLE CUSTOMER 
    MODIFY(MEM_NAME CHAR(20));
    
  SELECT *
    FROM CUSTOMER
-- WHERE MEM_NAME = '��ö��';
   WHERE RTRIM(MEM_NAME) = '��ö��';
   
  SELECT MEM_ID,
         RTRIM(MEM_NAME) AS �̸�,
         MEM_MILEAGE
    FROM CUSTOMER;
    
  SELECT LTRIM('PERSIMMON','PER'),
         RTRIM('PERSIMMON','ON')
    FROM DUAL;
    
 6)TRIM(c1)
  - �־��� ���ڿ� c1�� �հ� �ڿ� �����ϴ� ��� ��ȿ�� ������ ����
  - ���ڿ� ������ ���� ���Ŵ� �Ұ���
  
��뿹)CUSTOMER ���̺��� �̸��÷��� �ڷ�Ÿ���� VARCHAR2(20) �������� ��ȯ�Ͻÿ�.
      ALTER TABLE CUSTOMER
        MODIFY(MEM_NAME VARCHAR2(20));
      
      UPDATE CUSTOMER
         SET MEM_NAME = TRIM(MEM_NAME);
         
      COMMIT;
  
      SELECT * FROM CUSTOMER;
      
 7)SUBSTR(c1,n1[,n2])
  - �־��� ���ڿ� c1���� n1��°���� n2������ŭ�� ���ڸ� ����
  - n1, n2�� 1���� �����ϴ� index
  - n2�� �����Ǹ� n1���� �� ������ ��� ���ڿ��� ����
  - ����� ����� ���ڿ���
  - n1�� �����̸� �����ʹ��ڿ����� ó��
  
��뿹)
      SELECT SUBSTR('APPLEBANNER',2,5),
             SUBSTR('APPLEBANNER',2),
             SUBSTR('APPLEBANNER',-6,5)  --�����ʿ��� 6��° ���ں��� 5��
        FROM DUAL;
  
**ȸ�����̺���
           MEM_REGNO1 MEM_REGNO2 MEM_BIR  --MEM_REGNO1 : �ֹι�ȣ ���ڸ�, MEM_REGNO2 : �ֹι�ȣ ���ڸ�
  j001  ������  751019  2448920  1975/11/21 �ڷḦ
  j001  ������  001019  4448920  2000/11/21 ��
  
  UPDATE MEMBER
     SET MEM_REGNO1 = '001019',
         MEM_REGNO2 = '4448920',
         MEM_BIR = '2000/11/21'
   WHERE MEM_ID = 'j001'; 
  COMMIT;
  
  t001	������  760506  1454731  1976/05/06 �ڷḦ
  t001  ������  010506  3454731  2001/05/06 ��
 
  UPDATE MEMBER
     SET MEM_REGNO1 = '010506',
         MEM_REGNO2 = '3454731',
         MEM_BIR = '2001/05/06'
   WHERE MEM_ID = 't001'; 
  COMMIT;  
  
  b001	�̻���  741004  2900000  1974/01/07 �ڷḦ
  b001  �̻���  031004  4900000  2003/01/07 �� ����
  
  UPDATE MEMBER
     SET MEM_REGNO1 = '031004',
         MEM_REGNO2 = '4900000',
         MEM_BIR = '2003/01/07'
   WHERE MEM_ID = 'b001'; 
  COMMIT;  
  
  q001	����ȸ  721020  1402722  1972/10/20 �ڷḦ
  q001  ����ȸ  951020  1402722  1995/10/20 �� ����
  
  UPDATE MEMBER
     SET MEM_REGNO1 = '951020',
         MEM_BIR = '1995/10/20'
   WHERE MEM_ID = 'q001'; 
  COMMIT;    
  
** ǥ����
 - SELECT ������ ���Ǵ� �񱳱���� ���� ����
 - CASE WHEN THEN �� DECODE �� ����
 
 (�������1)
  CASE WHEN ���ǽ�1 THEN ���1
       WHEN ���ǽ�2 THEN ���2
              :
      [ELSE ���n]
  END 
   
 (�������2)
  CASE ���ǽ� WHEN ��1 THEN ���1
             WHEN ��2 THEN ���2
              :
            [ELSE ���n]
  END    

 (�������3)   
  DECODE(�÷���,����1,���1,����2,���2,...)


��뿹)ȸ�����̺��� 20�������� ȸ�������� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ, ȸ����, ����, ����, ���ϸ����̴�.
      �������� '����ȸ��','����ȸ��' �� �ϳ� ���
      ���̴� �ֹι�ȣ�� �̿��Ͽ� ���Ͻÿ�.
      
      SELECT MEM_ID AS ȸ����ȣ,
             MEM_NAME AS ȸ����,
             CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR  
                       SUBSTR(MEM_REGNO2,1,1) = '3' THEN
                       '����ȸ��'
             ELSE     
                       '����ȸ��'  
             END AS ����,
             MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
             CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR
                       SUBSTR(MEM_REGNO2,1,1) = '2' THEN 
                       EXTRACT(YEAR FROM SYSDATE) -
                        (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900) 
             ELSE      
                       EXTRACT(YEAR FROM SYSDATE) -
                        (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 2000)  
             END AS ����,
             MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
       WHERE EXTRACT(YEAR FROM SYSDATE) -
             EXTRACT(YEAR FROM MEM_BIR) <= 29;
  
 8)REPLACE(c1,c2[,c3]) 
  - �־��� ���ڿ� c1�� ���Ե� c2���ڿ��� ã�� c3���ڿ���ġȯ
  - c3�� �����Ǹ� c2���ڿ��� ������
  - �ݺ��� c3�� ��� ����
  - ���ڿ� ���� �������ſ� �ַ� ���
  
 ��뿹)
   SELECT REPLACE('APPLEPERSIMMON','P','K')
     FROM DUAL;
  
   SELECT REPLACE('APPLEPERSIMMON','PL','KL')
     FROM DUAL;  
  
 ��뿹)
   SELECT PROD_ID AS ��ǰ�ڵ�,
          PROD_NAME AS ��ǰ��1,
          REPLACE(PROD_NAME,' ') AS ��ǰ��2,
          PROD_PRICE AS �ǸŰ���
     FROM PROD
    WHERE PROD_COST >= 300000;
      
 9)ASCII(c1), CHR(n1) 
  - ASCII(c1) : c1 ���ڿ��� ù ���ڸ� ASCII �ڵ尪
  - CHR(n1) : n1 �ڵ忡 �����ϴ� ���ڿ� ��ȯ
  
   SELECT ASCII('ABC'), ASCII('��'),
          CHR(65)
     FROM DUAL;
      
 10)LENGTH(c1), LENGTHB(c1)
  - LENGTH(c1) : �־��� ���ڿ� c1 ���� ���ڼ� ��ȯ      
  - LENGTHB(c1) : �־��� ���ڿ� c1 ���� �������� ũ��(BYTE) ��ȯ
  
  
        