2022-0113-01)����ȯ�Լ�
 1)CAST(expr AS Ÿ��)
  - 'expr'�� ���ǵ� �÷� �Ǵ� ������ ������ Ÿ���� 'Ÿ�Ը�' �������� ��ȯ

 ��뿹)��ٱ������̺��� 2005�� 5�� �Ǹ������� ��ȸ�Ͻÿ�
       Alias�� ����, ��ǰ��, ����, �ݾ��̸� ���ڼ����� ����Ͻÿ�
       SELECT CAST(SUBSTR(CART.CART_NO,1,8) AS DATE) AS ����, --CAST(____ AS DATE) : ��¥������ �ٲ���
              PROD.PROD_NAME AS ��ǰ��,
              CART.CART_QTY AS ����,
              CART.CART_QTY * PROD_PRICE AS �ݾ�
         FROM CART, PROD
        WHERE CART.CART_PROD = PROD.PROD_ID --��������
          AND CART.CART_NO LIKE '200505%'
        ORDER BY 1;
        
 2)TO_CHAR(expr[,fmt])
  - ���ڿ�, ����, ��¥ �ڷḦ ���ڿ� �ڷ�� ����ȯ
  - ��ȯ������ �����Ҷ����� 'fmt'(�����������ڿ�)�� ���
  
  - ��¥���� ���Ĺ��ڿ�
----------------------------------------------------------------------------------
      FORMAT              �ǹ�                         ��뿹 
----------------------------------------------------------------------------------
      BC, AD           ����, �����      SELECT TO_CHAR(SYSDATE, 'BC') FROM DUAL;
----------------------------------------------------------------------------------  
        CC                ����          SELECT TO_CHAR(SYSDATE, 'CC') FROM DUAL;
----------------------------------------------------------------------------------  
  YYYY,YYY,YY,Y           �⵵          SELECT TO_CHAR(SYSDATE, 'YYYY'),
                                              TO_CHAR(SYSDATE, 'YYY'),
                                              TO_CHAR(SYSDATE, 'YY'),
                                              TO_CHAR(SYSDATE, 'Y') 
                                         FROM DUAL;  
 ---------------------------------------------------------------------------------
        MM             (1 ~ 12��)       SELECT TO_CHAR(SYSDATE, 'MM'),
    MON, MONTH             ��                  TO_CHAR(SYSDATE, 'MONTH'),
                                               TO_CHAR(SYSDATE, 'MON')
                                          FROM DUAL;     
----------------------------------------------------------------------------------                                          
        DD             (1 ~ 31��)        SELECT TO_CHAR(SYSDATE, 'DD'),
       DDD             (1 ~ 365��)              TO_CHAR(SYSDATE, 'DDD'),
        D            ���� ���� ���� ��             TO_CHAR(SYSDATE, 'D'),
        DY             '��' ~ '��'               TO_CHAR(SYSDATE, 'DY'),
       DAY          '������' ~ '�Ͽ���'            TO_CHAR(SYSDATE, 'DAY')
                                           FROM DUAL;
----------------------------------------------------------------------------------  
        WW            ���� ��(01~53)     SELECT TO_CHAR(SYSDATE, 'WW') FROM DUAL;
      AM, PM            ����, ����       SELECT TO_CHAR(SYSDATE, 'PM') FROM DUAL;       
    A.M., P.M.          ����, ����
   HH,HH12,HH24            �ð�         SELECT TO_CHAR(SYSDATE, 'HH') FROM DUAL;
        MI                  ��
        SS              ��(01~60)       SELECT TO_CHAR(SYSDATE, 'HH:MI:SS'),    
      SSSSS           ��(01~86000)             TO_CHAR(SYSDATE, 'HH:MI:SSSSS')
                                         FROM DUAL; 
----------------------------------------------------------------------------------
    SELECT TO_CHAR(CAST(SUBSTR(CART_NO,1,8) AS VARCHAR2(8)))
      FROM CART
     WHERE CART_NO LIKE '200504%';
     
    SELECT TO_CHAR(CART_NO) FROM CART;
    
    
  - ���ڰ��� ���Ĺ��ڿ�
-----------------------------------------------------------------------------------
  FORMAT           �ǹ�                                 ��뿹 
