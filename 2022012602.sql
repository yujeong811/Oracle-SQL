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
   
   
   
   
   
   
   
   
   