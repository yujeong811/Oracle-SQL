2022-0105-02)������Ÿ��
 - ����Ŭ�� ���Ǵ� ������ Ÿ���� ���ڿ�, ����, ��¥, �����ڷ� ���� ����
 1. ���ڿ��ڷ�
  * �����ڷ�(' '�� ���� �ڷ�)�� �����ϱ� ���� Ÿ��
  * �������̿� �������̷� ����
  1)CHAR(n[BYTE|CHAR])
    * �������� ������ ����
    * �ִ� 2000 BYTE���� ó�� ����
    * 'n[BYTE|CHAR]' : Ȯ���ϴ� ��������� ũ�� ����
      'BYTE'�� default�̸� 'CHAR'�� n�� ���ڰ����� �ǹ�
    * �ѱ� �ѱ��ڴ� 3BYTE ��
    * ���� �⺻Ű�� ���̰� �����ǰ� ������ ���̰� �߿��� ���(�ֹι�ȣ�� �����ȣ ��)�� ���
    
��뿹)
  CREATE TABLE TEMP_01(
    COL1 CHAR(10 BYTE),
    COL2 CHAR(10 CHAR),
    COL3 CHAR(10));
    
  INSERT INTO TEMP_01(COL1, COL2, COL3)
    VALUES('������', '������ �߱� ������', '�߱�');
    
  INSERT INTO TEMP_01 VALUES('����', '���ѹα�', '�α�');
    
  SELECT * FROM TEMP_01; 
  SELECT LENGTHB(COL1), --LENGTHB [LENGTH BYTE]--
         LENGTHB(COL2),
         LENGTHB(COL3)
    FROM TEMP_01;
  
  2)VARCHAR2(n[BYTE|CHAR])
    * �������� ���ڿ� ����
    * VARCHAR�� ���ϱ�� ����
    * �ִ� 4000BYTE ���尡��
    * ����ڰ� ������ �����͸� �����ϰ� ���� �������� ��ȯ
    * ���� �θ� ���Ǵ� Ÿ��
    
��뿹)
  CREATE TABLE TEMP_02(
    COL1 VARCHAR2(4000 BYTE),
    COL2 VARCHAR2(4000 CHAR),
    COL3 VARCHAR2(4000));
    
  INSERT INTO TEMP_02 VALUES('IL POSTINO','PERSIMMON','APPLE');
    
  SELECT * FROM TEMP_02;
  SELECT LENGTHB(COL1),
         LENGTHB(COL2),
         LENGTHB(COL3)
    FROM TEMP_02;
    
  3)LONG(���̰� ����)
    * �������� �ڷ� ����
    * �ִ� 2GB���� ���尡�� 
    * �Ϻ� ����� ���Ұ�
    * �� ���̺� 1���� LONG Ÿ�Ը� ��� ����(��ɰ��� �ߴ�)
    * CLOB Ÿ������ ��ü --LONG�� ������--
    * SELECT���� SELECT��, UPDATE���� SET��, INSERT���� VALUES�������� ��� ����

��뿹) 
  CREATE TABLE TEMP_03(
    COL1 LONG,
    COL2 VARCHAR2(200));
    
  INSERT INTO TEMP_03
    VALUES('������ �߱� ���� 846 3��','������簳�߿�');
    
  SELECT * FROM TEMP_03;
  SELECT --LENGTHB(COL1),
         --LENGTH(COL1),
         LENGTHB(COL2)
    FROM TEMP_03;
    
  SELECT --SUBSTR(COL1,2,5)
         SUBSTR(COL2,2,5)
    FROM TEMP_03;
    
  4)CLOB(Character Large OBjects) --���� ���� ����--   
    * �������� ���ڿ��� ����
    * �ִ� 4GB ���� ó�� ����
    * �� ���̺� �������� CLOB ��밡��
    * �Ϻ� ����� DBMS_LOB API������ �޾ƾ� ��(�� LENGTHB ���� ����)

��뿹)
  CREATE TABLE TEMP_04(
    COL1 CLOB,
    COL2 CLOB,
    COL3 VARCHAR2(4000));
    
  INSERT INTO TEMP_04
    VALUES('������ �߱� ���� 846 3��','������簳�߿�','ILPOSTINO');

  SELECT * FROM TEMP_04;
  SELECT DBMS_LOB.GETLENGTH(COL1),
         LENGTH(COL2),
         LENGTHB(COL3)
    FROM TEMP_04;

  
  
  
  
  