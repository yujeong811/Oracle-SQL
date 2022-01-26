2022-0106-02)��¥ �ڷ���
 - ��,��,��,��,��,�� ���� �ڷḦ ����
 - ��¥���� '+', '-' ������ ����
 - �⺻ ��¥�� : DATE, �ð��������� �����ϴ� TIMESTAMP���� ����
 1) DATE
  * �⺻ ��¥ Ÿ��
  * SYSDATE : ��¥�Լ��� �ý����� �ð������� ����
  
��뿹)
  CREATE TABLE TEMP_05(
    COL1 DATE,
    COL2 DATE,
    COL3 DATE);
    
  INSERT INTO TEMP_05
    VALUES(SYSDATE, SYSDATE-5, '20100106');
    
  INSERT INTO TEMP_05
    VALUES(SYSDATE, SYSDATE+30, '20100228');
    
  SELECT * FROM TEMP_05;
  
  (�ð����� ��� : TO_CHAR())
  SELECT TO_CHAR(COL1, 'YYYY-MM-DD HH24:MI:SS'),
         TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
         TO_CHAR(COL3, 'YYYY-MM-DD HH24:MI:SS')
    FROM TEMP_05;
    
 2) TIMESTAMP
  * ������ ��¥����(�ð��� ����, 10����� 1��) ����
  * TIMESTAMP : �ð��� ���� ����
    TIMESTAMP WITH TIME ZONE : �ð������� ����
    TIMESTAMP WITH LOCAL TIME ZONE : ���ü����� ��ġ�� �ð������� => TIMESTAMP�� ����
    
��뿹)
  CREATE TABLE TEMP_06(
    COL1 TIMESTAMP, 
    COL2 TIMESTAMP WITH TIME ZONE,
    COL3 TIMESTAMP WITH LOCAL TIME ZONE);
    
  INSERT INTO TEMP_06 VALUES(SYSDATE,SYSDATE,SYSDATE);
    
  SELECT * FROM TEMP_06;
  
  
  
  
    
    
    
    
    
    