-----------------------------------------------------------------------------------
    9    �����Ǵ� ��ȿ�� 0�� ����ó��      SELECT TO_CHAR(12345,'9999999') FROM DUAL;
    0    �����Ǵ� ��ȿ�� 0�� '0'���� ���  SELECT TO_CHAR(12345,'0000000') FROM DUAL;
   PR    �ڷᰡ �����̸� <>�ȿ� ���       SELECT TO_CHAR(1234,'99999PR'),
                                             TO_CHAR(-1234,'99999PR') FROM DUAL;
    ,    �ڸ���                        SELECT TO_CHAR(1234,'99,999.9PR'),                                                                            
    .    �Ҽ���                               TO_CHAR(-1234,'99,999.0PR') FROM DUAL; 
   $,L   ȭ���ȣ                      SELECT TO_CHAR(1234,'$99,999.9'),    
                                             TO_CHAR(1234,'L99,999.9') FROM DUAL;    
-----------------------------------------------------------------------------------     

 ��뿹)������ 2005�� 7�� 31���̰� ���θ� �������� ó�� �α��� �� ��� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�.
       SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')||TO_CHAR(1,'00000')
         FROM DUAL;
     
 ��뿹)������ 2005�� 7�� 28���̰� ���θ��� ���Ӱ� �α����� ��� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�.
       SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1, '00000'))
         FROM CART
        WHERE SUBSTR(CART_NO,1,8) = TO_CHAR(SYSDATE,'YYYYMMDD');
     
 3)TO_NUMBER(expr[,fmt])
  - ���ڿ��� �����ڷ�� ��ȯ
  - ��ȯ��ų �����ڷ�� ���ڷ� ��ȯ ������ �ڷ��̾�� ��
  - 'fmt'�� TO_CHAR���� ���� �Ͱ� ����
  
  CREATE TABLE GOODS AS
    SELECT PROD_ID, PROD_NAME, PROD_LGU, PROD_PRICE
      FROM PROD;
      
  SELECT * FROM GOODS;
     
 ��뿹)��ǰ���̺�(PROD)�� ���� �ڷḦ �߰��� ����Ͻÿ�
   ��ǰ�� : �Ｚ ��Ʈ�� 15��ġ
   �ŷ�ó�ڵ� : P101
   �ǸŰ��� : 1200000��
   
   (��ǰ�ڵ� ����)
   SELECT 'P101'
           ||TRIM(TO_CHAR(TO_NUMBER(
             SUBSTR(MAX(PROD_ID),5))+1, '000000')) AS P_CODE
     FROM GOODS
    WHERE PROD_LGU='P101';
     
   (�߰����)
   INSERT INTO GOODS
    SELECT A.P_CODE, '�Ｚ ��Ʈ�� 15��ġ', 'P101', 1200000
      FROM (SELECT 'P101'
                   ||TRIM(TO_CHAR(TO_NUMBER(
                     SUBSTR(MAX(PROD_ID),5))+1,'000000')) AS P_CODE
              FROM GOODS
             WHERE PROD_LGU='P101') A;
             
   SELECT * FROM GOODS
    WHERE PROD_LGU='P101';          
  
   SELECT TO_NUMBER('?1,234','L99,999'),
          TO_NUMBER('<1,234>','9,999PR')+10
     FROM DUAL;
  
 4)TO_DATE(expr[,fmt])
  - ��¥������ ���ڿ� �ڷḦ ��¥�������� ��ȯ�Ͽ� ��ȯ
  - 'fmt'�� TO_CHAR���� ���� ��¥�� ���Ĺ��ڿ��� ����
  
 ��뿹)
   SELECT TO_DATE('20050708'),
          TO_CHAR(TO_DATE('20220113092035','YYYYMMDDHHMISS'),'YYYY/MM/DD HH:MI:SS')
     FROM DUAL;
     
 ��뿹)ȸ�����̺��� �ֹε�Ϲ�ȣ�� �̿��Ͽ� ������ ���� �������� �ڷḦ ����Ͻÿ�
       ���
       ȸ����ȣ     ȸ����     �������       ����      ���ϸ���
        XXXX       XXX  1997�� 00�� 00��  �ڿ���      9999
        
   SELECT MEM_ID AS ȸ����ȣ,
          MEM_NAME AS ȸ����,
          CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR  
                    SUBSTR(MEM_REGNO2,1,1) = '2' THEN
               TO_CHAR(TO_DATE('19'||MEM_REGNO1), 'YYYY"��" MM"��" DD"��"') 
          ELSE
               TO_CHAR(TO_DATE('20'||MEM_REGNO1), 'YYYY"��" MM"��" DD"��"') 
          END AS �������,
          MEM_JOB AS ����,
          MEM_MILEAGE AS ���ϸ���
     FROM MEMBER;









      