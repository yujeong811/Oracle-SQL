2022-0126-02)PL/SQL(Procedural Language SQL)
 - ǥ�� SQL�� ������ ����� Ư¡�� �߰�
 - block ������ ������
 - DBMS�� �̸� �����ϵǾ� ����ǹǷ� ���� ����� ��Ʈ��ũ�� ȿ�������� �̿��Ͽ� ��ü SQL���� ȿ���� ����
 - ����, ���, �ݺ�ó��, ���Ǵ�, ����ó�� ����
 - ǥ�� ������ ����
 - User Defined Function, Stored Procedure, Trigger, Package, Anonymous block ���� ���� --�͸���
 
 1. Anonymous Block(�͸���)
  - PL/SQL�� �⺻ ����
  - ������ �� ����
  (�������)
    DECLARE
      �����-����, ���, Ŀ�� ����;
    BEGIN
      �����-�����ذ��� ���� �����Ͻ� ����ó�� SQL��;
      
     [EXCEPTION
       ����ó����;]
    END;
    
 ��뿹) 1���� 100������ ¦���� �հ� Ȧ���� ���� ���Ͻÿ�
   DECLARE
     V_CNT NUMBER:=1;  --(:=) �Ҵ翬����
     V_ESUM NUMBER:=0; -- ¦��
     V_OSUM NUMBER:=0; -- Ȧ��
   BEGIN  
     LOOP  -- �ݺ����� �⺻ ����
       IF MOD(V_CNT,2)=0 THEN 
         V_ESUM:=V_ESUM+V_CNT;
       ELSE
         V_OSUM:=V_OSUM+V_CNT;
   END IF;
   EXIT WHEN V_CNT>=100;  -- ������ ���̸� ���� Ż��
   V_CNT:=V_CNT+1;
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('¦���� �� : '||V_ESUM); --DBMS_OUTPUT.PUT_LINE : ��� ���
 DBMS_OUTPUT.PUT_LINE('Ȧ���� �� : '||V_OSUM); 
 
 END; 
 
 1)����(���) ����
  - ���߾���� ����, ����� ���� �ǹ�
  (�������)
   ����(���)�� [CONSTANT] ������Ÿ��[(ũ��)]| NOT NULL [:=�ʱⰪ];
   * ������� 'CONSTANT'����� ���
   * �������� �ʱ�ȭ�� �ʿ�
   * ������Ÿ�� : ǥ�� SQL���� ����ϴ� ������Ÿ��, PLS_INTEGER, BINARY_INTEGER : 4BYTE ����, BOOLEAN Ÿ�� ��� ����
 ** ����Ÿ�� -> ������Ÿ�� ��� ���
   ���̺��.�÷���%TYPE : �ش� ���̺��� �÷��� ���� Ÿ��/ũ��� ����(���)�� ����
   ���̺��%ROWTYPE : �ش� ���̺��� �� �� ��ü�� ���� Ÿ������ ���� ���� (C����� STRUCTURE Ÿ�԰� ����)  
   * 'NOT NULL' ������ �ݵ�� �ʱⰪ �����ؾ���  
   
 ��뿹)������ �μ���ȣ(10-110��)�� �����ϰ� �ش�μ��� ���� ��� �� �Ի����� ���� ���� �����ȣ, �����, �Ի���, �μ����� ���      
      DECLARE
       V_DEPTNO HR.DEPARTMENTS.DEPARTMENT_ID%TYPE; --�μ��ڵ�
       V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE; --�����
       V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; --�����ȣ
       V_HDATE DATE; --�Ի���
       V_DNAME VARCHAR2(100); --�μ���
      BEGIN
       V_DEPTO:TRUNC(DBMS_RANDOM.VALUE(10,119),-1); 
       SELECT TBL.AID,TBL.ANAME,TBL.ADATE,TBL.BNAME 
         INTO V_EID,V_ENAME,V_HDATE,V_DNAME
         FROM (SELECT A.EMPLOYEE_ID AS AID, 
                      A.EMP_NAME AS ANAME,
                      A.HIRE_DATE AS ADATE,
                      B.DEPARTMENT_NAME AS BNAME
                 FROM HR.EMPLOYEES A, HR.DEPARTMENTS B             
                WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                  AND A.DEPARTMENT_ID = V_DEPTNO
                ORDER BY 3) TBL
        WHERE ROWNUM = 1;
        DBMS_OUTPUT.PUT_LINE('�����ȣ : '||V_EID);
        DBMS_OUTPUT.PUT_LINE('����� : '||V_ENAME);
        DBMS_OUTPUT.PUT_LINE('�Ի��� : '||V_HDATE);
        DBMS_OUTPUT.PUT_LINE('�μ��� : '||V_DNAME);
      END;
   
 ��뿹)���̸� �ϳ� �Է¹޾� �� ���̸� ���������� �ϴ� ���� �ʺ�, �� ���̸� �� ������ �ϴ� ���簢�� �ʺ� ���� ���Ͻÿ�.  
      ACCEPT P_LEN  PROMPT '���̸� �Է� : '  --ACCEPT ������ �����ݷ� ������ ����
      DECLARE
        V_LENGTH NUMBER:=TO_NUMBER('&P_LEN');
        V_SQUARE NUMBER:=0;  --�簢�� �ʺ�
        V_CIRCLE NUMBER:=0;  --���� �ʺ�
        V_PIE CONSTANT NUMBER:=3.1415926;
      BEGIN
        V_SQUARE:=V_LENGTH*V_LENGTH;
        V_CIRCLE:=V_LENGTH*V_LENGTH * V_PIE;
        
        DBMS_OUTPUT.PUT_LINE('���� �ʺ� : '||V_CIRCLE);
        DBMS_OUTPUT.PUT_LINE('�簢���� �ʺ� : '||V_SQUARE); 
      END;
