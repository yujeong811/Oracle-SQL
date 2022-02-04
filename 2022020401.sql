2022-0204-01)�������ν���(Stored Procedure : Procedure)
 - ������ ����� ���� ������ ���α׷� ���
 - ��� �������α׷����� ����� �� �ֵ��� ����� ĸ��ȭ
 - ���ȼ� Ȯ��
 - ��ȯ���� ����
 (�������)
 CREATE [OR REPLACE] PROCEDURE ���ν�����
  [(�Ű����� [���] ������Ÿ�� [:=[DEFAULT] ��][,])]
                   :
  [(�Ű����� [���] ������Ÿ�� [:=[DEFAULT] ��])]
  AS|IS  --DECLARE ����
    �����;
  BEGIN
    �����;
    [EXCEPTION
      ����ó��;
    ]
  END;
  * '���' : �Ű������� ���� => IN(�Է¿�), OUT(��¿�), INOUT(����¿� : �������)
  * '������Ÿ��' : ũ�⸦ �����ϸ� �ȵ�
  
  (���๮ ����)
  EXECUTE|EXEC ���ν�����(�Ű�����list);
   --�ܵ� ����
  OR
  ���ν�����(�Ű�����list);
   --�ٸ� ���ν��� �Ǵ� �Լ� �� �͸��� ��� ����
   
 ��뿹)��ǰ�ڵ带 �Է¹޾� 2005�� ��������� ����ݾ��� ����ϴ� ���ν��� �ۼ�
   CREATE OR REPLACE PROCEDURE PROC_CART01(
     P_PID IN VARCHAR2)  --PROD.PROD_ID%TYPE
   IS
     V_NAME PROD.PROD_NAME%TYPE;
     V_QTY NUMBER:=0;
     V_AMT NUMBER:=0;
   BEGIN
     SELECT A.PROD_NAME, SUM(B.CART_QTY), SUM(B.CART_QTY * A.PROD_PRICE)
       INTO V_NAME, V_QTY, V_AMT
       FROM PROD A, CART B
      WHERE B.CART_PROD = P_PID
        AND A.PROD_ID=B.CART_PROD
        AND B.CART_NO LIKE '2005%'
      GROUP BY A.PROD_NAME;
     DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : '||P_PID);
     DBMS_OUTPUT.PUT_LINE('��ǰ�� : '||V_NAME);
     DBMS_OUTPUT.PUT_LINE('������� : '||V_QTY);
     DBMS_OUTPUT.PUT_LINE('����� : '||V_AMT);
     DBMS_OUTPUT.PUT_LINE('-----------------------');
   END;
   
  (ȣ�⹮) 
  EXECUTE PROC_CART01('P202000001');  --�̰� �ؾ� ��µ�
   
 ��뿹)�μ���ȣ�� �Է¹޾� �μ���, �ο���, �ּҸ� ��ȯ�ϴ� ���ν��� �ۼ�  
   CREATE OR REPLACE PROCEDURE PROC_EMP01(
     P_DID IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE,
     P_DNAME OUT VARCHAR2, 
     P_CNT   OUT NUMBER,
     P_ADDR  OUT VARCHAR2)
   IS
   BEGIN
     SELECT A.DEPARTMENT_NAME, 
            B.POSTAL_CODE||' '||B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE
       INTO P_DNAME, P_ADDR
       FROM HR.DEPARTMENTS A, HR.LOCATIONS B
      WHERE A.LOCATION_ID=B.LOCATION_ID
        AND A.DEPARTMENT_ID=P_DID;
     SELECT COUNT(*)
       INTO P_CNT
       FROM HR.EMPLOYEES
      WHERE DEPARTMENT_ID=P_DID;
   END;
   
  (����) 
   ACCEPT P_ID PROMPT '�μ��ڵ� �Է�(10~110) : '
   DECLARE
     V_DNAME VARCHAR2(200);
     V_CNT   NUMBER:=0;
     V_ADDR  VARCHAR2(200);   
   BEGIN
     PROC_EMP01(TO_NUMBER('&P_ID'),V_DNAME,V_CNT,V_ADDR);
     DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : '||'&P_ID');
     DBMS_OUTPUT.PUT_LINE('�μ��� : '||V_DNAME);
     DBMS_OUTPUT.PUT_LINE('�ο��� : '||V_CNT);
     DBMS_OUTPUT.PUT_LINE('�ּ� : '||V_ADDR);
     DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
   END;
    
 ��뿹)�⵵�� ���� �Է¹޾� �ش� ���� ���� ���� ������ ȸ���� ȸ����ȣ, �̸�, �ּ�, ���ϸ����� ��ȯ�ϴ� ���ν����� �ۼ�
       ���ν������� 'PROC_MEM01'�̴�.
   CREATE OR REPLACE PROCEDURE PROC_MEM01(
     P_PERIOD IN VARCHAR2,   --�⵵�� ���� �Ѳ����� �Է�
     P_MID   OUT MEMBER.MEM_ID%TYPE,
     P_NAME  OUT MEMBER.MEM_NAME%TYPE, 
     P_ADDR  OUT VARCHAR2,
     P_MILE  OUT MEMBER.MEM_MILEAGE%TYPE)
   IS
     V_PERIOD VARCHAR2(7):=P_PERIOD||'%';
   BEGIN
     SELECT TBL.AID
       INTO P_MID
       FROM (SELECT A.CART_MEMBER AS AID,   --(.)�� �ΰ��پ ������ �� �ȵɼ��� �־ �÷���Ī �ο�
                    SUM(A.CART_QTY*B.PROD_PRICE)  --MAX(SUM( --> �Ұ���, �����Լ� ���ÿ� �� �� ����
               FROM CART A, PROD B          --SUBQUERY : �Է¹��� �Ⱓ���ȿ� ȸ���� ����� ����(���� ������� ���� ��������� ����)
              WHERE CART_NO LIKE V_PERIOD 
                AND A.CART_PROD=B.PROD_ID
              GROUP BY A.CART_MEMBER
              ORDER BY 2 DESC) TBL
      WHERE ROWNUM=1;  --������� ���� ���� ���(�� ����)
     SELECT MEM_NAME,
            MEM_ADD1||' '||MEM_ADD2,
            MEM_MILEAGE
       INTO P_NAME,P_ADDR,P_MILE     
       FROM MEMBER
      WHERE MEM_ID=P_MID;
   END;  
  
  (����)
   DECLARE
     V_MID MEMBER.MEM_ID%TYPE;
     V_NAME VARCHAR2(50);
     V_ADDR VARCHAR2(100);
     V_MILE NUMBER:=0;
   BEGIN
     PROC_MEM01('200505',V_MID,V_NAME,V_ADDR,V_MILE);
     DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_MID);
     DBMS_OUTPUT.PUT_LINE('ȸ���� : '||V_NAME);
     DBMS_OUTPUT.PUT_LINE('�ּ� : '||V_ADDR);
     DBMS_OUTPUT.PUT_LINE('���ϸ��� : '||V_MILE);
   END;
 
 ��뿹)�⵵�� ���� �Է¹޾� ��ǰ�� ���Լ����� ���ѵ� ���������̺��� �����Ͻÿ�
   CREATE OR REPLACE PROCEDURE PROC_REMAIN01(
     P_PERIOD IN VARCHAR2)
   IS
     V_SDATE DATE:=TO_DATE(P_PERIOD||'01'); --������
     V_EDATE DATE:=LAST_DAY(V_SDATE); -- ��������
     V_QTY NUMBER:=0;
     CURSOR CUR_BUY02
     IS
       SELECT BUY_PROD AS BID,
              SUM(BUY_QTY) AS BAMT
         FROM BUYPROD
        WHERE BUY_DATE BETWEEN V_SDATE AND V_EDATE
        GROUP BY BUY_PROD;
   BEGIN
     FOR REC IN CUR_BUY02 LOOP
       UPDATE REMAIN
          SET REMAIN_I=REMAIN_I+REC.BAMT,
              REMAIN_J_99=REMAIN_J_99+REC.BAMT,
              REMAIN_DATE=V_EDATE
        WHERE REMAIN_YEAR=SUBSTR(P_PERIOD,1,4)
          AND PROD_ID=REC.BID;
       COMMIT;
     END LOOP;
   END;
 
   EXECUTE PROC_REMAIN01('200503'); 
   
   SELECT * FROM REMAIN;  
 
   SELECT DISTINCT BUY_PROD
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN '20050301' AND '20050331';
  