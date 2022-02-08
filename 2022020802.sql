2022-0208-02)
 ** CART���̺� ���� �ڷḦ �����Ͻÿ�.
    �������� : ����
    ����ȸ�� : d001
    ���Ż�ǰ
    -------------------
     ��ǰ��ȣ      ����
    -------------------
    P201000003     3
    P201000015     2
    P301000003     4
    P302000016     3
  
    CREATE OR REPLACE FUNCTION FN_CREATE_CARTNO(
      P_DATE DATE)
      RETURN VARCHAR2
    IS
      V_CNO VARCHAR2(20):=TO_CHAR(P_DATE,'YYYYMMDD');
      V_FLAG NUMBER:=0;
    BEGIN
      SELECT COUNT(*) INTO V_FLAG
        FROM CART
       WHERE SUBSTR(CART_NO,1,8)=V_CNO; --���� ���� ������ V_FLAG�� �ֱ�
       
      IF V_FLAG=0 THEN --�Ǹ��ڷᰡ �ϳ��� ���� 
         V_CNO:=V_CNO||TRIM('00001');
      ELSE
         SELECT MAX(CART_NO)+1 INTO V_CNO
           FROM CART
          WHERE SUBSTR(CART_NO,1,8)=V_CNO;
      END IF;
      RETURN V_CNO;
    END;

 (����)
 --CART���̺� ���ڿ��� ������ CARTNO�� �ڵ����� ����
    SELECT FN_CREATE_CARTNO(SYSDATE)
      FROM DUAL;
      
    SELECT FN_CREATE_CARTNO(TO_DATE('20050505')),
           FN_CREATE_CARTNO(TO_DATE('20050513')) 
      FROM DUAL;     
      
      
 ** CART���̺� ���� �ڷḦ �����Ͻÿ�.
    �������� : ����(20050728)
    ����ȸ�� : d001
    ���Ż�ǰ     
    -------------------
     ��ǰ��ȣ      ����
    -------------------
    P201000003     3
    P201000015     2
    
  INSERT INTO CART
   VALUES ('d001',FN_CREATE_CARTNO(TO_DATE('20050728')),'P201000003',3);
   
  UPDATE CART
     SET CART_QTY=30
   WHERE CART_NO='2005072800005'
     AND CART_PROD='P201000003';
     
  DELETE FROM CART
   WHERE CART_NO='2005072800005'
     AND CART_PROD='P201000003';

  -- Ʈ���ſ��� ó���ؾ��� ���� : ��� UPDATE, ���ϸ��� UPDATE
    CREATE OR REPLACE TRIGGER TG_CART_CHANGE
      AFTER  INSERT OR UPDATE OR DELETE  ON CART
      FOR EACH ROW
    DECLARE  
      V_QTY NUMBER:=0; --��� ������ ���� ����
      V_PID PROD.PROD_ID%TYPE; --��ǰ�ڵ�
      V_MILE NUMBER:=0; --���ϸ���
      V_DATE DATE; --��¥
      V_MID MEMBER.MEM_ID%TYPE; --ȸ����ȣ
    BEGIN
      IF INSERTING THEN --�ű��Ǹ��ڷ�
         V_QTY:=:NEW.CART_QTY;
         V_PID:=:NEW.CART_PROD;
         V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
         V_MID:=:NEW.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
           FROM PROD
          WHERE PROD_ID=V_PID;
      ELSIF UPDATING THEN --�Ǹż�������
         V_QTY:=:NEW.CART_QTY - :OLD.CART_QTY;
         V_PID:=:NEW.CART_PROD;
         V_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
         V_MID:=:NEW.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
           FROM PROD
          WHERE PROD_ID=V_PID;
      ELSIF DELETING THEN --�Ǹ����
         V_QTY:= -(:OLD.CART_QTY);
         V_PID:= :OLD.CART_PROD;
         V_DATE:= TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
         V_MID:= :OLD.CART_MEMBER;
         SELECT V_QTY*PROD_MILEAGE INTO V_MILE
           FROM PROD
          WHERE PROD_ID=V_PID;
      END IF;
         UPDATE REMAIN
            SET REMAIN_O=REMAIN_O+V_QTY,
                REMAIN_J_99=REMAIN_J_99-V_QTY,
                REMAIN_DATE=V_DATE
          WHERE PROD_ID=V_PID
            AND REMAIN_YEAR=EXTRACT(YEAR FROM V_DATE);
          
         UPDATE MEMBER
            SET MEM_MILEAGE=MEM_MILEAGE+V_MILE
          WHERE MEM_ID=V_MID;
    END;
 
 ROLLBACK;   
 (�����ȸ)
   SELECT * FROM REMAIN
    WHERE PROD_ID='P201000003';
    
   SELECT MEM_MILEAGE
     FROM MEMBER
    WHERE MEM_ID='d001'; 
    
   COMMIT;   
      
      
      
      
