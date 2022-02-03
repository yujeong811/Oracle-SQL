2022-0125-02)SEQUENCE
 - ���ʴ�� �����Ǵ� �������� �� ��ȯ
 - ���̺�� �������̸� ���� ���̺��� ���ÿ� ��� ����
 - �⺻Ű�� ���ų� PK�� �ǹ��ֱ� ������ �ʾƵ� �Ǵ� ���
 - �ڵ������� �ο��Ǵ� ��ȣ�� �ʿ��� ���
 (�������)
 CREATE SEQUENCE ��������
   [START WITH n]          --���۰�(n)���� �����ϸ� MINVALUE�� �Ҵ�
   [INCREMENT BY n]        --����[����]��, �����̸� ���Ұ�
   [MAXVALUE n|NOMAXVALUE] --�ִ밪 ����, �⺻�� NOMAXVALUE(10^27)
   [MINVALUE n|NOMINVALUE] --�ּҰ� ����, �⺻�� NOMINVALUE(1)
   [CYCLE|NOCYCLE]         --�ִ�(�ּ�)�� ���� �� �ٽ� ��������������, �⺻�� NOCYCLE
   [CACHE n|NOCACHE]       --�޸𸮿� �̸� ��������, �⺻�� CACHE 20
   [ORDER|NOORDER]         --���� ���û��״�� ������ ������ ��������, NOORDER�� �⺻
   
 - SEQUENCE���� ���Ǵ� �ǻ��÷�
 -----------------------------------
  �ǻ��÷�         �ǹ�
 -----------------------------------
 ��������.CURRVAL �������� �����ִ� ���簪
 ��������.NEXTVAL �������� ���� �� ��ȯ
 -----------------------------------
 **�������� ������ �� ó�� ����Ǿ���ϴ� ����� NEXTVAL�̾����
 
 (��뿹)
   CREATE SEQUENCE SEQ_SAMPLE
     START WITH 10;
     
   SELECT SEQ_SAMPLE.NEXTVAL FROM DUAL;  
     
   SELECT SEQ_SAMPLE.CURRVAL FROM DUAL;     
   
 ��뿹)�з����̺� ���� �ڷḦ �߰� �Ͻÿ�
       ��, LPROD_ID�� �������� �����Ͽ� ����� �� --10����
       [�ڷ�]
       -----------------------
        �з��ڵ�        �з���
       -----------------------
         P501         ��깰
         P502         ���깰
         P503         �ӻ깰  
       -----------------------
 (������ ����)      
   CREATE SEQUENCE SEQ_LPROD_ID
     START WITH 10;
   
   INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
     VALUES(SEQ_LPROD_ID.NEXTVAL, 'P501', '��깰');
     
   INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
     VALUES(SEQ_LPROD_ID.NEXTVAL, 'P502', '���깰');  
     
   INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
     VALUES(SEQ_LPROD_ID.NEXTVAL, 'P503', '�ӻ깰'); 
     
   SELECT * FROM LPROD;   
   
 ��뿹)������ 2005�� 7�� 8���̶��ϰ� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�(������ ���)
   CREATE OR REPLACE PROCEDURE PROC_CARTNO_CREATE(
     P_DATE IN DATE,
     P_CNUM OUT NUMBER)
   IS
     V_NUM NUMBER:=0;
     V_CNO CHAR(9):=TO_CHAR(P_DATE,'YYYYMMDD')||'%';
   BEGIN
     SELECT MAX(TO_NUMBER(SUBSTR(CART_NO,9)))+1
       INTO V_NUM
       FROM CART
      WHERE CART_NO LIKE V_CNO;
     P_CNUM:=V_NUM;
   END;
     
 (����)
   DECLARE
    V_CNO CHAR(13);
    V_CNUM NUMBER:=0;
   BEGIN
    PROC_CARTNO_CREATE('20050708',V_CNUM);   --PROC_CARTNO_CREATE : ���ν��� �̸�,  V_CNUM : �Ѱ��� ��
    V_CNO:='20050708'||TRIM(TO_CHAR(V_CNUM,'00000'));
    DBMS_OUTPUT.PUT_LINE('��ٱ��Ϲ�ȣ : '||V_CNO);
   END;
   
 **�������� ����� �� ���� ���
  * SELECT, UPDATE, DELETE ���� ���Ǵ� SUBQUERY
  * VIEW�� QUERY
  * DISTINCT�� ���� SELECT��
  * GROUP BY, ORDER BY���� �ִ� SELECT��
  * SELECT ���� WHERE��
 