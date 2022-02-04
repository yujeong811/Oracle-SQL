2022-0203-02)Ŀ��(CURSOR)
 - Ŀ���� SQL ������� ������� ����� ����
 - SELECT���� Ŀ���� ��� ����
 - Ŀ���� ������Ŀ��(IMPLICITE CURSOR)�� �����Ŀ��(EXPLICITE CURSOR)�� ����
 1. ������ Ŀ��
  * �̸��� ���� Ŀ��
  * SELECT���� ��� ����
  * ������Ŀ���� �׻� CLOSE�Ǿ� �־� Ŀ�� ������ �ڷ� ������ �Ұ���
  * ������ Ŀ�� �Ӽ�
  ---------------------------------------------------------
   Ŀ��               �ǹ�
  ---------------------------------------------------------
  SQL%ISOPEN       Ŀ���� ���ٰ����� ����(OPEN)�ΰ��� �Ǵ��Ͽ�
                   OPEN�����̸� ��, �ƴϸ� ������ ��ȯ
                   ������Ŀ���� �׻� FALSE ��
  SQL%FOUND        Ŀ������ ��(ROW)�� �����ϸ� ��, ������ ������ȯ      
  SQL%NOTFOUND     Ŀ������ ��(ROW)�� �����ϸ� ����, ������ ����ȯ
  SQL%ROWCOUNT     Ŀ������ ���� �� ��ȯ
  ---------------------------------------------------------
  
 2. ����� Ŀ��  
  * �̸��� �ο��� Ŀ��
  * ���� ����ο��� ����
  * �����Ŀ���� '����'->'OPEN'->'FETCH'->'CLOSE' �ܰ� ������ ó�� (��, FOR���� ����)
  1)����
   - ����ο� ���
   (��������)
    CURSOR Ŀ����[(������ Ÿ��[,...])]
    IS
      SELECT ��;
     *'������'�� ���� �Ҵ��ϴ� ���� OPEN������ ����

  2)OPEN
   - Ŀ���� ����ϱ� ���� ������� ����� Ŀ���� ���� ������ ���·� ����
   - Ŀ���� �Ű������� ����� ��� OPEN������ ���� ����
   - BEGIN ��Ͽ� ���
  (�������)
   OPEN Ŀ����[(��,...)];

  3)FETCH ��
   - Ŀ�����ο� �� ������� �ڷḦ �о� ������ �Ҵ�
   - BEGIN ��Ͽ� ����Ǹ� ���� �ݺ��� ���ο� ���
  (�������)
   FETCH Ŀ���� INTO ������[,������...]
    * Ŀ�������� �÷��� ������ ���� �� �ڷ�Ÿ�԰� INTO���� ���� ����, ����, �ڷ�Ÿ���� ��ġ�ؾ���
    * Ŀ���÷� ���� ������ ���ʴ�� �Ҵ�
    
  4)CLOSE ��
   - ����� ����� Ŀ���� �ݵ�� CLOSE�Ǿ�� ��
   - Ŀ���� �ٽ� OPEN �����ϳ� �����͸� FETCH, ����, ������ �� ����
   
 ��뿹)�μ���ȣ 100�� �μ��� ���� ��������� Ŀ���� �̿��Ͽ� ����Ͻÿ�
     DECLARE 
       CURSOR CUR_EMP01(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
       IS
         SELECT A.EMPLOYEE_ID,A.EMP_NAME,B.JOB_TITLE,A.HIRE_DATE 
           FROM HR.EMPLOYEES A, HR.JOBS B
          WHERE A.JOB_ID=B.JOB_ID
            AND A.DEPARTMENT_ID=P_DID;
       V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
       V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
       V_JTITLE HR.JOBS.JOB_TITLE%TYPE;
       V_HDATE HR.EMPLOYEES.HIRE_DATE%TYPE;
     BEGIN  
       OPEN CUR_EMP01(100);
       
       /*LOOP �������
       LOOP
        FETCH CUR_EMP01 INTO V_EID,V_ENAME,V_JTITLE,V_HDATE;
        EXIT WHEN CUR_EMP01%NOTFOUND; -- ���� �ڷᰡ ������
        DBMS_OUTPUT.PUT_LINE('�����ȣ : '||V_EID);
        DBMS_OUTPUT.PUT_LINE('����� : '||V_ENAME);
        DBMS_OUTPUT.PUT_LINE('������ : '||V_JTITLE);
        DBMS_OUTPUT.PUT_LINE('�Ի��� : '||V_HDATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
       END LOOP;
       CLOSE CUR_EMP01;
     END;  
       
       /* WHILE ������� 
        FETCH CUR_EMP01 INTO V_EID,V_ENAME,V_JTITLE,V_HDATE;       
        WHILE CUR_EMP01%FOUND LOOP  
        DBMS_OUTPUT.PUT_LINE('�����ȣ : '||V_EID);
        DBMS_OUTPUT.PUT_LINE('����� : '||V_ENAME);
        DBMS_OUTPUT.PUT_LINE('������ : '||V_JTITLE);
        DBMS_OUTPUT.PUT_LINE('�Ի��� : '||V_HDATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
        FETCH CUR_EMP01 INTO V_EID,V_ENAME,V_JTITLE,V_HDATE;        
       END LOOP;
       CLOSE CUR_EMP01;
     END;    
  
       /* FOR�� ��� */
     DECLARE 
       CURSOR CUR_EMP01
       IS
         SELECT A.EMPLOYEE_ID AS AEID,
                A.EMP_NAME AS AENAME,
                B.JOB_TITLE AS BJTITLE,
                A.HIRE_DATE AS AHDATE 
           FROM HR.EMPLOYEES A, HR.JOBS B
          WHERE A.JOB_ID=B.JOB_ID
            AND A.DEPARTMENT_ID=100;
     BEGIN   
       FOR REC IN CUR_EMP01 LOOP        
        DBMS_OUTPUT.PUT_LINE('�����ȣ : '||REC.AEID);
        DBMS_OUTPUT.PUT_LINE('����� : '||REC.AENAME);
        DBMS_OUTPUT.PUT_LINE('������ : '||REC.BJTITLE);
        DBMS_OUTPUT.PUT_LINE('�Ի��� : '||REC.AHDATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
       END LOOP;
     END;     
 
 -- FOR��(IN-LINE SUBQUERY ���) 
     DECLARE 
     BEGIN      
       FOR REC IN (SELECT A.EMPLOYEE_ID AS AEID,
                          A.EMP_NAME AS AENAME,
                          B.JOB_TITLE AS BJTITLE,
                          A.HIRE_DATE AS AHDATE 
                     FROM HR.EMPLOYEES A, HR.JOBS B
                    WHERE A.JOB_ID=B.JOB_ID
                      AND A.DEPARTMENT_ID=100)
       LOOP        
        DBMS_OUTPUT.PUT_LINE('�����ȣ : '||REC.AEID);
        DBMS_OUTPUT.PUT_LINE('����� : '||REC.AENAME);
        DBMS_OUTPUT.PUT_LINE('������ : '||REC.BJTITLE);
        DBMS_OUTPUT.PUT_LINE('�Ի��� : '||REC.AHDATE);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
       END LOOP;
     END;     
  
 ��뿹)�������� '�泲'�� ȸ������ 2005�� ���������� ��ȸ�Ͻÿ�   
       Alias�� ȸ����ȣ, ȸ����, �ּ�, ���űݾ�, ���ϸ���
 (Ŀ�� : �������� �泲�� ȸ������ ȸ����ȣ)
  
  DECLARE
   V_AMT NUMBER:=0;    --���űݾ� ����� �� �����ϴ� ��
   V_RES VARCHAR2(500);
   CURSOR CUR_CART02 IS
     SELECT MEM_ID,MEM_NAME,MEM_ADD1||' '||MEM_ADD2 AS ADDR,
            MEM_MILEAGE
       FROM MEMBER
      WHERE MEM_ADD1 LIKE '�泲%';
  BEGIN
   FOR REC IN CUR_CART02 LOOP
       SELECT SUM(CART_QTY*PROD_PRICE) INTO V_AMT
         FROM CART, PROD
        WHERE CART_MEMBER=REC.MEM_ID
          AND CART_PROD=PROD_ID
          AND CART_NO LIKE '2005%';
       V_RES:=REC.MEM_ID||' '||REC.MEM_NAME||' '||RPAD(REC.ADDR,30,' ')||LPAD(V_AMT,9,' ')||LPAD(REC.MEM_MILEAGE,6,' ');
       DBMS_OUTPUT.PUT_LINE(V_RES);
   END LOOP;    
  END;
 
 ��뿹)����� ���� 5���� ��ǰ�� ���� 2005�� ���������� ��ȸ�Ͻÿ�
       Alias�� ��ǰ�ڵ�, ��ǰ��, ��������, ���Լ���
 (Ŀ�� : ����� ���� 5�� ��ǰ�ڵ� ���) 
  SELECT A.PROD_ID AS APID,
         A.REMAIN_J_99 AS AJ99
    FROM (SELECT PROD_ID, REMAIN_J_99
            FROM REMAIN
           ORDER BY 2 DESC) A
   WHERE ROWNUM <= 5;
   
   DECLARE
    CURSOR CUR_BUY01 IS
      SELECT A.PROD_ID AS APID
        FROM (SELECT PROD_ID, REMAIN_J_99
                FROM REMAIN
               ORDER BY 2 DESC) A
       WHERE ROWNUM <= 5;
       V_PNAME PROD.PROD_NAME%TYPE;
       V_QTY NUMBER:=0;
   BEGIN
    FOR REC IN CUR_BUY01 LOOP
      SELECT PROD_NAME INTO V_PNAME
        FROM PROD
       WHERE PROD_ID=REC.APID;
      SELECT SUM(BUY_QTY) INTO V_QTY
        FROM BUYPROD
       WHERE BUY_PROD=REC.APID
         AND EXTRACT(YEAR FROM BUY_DATE)=2005;
        DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : '||REC.APID);
        DBMS_OUTPUT.PUT_LINE('��ǰ�� : '||V_PNAME);
        DBMS_OUTPUT.PUT_LINE('���Լ����հ� : '||V_QTY);
        DBMS_OUTPUT.PUT_LINE('-------------------------');
      END LOOP;
    END;
  