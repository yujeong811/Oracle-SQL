2022-0204-02)�Լ�(User Defined Function : Function)
 - Ư¡�� PROCEDURE�� �����ϳ� ��ȯ���� ������
 - SELECT���� SELECT��, WHERE��, UPDATE���� � ���
 (�������)
  CREATE [OR REPLACE] FUNCTION �Լ���[(
    ������ [���] Ÿ�Ը� [:=[DEFAULT] ��][,]
                     :
    ������ [���] Ÿ�Ը� [:=[DEFAULT] ��])
    RETURN Ÿ�Ը�
  AS|IS
    �����;
  BEGIN
    �����;
    RETURN expr;
    [EXCEPTION
        ����ó����;
    ]
  END;  
  
 (��뿹)�ŷ�ó�ڵ带 �Է¹޾� �ش� �ŷ�ó ������ ��ȸ�Ͻÿ�.(�Լ����)
       Alias�� �ŷ�ó�ڵ�, ��ǰ�ڵ�, ��ǰ��, ���Դܰ�
   CREATE OR REPLACE FUNCTION FN_PROD_INFO(
     P_BID IN BUYER.BUYER_ID%TYPE)
     RETURN VARCHAR2
   IS
     V_RES VARCHAR2(100);
   BEGIN
     SELECT PROD_ID||' '||RPAD(PROD_NAME,20,' ')||
            LPAD(PROD_COST,8,' ')
       INTO V_RES
       FROM PROD
      WHERE PROD_BUYER=P_BID
        AND ROWNUM=1;
     RETURN V_RES;
     
     EXCEPTION 
       WHEN OTHERS THEN 
         DBMS_OUTPUT.PUT_LINE('�����߻�'||SQLERRM);
         RETURN NULL;
   END; 
   
 (����)
   SELECT BUYER_ID,
          BUYER_NAME,
          FN_PROD_INFO(BUYER_ID)
     FROM BUYER;
   
 (��뿹)ȸ����ȣ�� �Է¹޾� ȸ������ ����ϴ� �Լ� �ۼ�
   SELECT MEM_ID,
          MEM_NAME
     FROM MEMBER;
 
   CREATE OR REPLACE FUNCTION FN_MEM_NAME(
     P_MID IN MEMBER.MEM_ID%TYPE)
     RETURN MEMBER.MEM_NAME%TYPE
   IS
     V_NAME MEMBER.MEM_NAME%TYPE;
   BEGIN
     SELECT MEM_NAME INTO V_NAME
       FROM MEMBER
      WHERE MEM_ID=P_MID; 
     RETURN V_NAME; 
   END;
   
 (����)
   SELECT MEM_ID AS ȸ����ȣ,
          FN_MEM_NAME(MEM_ID) AS ȸ����
     FROM MEMBER;     
 